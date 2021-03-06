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
    # - maps of islands smaller than 10000 cells (at half arc degree resolution) 
    island_map  = pcr.ifthen(landmask, pcr.clump(pcr.defined(ldd_map)))
    island_size = pcr.areatotal(pcr.spatial(pcr.scalar(1.0)), island_map)
    island_map  = pcr.ifthen(island_size < 10000., island_map)
    
    UNTIL_THIS
    
    # identify the biggest island for every group of small islands within the windows 10x10 arcdeg cells

    # - sort from the largest catchment
    catchment_pits_boolean = pcr.ifthen(pcr.scalar(pcr.pit(ldd_map)) > 0.0, pcr.boolean(1.0))
    catchment_pits_boolean = pcr.ifthen(catchment_pits_boolean, catchment_pits_boolean)
    pcr.aguila(catchment_pits_boolean)
    catchment_map = pcr.nominal(pcr.areaorder(catchment_size * -1.0, pcr.nominal(catchment_pits_boolean)))



    island_map  = pcr.ifthen(island_size == pcr.windowmaximum(island_size, 10.), island_map)
    pcr.aguila(island_map)


    

    # identify big catchments
    
    
    # merge biggest islands and big catchments 
    
    
    # make catchment and island map
    print("make catchment and island map")

    # - catchment map
    catchment_map = pcr.catchment(ldd_map, pcr.pit(ldd_map))
    pcr.report(catchment_map, "global_catchment_not_sorted.map")
    os.system("mapattr -p global_catchment_not_sorted.map")
    num_of_catchments = int(vos.getMinMaxMean(pcr.scalar(catchment_map))[1])

    # - maps of islands smaller than 10000 cells 
    island_map  = pcr.ifthen(landmask, pcr.clump(pcr.defined(ldd_map)))
    island_size = pcr.areatotal(pcr.spatial(pcr.scalar(1.0)), island_map)
    island_map  = pcr.ifthen(island_size < 10000., island_map)
    island_map  = pcr.nominal(pcr.scalar(pcr.ifthen(landmask, pcr.clump(island_map))) + pcr.scalar(num_of_catchments)*100.)
    pcr.aguila(island_map)
    
    island_size = pcr.ifthen(pcr.defined(island_map), island_size)
    
    island_map  = pcr.ifthen(island_size == pcr.windowmaximum(island_size, 10.), island_map)
    pcr.aguila(island_map)
    
    catchment_map = pcr.cover(island_map, catchment_map)
    catchment_size = pcr.areatotal(pcr.spatial(pcr.scalar(1.0)), catchment_map)
    
    # - calculate the size
    catchment_size = pcr.areatotal(pcr.spatial(pcr.scalar(1.0)), catchment_map)
    # - sort from the largest catchment
    catchment_pits_boolean = pcr.ifthen(pcr.scalar(pcr.pit(ldd_map)) > 0.0, pcr.boolean(1.0))
    catchment_pits_boolean = pcr.ifthen(catchment_pits_boolean, catchment_pits_boolean)
    pcr.aguila(catchment_pits_boolean)
    catchment_map = pcr.nominal(pcr.areaorder(catchment_size * -1.0, pcr.nominal(catchment_pits_boolean)))
    catchment_map = pcr.catchment(ldd_map, catchment_map)
    pcr.report(catchment_map, "global_catchment_final.map")
    os.system("mapattr -p global_catchment_final.map")
    # - calculate the size
    catchment_size = pcr.areatotal(pcr.spatial(pcr.scalar(1.0)), catchment_map)
    pcr.report(catchment_size, "global_catchment_size_in_number_of_cells.map")
    
    # number of catchments
    num_of_catchments = int(vos.getMinMaxMean(pcr.scalar(catchment_map))[1])
    
    # size of the largest catchment
    catchment_size_max = vos.getMinMaxMean(catchment_size)[1]
    print("")
    print(str(float(catchment_size_max)))
    print("")
     
    
    # identify all large catchments with size >= 50 cells (at the resolution of 30 arcmin) = 50 x (50^2) km2 = 125000 km2
    print("identify catchments with the minimum size of 50 cells")
    catchment_map_ge_50 = pcr.ifthen(catchment_size >= 50, catchment_map)
    pcr.report(catchment_map_ge_50, "global_catchment_ge_50_cells.map")
    
    # include the island
    catchment_map_ge_50 = pcr.cover(island_map, catchment_map_ge_50)  
     

    # perform cdo fillmiss2 in order to merge the small catchments to the nearest large catchments
    cmd = "gdal_translate -of NETCDF global_catchment_ge_50_cells.map global_catchment_ge_50_cells.nc"
    print(cmd); os.system(cmd)
    cmd = "cdo fillmiss2 global_catchment_ge_50_cells.nc global_catchment_ge_50_cells_filled.nc"
    print(cmd); os.system(cmd)
    cmd = "cdo fillmiss2 global_catchment_ge_50_cells_filled.nc global_catchment_ge_50_cells_filled.nc"
    print(cmd); os.system(cmd)
    cmd = "gdal_translate -of PCRaster global_catchment_ge_50_cells_filled.nc global_catchment_ge_50_cells_filled.map"
    print(cmd); os.system(cmd)
    cmd = "mapattr -c " + global_ldd_30min_inp_file + " " + "global_catchment_ge_50_cells_filled.map"
    print(cmd); os.system(cmd)
    # - initial subdomains
    subdomains_initial = pcr.nominal(pcr.readmap("global_catchment_ge_50_cells_filled.map"))
    subdomains_initial = pcr.areamajority(subdomains_initial, catchment_map)
    pcr.aguila(subdomains_initial)
    # - initial subdomains clump
    subdomains_initial_clump = pcr.clump(subdomains_initial)
    pcr.aguila(subdomains_initial_clump)

    print(str(int(vos.getMinMaxMean(pcr.scalar(subdomains_initial))[0])))
    print(str(int(vos.getMinMaxMean(pcr.scalar(subdomains_initial))[1])))

    print(str(int(vos.getMinMaxMean(pcr.scalar(subdomains_initial_clump))[0])))
    print(str(int(vos.getMinMaxMean(pcr.scalar(subdomains_initial_clump))[1])))


    # - remove temporay files (not used)
    cmd = "rm global_catchment_ge_50_cells_filled*"
    print(cmd); os.system(cmd)


    # clone code that will be assigned
    assigned_number = 0
    
    # ~ for nr in range(1, num_of_masks + 1, 1):



        
if __name__ == '__main__':
    sys.exit(main())
