#! /usr/bin/python

import os
import sys

inp_directory = sys.argv[1]

out_directory = sys.argv[2]

years = sys.argv[3]

variables = [

"baseflow_monthTot",
"gwRecharge_monthTot",

"irrGrossDemand_monthTot",
"nonIrrGrossDemand_monthTot",

"domesticWaterWithdrawal_monthTot",
"industryWaterWithdrawal_monthTot",
"livestockWaterWithdrawal_monthTot",
"irrNonPaddyWaterWithdrawal_monthTot",
"irrPaddyWaterWithdrawal_monthTot",

"channelStorage_monthAvg",

"desalinationAbstraction_monthTot",
"surfaceWaterAbstraction_monthTot",
"totalGroundwaterAbstraction_monthTot",
"fossilGroundwaterAbstraction_monthTot",

"storUppTotal_monthAvg",
"storLowTotal_monthAvg",
"storGroundwater_monthAvg",

"totalWaterStorageThickness_monthAvg",

"discharge_monthAvg",

"precipitation_monthTot",

"totalEvaporation_monthTot",

"totalRunoff_monthTot",
"runoff_monthTot"

]



cmd = ""
for variable in variables:
    cmd += "cdo -L -z zip -f nc4 -mergetime " + str(inp_directory) + "/" + str(variable) + "_output_*.nc " + str(variable) + "_output_" + str(years) + ".nc " + " & "
cmd += "wait"
print(cmd)
os.system(cmd)



