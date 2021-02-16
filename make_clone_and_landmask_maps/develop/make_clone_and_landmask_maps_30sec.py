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



# original ldd and clone
global_ldd_inp_file = "/scratch/depfg/sutan101/data/global_ldd_reservoirs_and_lakes_before_data_lost_on_eejit/lddsound_30sec_version_202005XX.map"

# global subdomain file
global_subdomain_file = "/scratch/depfg/sutan101/make_global_subdomains/version_2021-02-16/general/global_subdomains_30min_final.map"

# output_folder
out_folder = "/scratch/depfg/sutan101/make_global_subdomains/version_2021-02-16/30sec/"


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
    pcr.setclone(global_ldd_inp_file)
    

    # define the landmask
    print("define the landmask") 
    landmask = pcr.readmap(global_ldd_inp_file)
    

    # ~ # extend ldd
    # ~ print("extend/define the ldd") 
    # ~ ldd_map = pcr.readmap(global_ldd_30min_inp_file)
    # ~ ldd_map = pcr.ifthen(landmask, pcr.cover(ldd_map, pcr.ldd(5)))
    # ~ pcr.report(ldd_map, "global_ldd_extended_30min.map")
    # ~ pcr.aguila(ldd_map)
    
    UNTIL_THIS
    
    # read global subdomains file
    global_subdomain_map = vos.


    

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

    print(num_of_masks)

        
if __name__ == '__main__':
    sys.exit(main())
