#! /usr/bin/python

import os
import sys

inp_directory = sys.argv[1]

out_directory = sys.argv[2]

years = sys.argv[3]

variables = [

"discharge_monthAvg",
"precipitation_monthTot",

# ~ "baseflow_monthTot",
# ~ "gwRecharge_monthTot",

# ~ "irrGrossDemand_monthTot",
# ~ "nonIrrGrossDemand_monthTot",

# ~ "domesticWaterWithdrawal_monthTot",
# ~ "industryWaterWithdrawal_monthTot",
# ~ "livestockWaterWithdrawal_monthTot",
# ~ "irrNonPaddyWaterWithdrawal_monthTot",
# ~ "irrPaddyWaterWithdrawal_monthTot",

# ~ "channelStorage_monthAvg",

# ~ "desalinationAbstraction_monthTot",
# ~ "surfaceWaterAbstraction_monthTot",
# ~ "totalGroundwaterAbstraction_monthTot",
# ~ "fossilGroundwaterAbstraction_monthTot",

# ~ "storUppTotal_monthAvg",
# ~ "storLowTotal_monthAvg",
# ~ "storGroundwater_monthAvg",

# ~ "totalWaterStorageThickness_monthAvg",

# ~ "totalRunoff_monthTot",
# ~ "runoff_monthTot",

# ~ "totalEvaporation_monthTot",


]

try:
    os.makedirs(out_directory)
except:
    pass

    
for variable in variables:
    cmd = "cdo -L -z zip -f nc4 -mergetime " + str(inp_directory) + "/" + str(variable) + "_output_*.nc " + str(out_directory) + "/" + str(variable) + "_output_" + str(years) + ".nc "
    print(cmd)
    os.system(cmd)

sys.exit()

