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
    cmd = "gdalwarp -tr 0.5 0.5 -te -180 -90 180 -90 -r max " + str(global_landmask_30min) + " " + output_map_file + ".tif"
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
# - ldd hydrosheds at 30sec
# - MERIT DEM
global_landmask_30min_file = "/scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_30min/routing/ldd_and_cell_area/lddsound_30min.map"
global_landmask_05min_file = "/scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/routing/ldd_and_cell_area/lddsound_05min.map"
global_landmask_30sec_file = "/scratch/depfg/sutan101/data/global_ldd_reservoirs_and_lakes_before_data_lost_on_eejit/lddsound_30sec_version_202005XX.map"
global_landmask_03sec_file = "/scratch/depfg/sutan101/data/merit_dem/merit_dem_03sec/virtual_raster_03sec/"


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
    landmask = cover(landmask_30min, landmask_05min, landmask_30sec, landmask_03sec)
    pcr.report(landmask, "global_landmask.map")
    pcr.aguila(landmask)
    
        
if __name__ == '__main__':
    sys.exit(main())
