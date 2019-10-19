#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import sys
import shutil

import pcraster_to_netcdf as pcr2nc

def main():
    
    source_path = "/scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_10_beta_1/"
    
    target_path = "/scratch/depfg/sutan101/data/pcrglobwb2_input_release/develop_complete_set_for_opendap/"
    
    # about os.walk, see https://www.tutorialspoint.com/python/os_walk.htm

    for roots, dirs, files in os.walk(source_path):

        # preparing directories
        for directory in dirs:
            source_directory = os.path.join(roots, directory)
            target_directory = source_directory.replace(source_path, target_path)
            if os.path.exists(target_directory): shutil.rmtree(target_directory)
            os.makedirs(target_directory)
            print(target_directory)

        print(" ")

        for file_name in files:
            
            # get the full path of source
            source_file_name = os.path.join(roots, file_name)
            print(source_file_name)
            
            # get target file_name
            target_file_name = source_file_name.replace(source_path, target_path)

            # make sure that the output directory is ready
            target_directory = os.path.dirname(source_file_name).replace(source_path, target_path)
            if os.path.exists(target_directory) == False: os.makedirs(target_directory)

            #~ # - go to the target directory - not necessary
            #~ os.chdir(target_directory)
            
            if target_file_name.endswith(".nc") or target_file_name.endswith(".nc4"):

                # for netcdf files

                # - rename ".nc4" to "nc" (the standard extension of netcdf file is ".nc")
                if target_file_name.endswith(".nc4"): target_file_name = target_file_name[:-1]

                #~ # for netcdf files, just copy
                #~ shutil.copy(source_file_name, target_file_name)

                # for netcdf files, compress them using cdo (edwin prefers cdo as it includes 'history')
                cmd_line = 'cdo -L -z zip -f nc4 -copy ' + source_file_name + " " + target_file_name

                #~ # - alternative: using nco
                #~ cmd_line = 'nccopy -k netCDF-4 -d1 -u ' + source_file_name + " " + target_file_name

                print(cmd_line)
                os.system(cmd_line)
            
            elif target_file_name.endswith(".map"):  

                # for pcraster map files
                
                # first copy them
                shutil.copy(source_file_name, target_file_name)

                # then, convert them to netcdf
                target_file_name = target_file_name[:-4] + ".nc"
                pcr2nc.convert_pcraster_to_netcdf(input_pcr_map_file = source_file_name,\
                                                  output_netcdf_file = target_file_name)
            
            else:
                # for other files, just copy
                shutil.copy(source_file_name, target_file_name)

            print(target_file_name)


            print(" ")

    print("Done!")                          
                                        

if __name__ == '__main__':
    sys.exit(main())
