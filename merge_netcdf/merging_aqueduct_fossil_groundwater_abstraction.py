#! /usr/bin/python

import os
import sys

#~ directory = sys.argv[1]
#~ os.chdir(directory)
#~ print(directory)


main_folder = "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_watch_kinematicwave/no_correction/non-natural/"
start_years = [1958, 1976, 1985] 
final_year = 2001

outp_folder = "/scratch-shared/edwin/aqueduct_fossil_groundwater_abstraction_test/watch/"
cmd = "mkdir -p " + outp_folder
print(cmd)
os.system(cmd)
os.chdir(outp_folder)

for i_year in range(0, len(start_years)):
    
    # - input sub folder
    inp_sub_folder = "continue_from_" + str(start_years[i_year])
    if i_year == 0: inp_sub_folder = "begin_from_" + str(start_years[i_year]) 
    
    input_folder = main_folder + "/" + inp_sub_folder + "/"
    
    sta_year = start_years[i_year]
    if i_year == len(start_years):
        end_year = final_year
    else:
        end_year = start_years[i_year+1] - 1
    
    for year in range(sta_year, end_year + 1):
    
        #~ example: python merge_netcdf.py /projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_watch_kinematicwave/no_correction/non-natural/begin_from_1958/ /scratch-shared/edwin/test_merging/ outAnnuaTotNC 1958-12-31 1958-12-31 fossilGroundwaterAbstraction NETCDF4 True 1 Global

        cmd = "python merge_netcdf.py " + \
              input_folder + " " + \
              outp_folder + " " + \
              "outAnnuaTotNC " + \
              str(year)+"-12-31" + " " + str(year)+"-12-31" + " " + \
              "fossilGroundwaterAbstraction NETCDF4 True 1 Global"
        print(cmd)
        os.system(cmd)


              