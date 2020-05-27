#! /usr/bin/python

import os
import sys

# example of command line:
CDO_TIMESTAT_DATE='last' cdo -L -settime,00:00:00  -monavg -sellonlatbox,100,120,-10,10 -mergetime /scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_irrigation_water_use/historical/1951-2005/gfdl-esm2m/irrigationWaterWithdrawal_annuaTot_output_*.nc test.nc
lonlatbox   = ""

input_files = 
output_file = 

cmd = "CDO_TIMESTAT_DATE='last' cdo -L -monvag -sellonlatbox," + lonlatbox + "-mergetime " + input_files + " " + output_file
print(cmd)
os.system(cmd)
