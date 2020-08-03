#!/usr/bin/env python
# -*- coding: utf-8 -*-


from __future__ import print_function

import os
import glob
import subprocess
import time
import datetime

import numpy as np
import math

import pcraster as pcr

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

    # read the global map of subdomain masks
    global_clone_map = 


    # read the subdomain mask

    
    for nr in areas[0:]:
        
        # set to the global clone map
        pcr.setclone()
        
        mask = outMask == nr
        xmin, ymin, xmax, ymax = boundingBox(mask)
        
        # make the clone map using mapattr 
        cmd = "mapattr -p "
        
        # set to the clone map
        
        # read from the global map of subdomain masks
        clone_landmask = vos.
        clone_landmask = pcr.ifthen(clone_landmask, clone_landmask)
        pcr.report()
        


    
        
if __name__ == '__main__':
    sys.exit(main())

