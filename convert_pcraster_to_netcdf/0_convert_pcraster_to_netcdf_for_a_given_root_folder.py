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
            print(os.path.join(root, name))
            print(file_name)
            
    print("Done!")                          
                                        

if __name__ == '__main__':
    sys.exit(main())
