#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
import os
import sys
import shutil
import datetime

import pcraster as pcr

from pcraster.framework import DynamicModel
from pcraster.framework import DynamicFramework

from currTimeStep import ModelTime

import ncConverter as netcdf_writer
import virtualOS as vos

#~ from pcrglobwb import PCRGlobWB

import logging
logger = logging.getLogger(__name__)

class DeterministicRunner(DynamicModel):

    def __init__(self, modelTime, input_file, input_variable_name, output_file, variable_name, variable_unit):
        DynamicModel.__init__(self)

        self.modelTime = modelTime
        
        # netcdf input file - based on PCR-GLOBWB output
        self.input_file = "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/historical/1951-2005/gfdl-esm2m/temperature_annuaAvg_output_%s-12-31_to_%s-12-31.nc"
        self.input_file = input_file

        # netcdf variable name
        self.input_variable_name = input_variable_name
        
        # output file - in netcdf format
        self.output_file = output_file
        
        # output variable name and unit 
        self.variable_name = variable_name
        self.variable_unit = variable_unit

        # preparing temporary directory
        self.temporary_directory = os.path.dirname(self.output_file) + "/tmp/"
        os.makedirs(self.temporary_directory)
        
        # clone and landmask maps
        logger.info("Set the clone and landmask maps.")
        self.clonemap_file_name = "/projects/0/dfguu/users/edwinhs/data/mekong_etc_clone/version_2018-10-22/final/clone_mekong.map"
        pcr.setclone(self.clonemap_file_name)
        landmask_file_name      = "/projects/0/dfguu/users/edwinhs/data/mekong_etc_clone/version_2018-10-22/final/mask_mekong.map"
        self.landmask = vos.readPCRmapClone(landmask_file_name, \
                                            self.clonemap_file_name, \
                                            self.temporary_directory)
        
        # pcraster input files
        # - river network map and sub-catchment map
        ldd_file_name       = "/projects/0/dfguu/data/hydroworld/PCRGLOBWB20/input5min/routing/lddsound_05min.map"
        # - cell area (unit: m2)
        cell_area_file_name = "/projects/0/dfguu/data/hydroworld/PCRGLOBWB20/input5min/routing/cellsize05min.correct.map"
        
        # loading pcraster input maps
        self.ldd_network   = vos.readPCRmapClone(ldd_file_name, \
                                                 self.clonemap_file_name, \
                                                 self.temporary_directory, \
                                                 None, \
                                                 True)
        self.ldd_network   = pcr.lddrepair(pcr.ldd(self.ldd_network))
        self.ldd_network   = pcr.lddrepair(self.ldd_network)
        self.cell_area     = vos.readPCRmapClone(cell_area_file_name, \
                                                 self.clonemap_file_name, \
                                                 self.temporary_directory, \
                                                 None)

        # set/limit all input maps to the defined landmask
        self.ldd_network = pcr.ifthen(self.landmask, self.ldd_network)
        self.cell_area   = pcr.ifthen(self.landmask, self.cell_area)
        
        # calculate basin/catchment area
        self.basin_area  = pcr.catchmenttotal(self.cell_area, self.ldd_network)
        self.basin_area  = pcr.ifthen(self.landmask, self.basin_area) 
        
        # preparing an object for reporting netcdf files:
        self.netcdf_report = netcdf_writer.PCR2netCDF(self.clonemap_file_name)
        
        # preparing netcdf output files:
        self.netcdf_report.createNetCDF(self.output_file, \
                                        self.variable_name, \
                                        self.variable_unit)


    def initial(self): 
        pass

    def dynamic(self):

        # re-calculate current model time using current pcraster timestep value
        self.modelTime.update(self.currentTimeStep())

        # processing done only at the last day of the month
        if self.modelTime.isLastDayOfYear():
            
            logger.info("Reading runoff for time %s", self.modelTime.currTime)
            annual_input_file = self.input_file %(str(self.modelTime.currTime.year), \
                                                  str(self.modelTime.currTime.year))
            self.cell_value = vos.netcdf2PCRobjClone(annual_input_file, "automatic", \
                                                     str(self.modelTime.fulldate), \
                                                     useDoy = None, \
                                                     cloneMapFileName = self.clonemap_file_name, \
                                                     LatitudeLongitude = True)
            self.cell_value = pcr.cover(self.cell_value, 0.0)
            self.cell_value = pcr.ifthen(self.landmask, self.cell_value)
            
            logger.info("Calculating basin value for time %s", self.modelTime.currTime)
            self.basin_value = pcr.catchmenttotal(self.cell_value * self.cell_area, self.ldd_network) / self.basin_area

            # reporting 
            # - time stamp for reporting
            timeStamp = datetime.datetime(self.modelTime.year,\
                                          self.modelTime.month,\
                                          self.modelTime.day,\
                                          0)
            logger.info("Reporting for time %s", self.modelTime.currTime)
            self.netcdf_report.data2NetCDF(self.output_file, \
                                           "total_flow", \
                                           pcr.pcr2numpy(self.total_flow, vos.MV), \
                                           timeStamp)


def main():

    # input_file
    input_file = "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/historical/1958-2001_watch/"
    input_file = sys.argv[1]
    
    # netcdf variable name
    input_variable_name = sys.argv[2]
    
    # timeStep info: year, month, day, doy, hour, etc
    start_date = "2015-01-01"
    end_date   = "2015-12-31"
    start_date = sys.argv[3]
    end_date   = sys.argv[4]
    #
    currTimeStep = ModelTime() 
    currTimeStep.getStartEndTimeSteps(start_date, end_date)
    
    # output folder from this calculation
    output_folder = "/scratch-shared/edwin/mekong_basin_temperature/test/"
    output_folder = sys.argv[5]

    # - if exists, cleaning the previous output directory:
    if os.path.isdir(output_folder): shutil.rmtree(output_folder)
    # - making the output folder
    os.makedirs(output_folder)

    # output file, variable name and unit
    output_file   = output_folder + "/" + sys.argv[6]
    variable_name = sys.argv[7]
    variable_unit  = sys.argv[8]

    # logger
    # - making a log directory
    log_file_directory = output_folder + "/" + "log/"
    os.makedirs(log_file_directory)
    # - initialize logging
    vos.initialize_logging(log_file_directory)
    
    
    # Running the deterministic_runner
    logger.info('Starting the calculation.')
    deterministic_runner = DeterministicRunner(currTimeStep, input_file, output_file, variable_name, variable_unit)
    dynamic_framework = DynamicFramework(deterministic_runner, currTimeStep.nrOfTimeSteps)
    dynamic_framework.setQuiet(True)
    dynamic_framework.run()

if __name__ == '__main__':
    sys.exit(main())
