#!/usr/bin/env python
# -*- coding: utf-8 -*-


from __future__ import print_function

import os
import sys
import glob
import subprocess
import time
import datetime
import shutil

import numpy as np
import math

import pcraster as pcr
import virtualOS as vos


def boundingBox(pcrmap):
    ''' derive the bounding box for a map, return xmin,ymin,xmax,ymax '''
    bb = []
    xcoor = pcr.xcoordinate(pcrmap)
    ycoor = pcr.ycoordinate(pcrmap)
    xmin  = pcr.cellvalue(pcr.mapminimum(xcoor), 1, 1)[0]
    xmax  = pcr.cellvalue(pcr.mapmaximum(xcoor), 1, 1)[0]
    ymin  = pcr.cellvalue(pcr.mapminimum(ycoor), 1, 1)[0]
    ymax  = pcr.cellvalue(pcr.mapmaximum(ycoor), 1, 1)[0]
    return [math.floor(xmin), math.floor(ymin), math.ceil(xmax), math.ceil(ymax)]
    

def define_landmask(input_file, clone_map_file, output_map_file):

    # define the landmask based on the input     
    cmd = "gdalwarp -tr 0.5 0.5 -te -180 -90 180 90 -r max " + str(input_file) + " " + output_map_file + ".tif"
    print(cmd); os.system(cmd)
    cmd = "gdal_translate -of PCRaster " + output_map_file + ".tif " + output_map_file
    print(cmd); os.system(cmd)
    cmd = "mapattr -c " + clone_map_file + " " + output_map_file
    print(cmd); os.system(cmd)
    cmd = "rm " + output_map_file + ".*"
    print(cmd); os.system(cmd)
    
    landmask = pcr.defined(pcr.readmap(output_map_file))
    landmask = pcr.ifthen(landmask, landmask)
    # ~ pcr.aguila(landmask)
    
    return landmask



# input files to define the landmask
# - PCR-GLOBWB ldd at 5 arcmin and 30 arcmin, from the runs made in Sutanudjaja et al., 2018
global_landmask_30min_file = "/scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_30min/routing/ldd_and_cell_area/lddsound_30min.map"
global_landmask_05min_file = "/scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/routing/ldd_and_cell_area/lddsound_05min.map"
# - ldd hydrosheds at 30sec
global_landmask_30sec_file = "/scratch/depfg/sutan101/data/global_ldd_reservoirs_and_lakes_before_data_lost_on_eejit/lddsound_30sec_version_202005XX.map"
# - merit DEM at 3 sec; yet to represent this and to avoid to big files, we can use its upscaled version 
global_landmask_03sec_file = "/scratch/depfg/sutan101/data/merit_dem/merit_dem_03sec/virtual_raster_03sec/average_30min/average_30min_from_elevation_merit_dem_03sec.tif"


# original ldd and clone at 30min resolution
global_ldd_30min_inp_file = "/scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_30min/routing/ldd_and_cell_area/lddsound_30min.map"


# output_folder
out_folder = "/scratch/depfg/sutan101/make_clone_maps/30min_test/"


def main():

    # output folder (and tmp folder)
    clean_out_folder = True
    if os.path.exists(out_folder): 
        if clean_out_folder:
            shutil.rmtree(out_folder)
            os.makedirs(out_folder)
    else:
        os.makedirs(out_folder)
    os.chdir(out_folder)    
    os.system("pwd")


    # set the clone map
    print("set the clone") 
    pcr.setclone(global_ldd_30min_inp_file)
    

    # define the landmask
    print("define the landmask") 
    # - based on the 30min input     
    landmask_30min = define_landmask(input_file = global_landmask_30min_file,\
                                      clone_map_file = global_ldd_30min_inp_file,\
                                      output_map_file = "landmask_30min_only")
    # - based on the 05min input     
    landmask_05min = define_landmask(input_file = global_landmask_05min_file,\
                                      clone_map_file = global_ldd_30min_inp_file,\
                                      output_map_file = "landmask_05min_only")
    # - based on the 30sec input     
    landmask_30sec = define_landmask(input_file = global_landmask_30sec_file,\
                                      clone_map_file = global_ldd_30min_inp_file,\
                                      output_map_file = "landmask_30sec_only")
    # - based on the 30sec input     
    landmask_03sec = define_landmask(input_file = global_landmask_03sec_file,\
                                      clone_map_file = global_ldd_30min_inp_file,\
                                      output_map_file = "landmask_03sec_only")
    #
    # - merge all landmasks
    landmask = pcr.cover(landmask_30min, landmask_05min, landmask_30sec, landmask_03sec)
    pcr.report(landmask, "global_landmask_30min_final.map")
    # ~ pcr.aguila(landmask)
    

    # extend ldd
    print("extend/define the ldd") 
    ldd_map = pcr.readmap(global_ldd_30min_inp_file)
    ldd_map = pcr.ifthen(landmask, pcr.cover(ldd_map, pcr.ldd(5)))
    pcr.report(ldd_map, "global_ldd_final.map")
    # ~ pcr.aguila(ldd_map)


    # identify small islands
    print("identify small islands") 
    # - maps of islands smaller than 100 cells (at half arc degree resolution) 
    island_map  = pcr.ifthen(landmask, pcr.clump(pcr.defined(ldd_map)))
    island_size = pcr.areatotal(pcr.spatial(pcr.scalar(1.0)), island_map)
    island_map  = pcr.ifthen(island_size < 100., island_map)
    # - sort from the largest island
    # -- take one cell per island as a representative
    island_map_rep_size = pcr.ifthen(pcr.areaorder(island_size, island_map) == 1.0, island_size)
    # -- sort from the largest island
    island_map_rep_ids  = pcr.areaorder(island_map_rep_size*-1.00, pcr.ifthen(pcr.defined(island_map_rep_size), pcr.nominal(1.0)))
    # -- map of smaller islands, sorted from the largest one
    island_map = pcr.areamajority(pcr.nominal(island_map_rep_ids), island_map)
    
    # identify the biggest island for every group of small islands within the windows 10x10 arcdeg cells
    large_island_map  = pcr.ifthen(pcr.scalar(island_map) == pcr.windowminimum(pcr.scalar(island_map), 10.), island_map)
    pcr.aguila(large_island_map)
    

    # identify big catchments
    catchment_map = pcr.catchment(ldd_map, pcr.pit(ldd_map))
    catchment_size = pcr.areatotal(pcr.spatial(pcr.scalar(1.0)), catchment_map)
    # - identify all large catchments with size >= 50 cells (at the resolution of 30 arcmin) = 50 x (50^2) km2 = 125000 km2
    large_catchment_map = pcr.ifthen(catchment_size >= 50, catchment_map)
    # - give the codes that are different than islands
    large_catchment_map = pcr.nominal(pcr.scalar(large_catchment_map) + 10.*vos.getMinMaxMean(pcr.scalar(large_island_map))[1])


    # merge biggest islands and big catchments
    large_catchment_and_island_map = pcr.cover(large_catchment_map, large_island_map)
    large_catchment_and_island_map_size = pcr.areatotal(pcr.spatial(pcr.scalar(1.0)), large_catchment_and_island_map)
    # - sort from the largest one
    # -- take one cell per island as a representative
    large_catchment_and_island_map_rep_size = pcr.ifthen(pcr.areaorder(large_catchment_and_island_map_size, large_catchment_and_island_map) == 1.0, large_catchment_and_island_map_size)
    # -- sort from the largest
    large_catchment_and_island_map_rep_ids  = pcr.areaorder(large_catchment_and_island_map_rep_size*-1.00, pcr.ifthen(pcr.defined(large_catchment_and_island_map_rep_size), pcr.nominal(1.0)))
    # -- map of largest catchments and islands, sorted from the largest one
    large_catchment_and_island_map = pcr.areamajority(pcr.nominal(large_catchment_and_island_map_rep_ids), large_catchment_and_island_map)
    pcr.report(large_catchment_and_island_map, "large_catchments_and_islands.map")


    # perform cdo fillmiss2 in order to merge the small catchments to the nearest large catchments
    cmd = "gdal_translate -of NETCDF large_catchments_and_islands.map large_catchments_and_islands.nc"
    print(cmd); os.system(cmd)
    cmd = "cdo fillmiss2 large_catchments_and_islands.nc large_catchments_and_islands_filled.nc"
    print(cmd); os.system(cmd)
    cmd = "gdal_translate -of PCRaster large_catchments_and_islands_filled.nc large_catchments_and_islands_filled.map"
    print(cmd); os.system(cmd)
    cmd = "mapattr -c " + global_ldd_30min_inp_file + " " + "large_catchments_and_islands_filled.map"
    print(cmd); os.system(cmd)
    # - initial subdomains
    subdomains_initial = pcr.nominal(pcr.readmap("large_catchments_and_islands_filled.map"))
    subdomains_initial = pcr.areamajority(subdomains_initial, catchment_map)
    pcr.aguila(subdomains_initial)
    
    pcr.report(subdomains_initial, "subdomains_initial.map")

    print(str(int(vos.getMinMaxMean(pcr.scalar(subdomains_initial))[0])))
    print(str(int(vos.getMinMaxMean(pcr.scalar(subdomains_initial))[1])))

    # ~ print(str(int(vos.getMinMaxMean(pcr.scalar(subdomains_initial_clump))[0])))
    # ~ print(str(int(vos.getMinMaxMean(pcr.scalar(subdomains_initial_clump))[1])))


    # ~ # - remove temporay files (not used)
    # ~ cmd = "rm global_catchment_ge_50_cells_filled*"
    # ~ print(cmd); os.system(cmd)


    # ~ # clone code that will be assigned
    # ~ assigned_number = 0
    
    # ~ for nr in range(1, num_of_masks + 1, 1):



        
if __name__ == '__main__':
    sys.exit(main())
