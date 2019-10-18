#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import sys

import pcraster as pcr

# utility modules:
import virtualOS as vos
import outputNetcdf as out_nc


def main():
    
    source_path = "/scratch/depfg/sutan101/pcrglobwb2_input_release/develop_complete_set_for_4tu_opendap/pcrglobwb2_input/"
    
    target_path = "/scratch/depfg/sutan101/pcrglobwb2_input_release/develop_complete_set_for_4tu_opendap_netcdf_files_only/pcrglobwb2_input/"
    
    # about os.walk, see https://www.tutorialspoint.com/python/os_walk.htm

    for roots, dirs, files in os.walk(source_path):

        # preparing directory
        for dir in dirs:
            pass

        for file_name in files:
            
            # print the full path of source
            source_file_name = os.path.join(roots, file_name)
            print(source_file_name)
            
            # target file_name
            target_file_name = source_file_name.replace(source_path, target_path)
            print(target_file_name)
    
            # for netcdf files, just copy and add some general attributes
            
            
            # for non-netcdf files, convert them to netcdf 
            

    print("Done!")                          
                                        

if __name__ == '__main__':
    sys.exit(main())
