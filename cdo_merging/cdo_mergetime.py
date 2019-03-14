#! /usr/bin/python

import os
import sys

directory = sys.argv[1]
os.chdir(directory)
print(directory)


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
"totalRunoff_monthTot",

"baseflow_monthTot",
"gwRecharge_monthTot",
"surfaceWaterInf_monthTot",

"totalGroundwaterAbstraction_monthTot",
"fossilGroundwaterAbstraction_monthTot",

"totalPotentialEvaporation_monthTot",

"referencePotET_monthTot",

"temperature_monthAvg"

]



cmd = ""
for variable in variables:
    cmd += "cdo -L -z zip -f nc4 -mergetime ../begin_from_1958/global/netcdf/" + str(variable) + "_output_*.nc " + str(variable) + "_output_1958-01-31_to_2015-12-31.zip.nc " + " & "
cmd += "wait"
print(cmd)
os.system(cmd)



