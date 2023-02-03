#! /usr/bin/python

import os
import sys
import shutil

directory = sys.argv[1]
os.chdir(directory)
print(directory)


gcm_name           = "gfdl-esm4"
scenario_type      = "historical"

# ~ gcm_name       = sys.argv[1]
# ~ scenario_type  = sys.argv[2]

source_folder      = "/scratch/depfg/sutan101/pcrglobwb_wri_aqueduct_2021/pcrglobwb_aqueduct_2021_monthly_annual_files/version_2021-09-16/gfdl-esm4/historical/begin_from_1960/global/netcdf"
# ~ source_folder  = sys.argv[3]

output_folder      = "/scratch/depfg/sutan101/pcrglobwb_wri_aqueduct_2021/pcrglobwb_aqueduct_2021_monthly_annual_files/version_2021-09-16_merged/gfdl-esm4/historical/"
# ~ output_folder  = sys.argv[4]

start_year = str(1960)
final_year = str(2014)

# ~ first_year = sys.argv[5]
# ~ final_year = sys.argv[6]


# create output folder
cleanOutputDir = False
if cleanOutputDir:
    try: 
        shutil.rmtree(output_folder)
    except: 
        pass # for new outputDir (not exist yet)
try: 
    os.makedirs(output_folder)
except: 
    pass # for new outputDir (not exist yet)


# copy griddes_clone_global_05min.txt to the output folder
cmd = "cp griddes_clone_global_05min.txt " + str(output_folder)
print(cmd)
os.system(cmd)

# list of variables
# - monthly resolution - total values
outMonthTotNC = "actualET,runoff,totalRunoff,baseflow,directRunoff,interflowTotal,totalGroundwaterAbstraction,desalinationAbstraction,surfaceWaterAbstraction,fossilGroundwaterAbstraction,irrGrossDemand,nonIrrGrossDemand,totalGrossDemand,nonIrrWaterConsumption,nonIrrReturnFlow,precipitation,gwRecharge,surfaceWaterInf,totalEvaporation,totalPotentialEvaporation,precipitation_at_irrigation,netLqWaterToSoil_at_irrigation,evaporation_from_irrigation,transpiration_from_irrigation"
# - monthly resolution - average values
outMonthAvgNC = "discharge,temperature,dynamicFracWat,surfaceWaterStorage,interceptStor,snowFreeWater,snowCoverSWE,topWaterLayer,storUppTotal,storLowTotal,storGroundwater,storGroundwaterFossil,totalWaterStorageThickness,satDegUpp,satDegLow,channelStorage,waterBodyStorage"
# - annual resolution - total values
outAnnuaTotNC = "totalEvaporation,precipitation,gwRecharge,totalRunoff,baseflow,desalinationAbstraction,surfaceWaterAbstraction,nonFossilGroundwaterAbstraction,fossilGroundwaterAbstraction,totalGroundwaterAbstraction,totalAbstraction,irrGrossDemand,nonIrrGrossDemand,totalGrossDemand,nonIrrWaterConsumption,nonIrrReturnFlow,runoff,actualET,irrPaddyWaterWithdrawal,irrNonPaddyWaterWithdrawal,irrigationWaterWithdrawal,domesticWaterWithdrawal,industryWaterWithdrawal,livestockWaterWithdrawal,precipitation_at_irrigation,netLqWaterToSoil_at_irrigation,evaporation_from_irrigation,transpiration_from_irrigation"
# - annual resolution - annual values
outAnnuaAvgNC = "temperature,discharge,gwRecharge"

# - annual resolution - average
variables = outAnnuaAvgNC.split(",")
cmd = ""
for variable in variables:
    "cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime " + str(source_folder) + "/" + str(variable) + "_annuaAvg*.nc " +\
    "pcrglobwb_cmip6-isimip3-" + str(gcm_name) + "_image-aqueduct_" + str(scenario_type) + "_" + str(variable) + "_global_yearly-average_" +str(start_year) + "_" + str(final_year) +\
    "_basetier1.nc" +\
    " & "
cmd += "wait"
print(cmd)
# ~ os.system(cmd)

