#! /usr/bin/python

import os
import sys

directory = sys.argv[1]
os.chdir(directory)

variables = [

"interceptStor_monthAvg",
"snowFreeWater_monthAvg",
"snowCoverSWE_monthAvg",
"topWaterLayer_monthAvg",
"storUppTotal_monthAvg",
"storLowTotal_monthAvg",
"storGroundwater_monthAvg",
"storGroundwaterFossil_monthAvg",
"surfaceWaterStorage_monthAvg",

"totalWaterStorageThickness_monthAvg",

"channelStorage_monthAvg",

"temperature_monthAvg",

"discharge_monthAvg",

"precipitation_monthTot",
"totalEvaporation_monthTot",
"totalRunoff_monthTot"

]


cmd = ""
for variable in variables:
    cmd += "cdo -L -z zip -f nc4 -mergetime ../begin_from_1958/global/netcdf/" + str(variable) + "_output_*.nc " + str(variable)  + " & "
cmd += "wait"
print(cmd)
os.system(cmd)



