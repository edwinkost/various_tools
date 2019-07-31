#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import sys

# utility modules:
import virtualOS as vos
import outputNetcdf as out_nc


def main():
    
    # some options (default)
    date_input = None
    time_input = None
    netcdf_global_attributes = None
    netcdf_format = "NETCDF4"
    netcdf_zlib_option = False
    netcdf_y_orientation_from_top_bottom = True

    # input and output file names based on the command line arguments
    input_pcr_map_file = str(sys.argv[1])
    output_netcdf_file = str(sys.argv[2])
    
    # set also the variable name and unit
    variable_name = sys.argv[3]
    variable_unit = sys.argv[4]

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
                               )                                    
    # - write to the netcdf file                                   
                                        
                                        

if __name__ == '__main__':
    sys.exit(main())
