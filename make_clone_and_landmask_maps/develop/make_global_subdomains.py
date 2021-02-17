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
    
def spatialInterpolation2PCR(fieldArray, pcrType, MV):
	#-interpolates the field array to the full extent
	field = pcr.numpy2pcr(pcrType, fieldArray, MV)
	cellID = pcr.nominal(pcr.uniqueid(pcr.defined(field)))
	zoneID = pcr.spreadzone(cellID,0,1)
	if pcrType == pcr.Scalar:
		field = pcr.areaaverage(field,zoneID)
	else:
		field = pcr.areamajority(field,zoneID)
	return field

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
# - PCR-GLOBWB ldd at 6 arcmin, used in the Ulysses project
global_landmask_06min_file = "/scratch/depfg/sutan101/data/pcrglobwb_input_ulysses/develop/global_06min/cloneMaps/global_land_mask/version_2020-08-11/land_mask_only.map"
# - ldd hydrosheds at 30sec
global_landmask_30sec_file = "/scratch/depfg/sutan101/data/global_ldd_reservoirs_and_lakes_before_data_lost_on_eejit/lddsound_30sec_version_202005XX.map"
# - merit DEM at 3 sec; yet to represent this and to avoid to big files, we can use its upscaled version 
global_landmask_03sec_file = "/scratch/depfg/sutan101/data/merit_dem/merit_dem_03sec/virtual_raster_03sec/average_30min/average_30min_from_elevation_merit_dem_03sec.tif"


# original ldd and clone at 30min resolution
global_ldd_30min_inp_file = "/scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_30min/routing/ldd_and_cell_area/lddsound_30min.map"


# output_folder
out_folder = "/scratch/depfg/sutan101/make_global_subdomains/version_2021-02-17/general_subdomains_using_threshold_of_25_cells/"


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
                                      output_map_file = "landmask_30min_only.map")
    # - based on the 05min input     
    landmask_05min = define_landmask(input_file = global_landmask_05min_file,\
                                      clone_map_file = global_ldd_30min_inp_file,\
                                      output_map_file = "landmask_05min_only.map")
    # - based on the 06min input     
    landmask_06min = define_landmask(input_file = global_landmask_06min_file,\
                                      clone_map_file = global_ldd_30min_inp_file,\
                                      output_map_file = "landmask_06min_only.map")
    # - based on the 30sec input     
    landmask_30sec = define_landmask(input_file = global_landmask_30sec_file,\
                                      clone_map_file = global_ldd_30min_inp_file,\
                                      output_map_file = "landmask_30sec_only.map")
    # - based on the 30sec input     
    landmask_03sec = define_landmask(input_file = global_landmask_03sec_file,\
                                      clone_map_file = global_ldd_30min_inp_file,\
                                      output_map_file = "landmask_03sec_only.map")
    #
    # - merge all landmasks
    landmask = pcr.cover(landmask_30min, landmask_05min, landmask_06min, landmask_30sec, landmask_03sec)
    pcr.report(landmask, "global_landmask_extended_30min.map")
    # ~ pcr.aguila(landmask)
    

    # extend ldd
    print("extend/define the ldd") 
    ldd_map = pcr.readmap(global_ldd_30min_inp_file)
    ldd_map = pcr.ifthen(landmask, pcr.cover(ldd_map, pcr.ldd(5)))
    pcr.report(ldd_map, "global_ldd_extended_30min.map")
    # ~ pcr.aguila(ldd_map)

    # catchment map and size
    catchment_map = pcr.catchment(ldd_map, pcr.pit(ldd_map))
    catchment_size = pcr.areatotal(pcr.spatial(pcr.scalar(1.0)), catchment_map)
    # ~ pcr.aguila(catchment_size)

    # identify small islands
    print("identify small islands") 
    # - maps of islands smaller than 15000 cells (at half arc degree resolution) 
    island_map  = pcr.ifthen(landmask, pcr.clump(pcr.defined(ldd_map)))
    island_size = pcr.areatotal(pcr.spatial(pcr.scalar(1.0)), island_map)
    island_map  = pcr.ifthen(island_size < 15000., island_map)
    # ~ # - use catchments (instead of islands)
    # ~ island_map  = catchment_map
    # ~ island_size = catchment_size 
    # ~ island_map  = pcr.ifthen(island_size < 10000., island_map)
    # - sort from the largest island
    # -- take one cell per island as a representative
    island_map_rep_size = pcr.ifthen(pcr.areaorder(island_size, island_map) == 1.0, island_size)
    # -- sort from the largest island
    island_map_rep_ids  = pcr.areaorder(island_map_rep_size*-1.00, pcr.ifthen(pcr.defined(island_map_rep_size), pcr.nominal(1.0)))
    # -- map of smaller islands, sorted from the largest one
    island_map = pcr.areamajority(pcr.nominal(island_map_rep_ids), island_map)
    
    # identify the biggest island for every group of small islands within a certain window (arcdeg cells)
    print("the biggest island for every group of small islands") 
    large_island_map  = pcr.ifthen(pcr.scalar(island_map) == pcr.windowminimum(pcr.scalar(island_map), 15.), island_map)
    # ~ pcr.aguila(large_island_map)
    

    # identify big catchments
    print("identify large catchments") 
    catchment_map = pcr.catchment(ldd_map, pcr.pit(ldd_map))
    catchment_size = pcr.areatotal(pcr.spatial(pcr.scalar(1.0)), catchment_map)

    # ~ # - identify all large catchments with size >= 50 cells (at the resolution of 30 arcmin) = 50 x (50^2) km2 = 125000 km2
    # ~ large_catchment_map = pcr.ifthen(catchment_size >= 50, catchment_map)
    # ~ # - identify all large catchments with size >= 10 cells (at the resolution of 30 arcmin)
    # ~ large_catchment_map = pcr.ifthen(catchment_size >= 10, catchment_map)
    # ~ # - identify all large catchments with size >= 5 cells (at the resolution of 30 arcmin)
    # ~ large_catchment_map = pcr.ifthen(catchment_size >= 5, catchment_map)
    # ~ # - identify all large catchments with size >= 20 cells (at the resolution of 30 arcmin)
    # ~ large_catchment_map = pcr.ifthen(catchment_size >= 20, catchment_map)

    # - identify all large catchments with size >= 25 cells (at the resolution of 30 arcmin)
    large_catchment_map = pcr.ifthen(catchment_size >= 25, catchment_map)

    # - give the codes that are different than islands
    large_catchment_map = pcr.nominal(pcr.scalar(large_catchment_map) + 10.*vos.getMinMaxMean(pcr.scalar(large_island_map))[1])


    # merge biggest islands and big catchments
    print("merge large catchments and islands") 
    large_catchment_and_island_map = pcr.cover(large_catchment_map, large_island_map)
    # ~ large_catchment_and_island_map = pcr.cover(large_island_map, large_catchment_map)
    large_catchment_and_island_map_size = pcr.areatotal(pcr.spatial(pcr.scalar(1.0)), large_catchment_and_island_map)

    
    # - sort from the largest one
    # -- take one cell per island as a representative
    large_catchment_and_island_map_rep_size = pcr.ifthen(pcr.areaorder(large_catchment_and_island_map_size, large_catchment_and_island_map) == 1.0, large_catchment_and_island_map_size)
    # -- sort from the largest
    large_catchment_and_island_map_rep_ids  = pcr.areaorder(large_catchment_and_island_map_rep_size*-1.00, pcr.ifthen(pcr.defined(large_catchment_and_island_map_rep_size), pcr.nominal(1.0)))
    # -- map of largest catchments and islands, sorted from the largest one
    large_catchment_and_island_map = pcr.areamajority(pcr.nominal(large_catchment_and_island_map_rep_ids), large_catchment_and_island_map)
    # ~ pcr.report(large_catchment_and_island_map, "large_catchments_and_islands.map")


    # ~ # perform cdo fillmiss2 in order to merge the small catchments to the nearest large catchments
    # ~ print("spatial interpolation/extrapolation using cdo fillmiss2 to get initial subdomains") 
    # ~ cmd = "gdal_translate -of NETCDF large_catchments_and_islands.map large_catchments_and_islands.nc"
    # ~ print(cmd); os.system(cmd)
    # ~ cmd = "cdo fillmiss2 large_catchments_and_islands.nc large_catchments_and_islands_filled.nc"
    # ~ print(cmd); os.system(cmd)
    # ~ cmd = "gdal_translate -of PCRaster large_catchments_and_islands_filled.nc large_catchments_and_islands_filled.map"
    # ~ print(cmd); os.system(cmd)
    # ~ cmd = "mapattr -c " + global_ldd_30min_inp_file + " " + "large_catchments_and_islands_filled.map"
    # ~ print(cmd); os.system(cmd)
    # ~ # - initial subdomains
    # ~ subdomains_initial = pcr.nominal(pcr.readmap("large_catchments_and_islands_filled.map"))
    # ~ subdomains_initial = pcr.areamajority(subdomains_initial, catchment_map)
    # ~ pcr.aguila(subdomains_initial)
    

    # spatial interpolation/extrapolation in order to merge the small catchments to the nearest large catchments
    print("spatial interpolation/extrapolation to get initial subdomains") 
    field  = large_catchment_and_island_map
    cellID = pcr.nominal(pcr.uniqueid(pcr.defined(field)))
    zoneID = pcr.spreadzone(cellID,0,1)
    field  = pcr.areamajority(field,zoneID)
    subdomains_initial = field
    subdomains_initial = pcr.areamajority(subdomains_initial, catchment_map)
    pcr.aguila(subdomains_initial)

    pcr.report(subdomains_initial, "global_subdomains_30min_initial.map")

    print(str(int(vos.getMinMaxMean(pcr.scalar(subdomains_initial))[0])))
    print(str(int(vos.getMinMaxMean(pcr.scalar(subdomains_initial))[1])))

    # ~ print(str(int(vos.getMinMaxMean(pcr.scalar(subdomains_initial_clump))[0])))
    # ~ print(str(int(vos.getMinMaxMean(pcr.scalar(subdomains_initial_clump))[1])))

    
    print("Checking all subdomains, avoid too large subdomains") 

    num_of_masks = int(vos.getMinMaxMean(pcr.scalar(subdomains_initial))[1])

    # clone code that will be assigned
    assigned_number = 0
    
    subdomains_final = pcr.ifthen(pcr.scalar(subdomains_initial) < -7777, pcr.nominal(0))
    
    for nr in range(1, num_of_masks + 1, 1):

        msg = "Processing the landmask %s" %(str(nr))
        print(msg)

        mask_selected_boolean = pcr.ifthen(subdomains_initial == nr, pcr.boolean(1.0))
        
        # ~ if nr == 1: pcr.aguila(mask_selected_boolean)
        
        xmin, ymin, xmax, ymax = boundingBox(mask_selected_boolean)
        area_in_degree2 = (xmax - xmin) * (ymax - ymin)
        
        # ~ print(str(area_in_degree2))
        
        # check whether the size of bounding box is ok
        # - initial check value
        check_ok = True

        reference_area_in_degree2 = 2500.
        if area_in_degree2 > 1.50 * reference_area_in_degree2: check_ok = False
        if (xmax - xmin) > 10* (ymax - ymin): check_ok = False
        
        if check_ok == True:

            msg = "Clump is not needed."
            msg = "\n\n" +str(msg) + "\n\n"
            print(msg)

            # assign the clone code
            assigned_number = assigned_number + 1

            # update global landmask for river and land
            mask_selected_nominal = pcr.ifthen(mask_selected_boolean, pcr.nominal(assigned_number))
            subdomains_final = pcr.cover(subdomains_final, mask_selected_nominal) 
        
        if check_ok == False:
			
            msg = "Clump is needed."
            msg = "\n\n" +str(msg) + "\n\n"
            print(msg)

            # make clump
            clump_ids = pcr.nominal(pcr.clump(mask_selected_boolean))
            
            # merge clumps that are close together 
            clump_ids_window_majority = pcr.windowmajority(clump_ids, 10.0)
            clump_ids = pcr.areamajority(clump_ids_window_majority, clump_ids) 
            # ~ pcr.aguila(clump_ids)
            
            # minimimum and maximum values
            min_clump_id = int(pcr.cellvalue(pcr.mapminimum(pcr.scalar(clump_ids)),1)[0])
            max_clump_id = int(pcr.cellvalue(pcr.mapmaximum(pcr.scalar(clump_ids)),1)[0])

            for clump_id in range(min_clump_id, max_clump_id + 1, 1):
            
                msg = "Processing the clump %s of %s from the landmask %s" %(str(clump_id), str(max_clump_id), str(nr))
                msg = "\n\n" +str(msg) + "\n\n"
                print(msg)

                # identify mask based on the clump
                mask_selected_boolean_from_clump = pcr.ifthen(clump_ids == pcr.nominal(clump_id), mask_selected_boolean)
                mask_selected_boolean_from_clump = pcr.ifthen(mask_selected_boolean_from_clump, mask_selected_boolean_from_clump)

                # check whether the clump is empty
                check_mask_selected_boolean_from_clump = pcr.ifthen(mask_selected_boolean, mask_selected_boolean_from_clump)
                check_if_empty = float(pcr.cellvalue(pcr.mapmaximum(pcr.scalar(pcr.defined(check_mask_selected_boolean_from_clump))),1)[0])
                
                if check_if_empty == 0.0: 
                
                    msg = "Map is empty !"
                    msg = "\n\n" +str(msg) + "\n\n"
                    print(msg)

                else:
                
                    msg = "Map is NOT empty !"
                    msg = "\n\n" +str(msg) + "\n\n"
                    print(msg)

                    # assign the clone code
                    assigned_number = assigned_number + 1
                    
                    # update global landmask for river and land
                    mask_selected_nominal = pcr.ifthen(mask_selected_boolean_from_clump, pcr.nominal(assigned_number))
                    subdomains_final = pcr.cover(subdomains_final, mask_selected_nominal)
                    
    # ~ # kill all aguila processes if exist
    # ~ os.system('killall aguila')
    
    pcr.aguila(subdomains_final)

    print("")
    print("")
    print("")

    print("The subdomain map is READY.") 

    pcr.report(subdomains_final, "global_subdomains_30min_final.map")

    num_of_masks = int(vos.getMinMaxMean(pcr.scalar(subdomains_final))[1])
    print(num_of_masks)

    print("")
    print("")
    print("")

    for nr in range(1, num_of_masks + 1, 1):

        mask_selected_boolean = pcr.ifthen(subdomains_final == nr, pcr.boolean(1.0))
        
        xmin, ymin, xmax, ymax = boundingBox(mask_selected_boolean)
        area_in_degree2 = (xmax - xmin) * (ymax - ymin)
        
        print(str(nr) + " ; " + str(area_in_degree2) + " ; " + str((xmax - xmin)) + " ; " + str((ymax - ymin)))

    print("")
    print("")
    print("")

    print("Number of subdomains: " + str(num_of_masks))

    print("")
    print("")
    print("")    

    # spatial extrapolation in order to cover the entire map
    print("spatial interpolation/extrapolation to cover the entire map") 
    field  = subdomains_final
    cellID = pcr.nominal(pcr.uniqueid(pcr.defined(field)))
    zoneID = pcr.spreadzone(cellID,0,1)
    field  = pcr.areamajority(field,zoneID)
    subdomains_final_filled = field
    pcr.aguila(subdomains_final_filled)

    pcr.report(subdomains_final_filled, "global_subdomains_30min_final_filled.map")
    


        
if __name__ == '__main__':
    sys.exit(main())
