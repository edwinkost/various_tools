#!/usr/bin/env python
# -*- coding: utf-8 -*-


from __future__ import print_function

import os
import sys
import glob
import subprocess
import time
import datetime

import numpy as np
import math

import pcraster as pcr
import virtualOS as vos

def boundingBox(pcrmap):
    ''' derive the bounding box for a map, return xmin,ymin,xmax,ymax '''
    bb = []
    xcoor = pcr.xcoordinate(pcrmap)
    ycoor = pcr.ycoordinate(pcrmap)
    xmin  = pcr.cellvalue(pcr.mapminimum(xcoor),1,1)[0]
    xmax  = pcr.cellvalue(pcr.mapmaximum(xcoor),1,1)[0]
    ymin  = pcr.cellvalue(pcr.mapminimum(ycoor),1,1)[0]
    ymax  = pcr.cellvalue(pcr.mapmaximum(ycoor),1,1)[0]
    return [floor(xmin),floor(ymin),ceil(xmax),ceil(ymax)]

def main():

    # global map of subdomain masks
    global_clone_map = "/scratch/mo/nest/ulysses/data/edwin/clone_maps/version_2020-08-03/source_from_stephan/clone_all_maps/clone_ulysses_06min_global.map"

    # list of subdomain mask files (all in nc files)
    num_of_masks = 54
    subdomain_nc = "/scratch/mo/nest/ulysses/data/edwin/clone_maps/version_2020-08-03/source_from_stephan/subdomain_mask/subdomain_land_%s.nc"

    # output folder (and tmp folder)
    out_folder   = "/scratch/mo/nest/ulysses/data/edwin/clone_maps/version_2020-08-03/pcraster_maps/"
    clean_out_folder = False
    if os.path.exists(out_folder): 
        if clean_out_folder:
            shutil.rmtree(out_folder)
            os.makedirs(out_folder)
    else:
        os.makedirs(out_folder)
    
    for nr in range(1, num_of_masks + 1, 1):
        
        # set to the global clone map
        pcr.setclone(global_clone_map)
        
        # read nc file (and convert it to pcraster)
        subdomain_nc_file = subdomain_nc %(str(nr))
        # ~ mask_selected = vos.readPCRmapClone(v = subdomain_nc_file,\
                                            # ~ cloneMapFileName = global_clone_map,\
                                            # ~ tmpDir = None)
        mask_selected = vos.netcdf2PCRobjCloneWithoutTime(ncFile  = subdomain_nc_file, \
                                                          varName = "automatic",\
                                                          cloneMapFileName  = None,\
                                                          LatitudeLongitude = False,\
                                                          specificFillValue = "NaN",\
                                                          absolutePath = None)
        
        mask_selected_boolean = pcr.defined(mask_selected)
        mask_selected_boolean = pcr.ifthen(mask_selected, mask_selected)
        
        # get the bounding box
        xmin, ymin, xmax, ymax = boundingBox(mask_selected_boolean)
        
        # cellsize 
        cellsize = vos.getMapAttributes(global_clone_map, cellsize)
        num_rows = int(round(ymax - ymin) / cellsize)
        num_cols = int(round(xmax - xmin) / cellsize)
        
        # make the clone map using mapattr 
        clonemap_mask_file = "clonemap_mask_%s.map" %(str(nr))
        # - example: mapattr -s -R 19 -C 68 -B -P yb2t -x 12 -y -14.02 -l 0.8 mask2.map
        cmd = "mapattr -s -R %s -C %s -B -P ybs2t -x %s -y %s -l %s %s" %(str(num_rows), str(num_cols), str(xmin), str(ymax))
        print(cmd)
        os.system(cmd)
        
        # set the landmask 
        pcr.setclone(clonemap_mask_file)
        landmask = vos.readPCRmapClone(v = subdomain_nc_file,\
                                           cloneMapFileName = clonemap_mask_file,\
                                           tmpDir = None)
        landmask_boolean = pcr.defined(landmask)
        landmask_boolean = pcr.ifthen(landmask, landmask)
                                           
        # save the landmask
        pcr.report(landmask_boolean, )

    
        
if __name__ == '__main__':
    sys.exit(main())

