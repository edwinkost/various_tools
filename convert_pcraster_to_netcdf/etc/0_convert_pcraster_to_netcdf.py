#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import sys

import pcraster as pcr

# utility modules:
import virtualOS as vos
import outputNetcdf as out_nc


def main():
    
    # some options (default)
    netcdf_global_attributes = None
    netcdf_format = "NETCDF4"
    netcdf_zlib_option = False
    netcdf_y_orientation_from_top_bottom = False

    # for this version, we still do not use time dimension
    date_input = None
    time_input = None

    # input and output file names based on the command line arguments
    input_pcr_map_file = str(sys.argv[1])
    output_netcdf_file = input_pcr_map_file + ".nc"
    if len(sys.argv) > 2: output_netcdf_file = str(sys.argv[2])
    
    # set also the variable name and unit
    variable_unit = "unknown"
    if len(sys.argv) > 3: variable_unit = sys.argv[3]
    variable_name = os.path.basename(input_pcr_map_file)
    if len(sys.argv) > 4: variable_name = sys.argv[4]

    # read the pcraster map
    input_pcr_map = pcr.readmap(input_pcr_map_file)
    
    # converting it to a netcdf file
    # - initiate an object to write a netcdf file
    output_netcdf = out_nc.OutputNetcdf(inputMapFileName = input_pcr_map_file, \
                                        netcdf_format = netcdf_format,\
                                        netcdf_zlib = netcdf_zlib_option,\
                                        netcdf_attribute_dict = netcdf_global_attributes,\
                                        netcdf_attribute_description = None,\
                                        netcdf_y_orientation_from_top_bottom = netcdf_y_orientation_from_top_bottom)
    # - create the netcdf file
    output_netcdf.createNetCDF(ncFileName = output_netcdf_file, \
                               varName    = variable_name, \
                               varUnits   = variable_unit, \
                               date       = None
                               )                                    
    # - write to the netcdf file
    output_netcdf.data2NetCDF(ncFileName   = output_netcdf_file, \
                              shortVarName = variable_name, 
                              varField     = pcr.pcr2numpy(input_pcr_map, vos.MV), 
                              timeStamp    = None, 
                              posCnt       = None
                              )
    
    print("Done!")                          
                                        

if __name__ == '__main__':
    sys.exit(main())
