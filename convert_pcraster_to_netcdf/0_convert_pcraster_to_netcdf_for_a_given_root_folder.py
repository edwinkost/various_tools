#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import sys

import pcraster as pcr

# utility modules:
import virtualOS as vos
import outputNetcdf as out_nc


def main():
    
    path = "/scratch/depfg/sutan101/pcrglobwb2_input_release/develop_complete_set_for_4tu_opendap/pcrglobwb2_input/"
    
    for root, dirs, files in os.walk(path):
        for file_name in files:
            
            # print the full path
            print(os.path.join(root, file_name))
            
            # print file_name only
            print file_name
            
    # about os.walk, see https://www.tutorialspoint.com/python/os_walk.htm
    
    print("Done!")                          
                                        

if __name__ == '__main__':
    sys.exit(main())
