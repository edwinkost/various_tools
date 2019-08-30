#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import sys

pcrglobwb_output_folder = "/scratch-shared/edwin/pcrglobwb_for_land-subsidence-model_runs_version_201908XX/historical_non-natural_gmd-paper-irrigated_areas/begin_from_1958/"
merged_output_folder    = "/scratch-shared/edwin/tmp/mergedAnnuaTot/pcrglobwb_for_land-subsidence-model_runs_version_201908XX/historical_non-natural_gmd-paper-irrigated_areas/begin_from_1958/"

cmd_line = "mkdir -p " + merged_output_folder
print(cmd_line)
os.system(cmd_line)

for year in range(1958, 2015 + 1):
    fulldate = str(year) + "-12-31"
    cmd_line = "python merge_netcdf.py /scratch-shared/edwin/pcrglobwb_for_land-subsidence-model_runs_version_201908XX/historical_non-natural_gmd-paper-irrigated_areas/begin_from_1958/ /scratch-shared/edwin/test_merging/1958/ outAnnuaTotNC " + fulldate + " " + fulldate + " " + "totalEvaporation,precipitation,gwRecharge,totalRunoff,baseflow,desalinationAbstraction,surfaceWaterAbstraction,totalGroundwaterAbstraction,nonFossilGroundwaterAbstraction,fossilGroundwaterAbstraction,totalAbstraction,irrGrossDemand,nonIrrGrossDemand,totalGrossDemand,nonIrrWaterConsumption,nonIrrReturnFlow,runoff,actualET,irrPaddyWaterWithdrawal,irrigationWaterWithdrawal,domesticWaterWithdrawal,industryWaterWithdrawal,livestockWaterWithdrawal,precipitation_at_irrigation,netLqWaterToSoil_at_irrigation,evaporation_from_irrigation,transpiration_from_irrigation,referencePotET NETCDF4 True 20 Global"
    print(cmd_line)
    os.system(cmd_line)
