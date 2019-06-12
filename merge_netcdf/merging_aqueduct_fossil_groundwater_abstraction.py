#! /usr/bin/python

import os
import sys

main_folder = "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_watch_kinematicwave/no_correction/non-natural/"
start_years = [1958, 1976, 1985] 
final_year = 2001

main_folder = sys.argv[1]
start_years = map(int, list(set(sys.argv[2].split(","))))
start_years.sort()
final_year  = int(sys.argv[3])

print(start_years)
#~ pietje


outp_folder = "/scratch-shared/edwin/aqueduct_fossil_groundwater_abstraction_test/watch_2/"
cmd = "mkdir -p " + outp_folder
print(cmd)
os.system(cmd)
cmd = "cp merge_netcdf.py " + outp_folder
print(cmd)
os.system(cmd)
os.chdir(outp_folder)

for i_year in range(0, len(start_years)):
    
    # - input sub folder
    inp_sub_folder = "begin_from_" + str(start_years[i_year]) 
    if i_year > 0: inp_sub_folder = "continue_from_" + str(start_years[i_year])
    
    input_folder = main_folder + "/" + inp_sub_folder + "/"
    
    sta_year = int(start_years[i_year])
    if i_year == (len(start_years)-1):
        end_year = final_year
    else:
        end_year = int(start_years[i_year+1]) - 1
    
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


              
