#! /usr/bin/python

import os
import sys

main_folder = "/scratch-shared/edwin/pcrglobwb_aqueduct_2021/version_2021-06-23_w5e5v2_updated_gmd_parameters/"
start_years = [1978] 
final_year = 2019

# ~ main_folder = sys.argv[1]
# ~ start_years = map(int, list(set(sys.argv[2].split(","))))
# ~ start_years.sort()
# ~ final_year  = int(sys.argv[3])

print(start_years)

outp_folder = "/scratch-shared/edwin/pcrglobwb_aqueduct_2021/version_2021-06-23_w5e5v2_updated_gmd_parameters/merged_irrigation_water_use_etc"

# ~ outp_folder = str(sys.argv[4])

#~ cmd = "rm -rf " + outp_folder
#~ print(cmd)
#~ os.system(cmd)
cmd = "mkdir -p " + outp_folder
print(cmd)
os.system(cmd)
cmd = "cp merge_netcdf_general.py " + outp_folder
print(cmd)
os.system(cmd)
os.chdir(outp_folder)

# ~ (ii) irrigation withdrawal rates: /projects/0/dfguu/users/edwin/pcrglobwb_aqueduct_2021/version_2021-06-23_w5e5v2_updated_gmd_parameters/global/netcdf_merged_1979-2019/irrGrossDemand_annuaTot_output_1979-2019.nc
# ~ - This is still at the annual resolution. 
# ~ - I'll process the monthly files, as soon as possible.

# ~ (iii) irrigation return flows 
# ~ - I'll process the monthly files, as soon as possible

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
    
        cmd = ""
                
        # annual total
        cmd += "python merge_netcdf_general.py " + \
               input_folder + " " + \
               outp_folder + " " + \
               "outAnnuaTotNC " + \
               str(year)+"-12-31" + " " + str(year)+"-12-31" + " " + \
               "evaporation_from_irrigation,precipitation_at_irrigation " + \
               "NETCDF4 True 8 53 all_lats default & "

        # ~ # monthly total
        # ~ cmd += "python merge_netcdf_general.py " + \
               # ~ input_folder + " " + \
               # ~ outp_folder + " " + \
               # ~ "outMonthTotNC " + \
               # ~ str(year)+"-12-31" + " " + str(year)+"-12-31" + " " + \
               # ~ "irrGrossDemand " + \
               # ~ "NETCDF4 True 8 53 all_lats default"
       
        # ~ # daily total
        # ~ cmd += "python merge_netcdf_general.py " + \
               # ~ input_folder + " " + \
               # ~ outp_folder + " " + \
               # ~ str(year)+"-12-31" + " " + str(year)+"-12-31" + " " + \
               # ~ "outDailyTotNC " + \
               # ~ "referencePotET " + \
               # ~ "NETCDF4 True 8 53 all_lats default"

        cmd += "wait"
        print(cmd)
        os.system(cmd)
