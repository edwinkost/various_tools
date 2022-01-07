#! /usr/bin/python

import os
import sys

inp_folder = sys.argv[1]
out_folder = sys.argv[2]

rcp_code   = sys.argv[3]
gcm_code   = sys.argv[4]

sta_year = int(sys.argv[5])
end_year = int(sys.argv[6])

# preparing output_folder
cmd = "mkdir -p " + out_folder
print(cmd)
os.system(cmd)
cmd = "cp cdo_tim_pctl.py " + out_folder
print(cmd)
os.system(cmd)
os.chdir(outp_folder)

# cdo timmin, timmax, timmean, and timstd, as well as timpctl99, timpctl95, timpctl90, timpctl50, timpctl10, and timpctl05
for year in range(sta_year, end_year + 1):

    input_file  = inp_folder + "/discharge_dailyTot_output_" + str(year) + "-01-01_to_" + str(year) + "-12-31.nc"
    

    # command line to calculate timmin, timmax, timmean and timstd
    cmd = ""
    
    # cdo timmin
    timmin_file = "timmin" + "_" + rcp_code + "_" + gcm_code + "discharge_daily_" + str(year) + ".nc" 
    cmd += "cdo timmin " + input_file + " " + timmin_file + " & "

    # cdo timmax
    timmax_file = "timmax" + "_" + rcp_code + "_" + gcm_code + "discharge_daily_" + str(year) + ".nc" 
    cmd += "cdo timmax " + input_file + " " + timmax_file + " & "

    # cdo timmean
    timmean_file = "timmean" + "_" + rcp_code + "_" + gcm_code + "discharge_daily_" + str(year) + ".nc" 
    cmd += "cdo timmean " + input_file + " " + timmean_file + " & "

    # cdo timstd
    timstd_file = "timstd" + "_" + rcp_code + "_" + gcm_code + "discharge_daily_" + str(year) + ".nc" 
    cmd += "cdo timstd " + input_file + " " + timstd_file + " & "
    
    # execute cdo timmin, timmax, timmean and timstd
    cmd += "ẅait"
    print(cmd)
    os.system(cmd)
    
    
    # reset command line, now we want to calculate to calculate timpctl99, timpctl95, timpctl90, timpctl50, timpctl10, and timpctl05
    cmd = ""
    
    # cdo timpctl99
    timpctl99_file = "timpctl99" + "_" + rcp_code + "_" + gcm_code + "discharge_daily_" + str(year) + ".nc" 
    cmd += "cdo timpctl,99 " + timmin_file + " " + timmax_file + " " + input_file + " " + timpctl99_file + " & "
    
    # cdo timpctl95
    timpctl95_file = "timpctl95" + "_" + rcp_code + "_" + gcm_code + "discharge_daily_" + str(year) + ".nc" 
    cmd += "cdo timpctl,95 " + timmin_file + " " + timmax_file + " " + input_file + " " + timpctl95_file + " & "
    
    # cdo timpctl90
    timpctl90_file = "timpctl90" + "_" + rcp_code + "_" + gcm_code + "discharge_daily_" + str(year) + ".nc" 
    cmd += "cdo timpctl,90 " + timmin_file + " " + timmax_file + " " + input_file + " " + timpctl90_file + " & "
    
    # cdo timpctl50
    timpctl50_file = "timpctl50" + "_" + rcp_code + "_" + gcm_code + "discharge_daily_" + str(year) + ".nc" 
    cmd += "cdo timpctl,50 " + timmin_file + " " + timmax_file + " " + input_file + " " + timpctl50_file + " & "

    # cdo timpctl10
    timpctl10_file = "timpctl10" + "_" + rcp_code + "_" + gcm_code + "discharge_daily_" + str(year) + ".nc" 
    cmd += "cdo timpctl,10 " + timmin_file + " " + timmax_file + " " + input_file + " " + timpctl10_file + " & "

    # cdo timpctl05
    timpctl05_file = "timpctl05" + "_" + rcp_code + "_" + gcm_code + "discharge_daily_" + str(year) + ".nc" 
    cmd += "cdo timpctl,5 " + timmin_file + " " + timmax_file + " " + input_file + " " + timpctl05_file + " & "

    # execute cdo timpctl99, timpctl95, timpctl90, timpctl50, timpctl10, and timpctl05
    cmd += "ẅait"
    print(cmd)
    os.system(cmd)


