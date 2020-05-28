#! /usr/bin/python

import os
import sys


#~ # example of command line:
#~ CDO_TIMESTAT_DATE='last' cdo -L -settime,00:00:00 -monavg -sellonlatbox,100,120,-10,10 -mergetime /scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_irrigation_water_use/historical/1951-2005/gfdl-esm2m/irrigationWaterWithdrawal_annuaTot_output_*.nc test.nc



lonlatbox   = "22.0,30.0,40.0,45.0"
lonlatbox   = sys.argv[1]

#~ sutanudjaja@cehs-hp:~/ownCloud/paper_in_progress/paul_maritsa_greenpeace$ gdalinfo catchment_lddsound_05min_around_maritsa_paul_request.tif 
#~ Driver: GTiff/GeoTIFF
#~ Files: catchment_lddsound_05min_around_maritsa_paul_request.tif
#~ Size is 96, 60
#~ Coordinate System is `'
#~ Origin = (22.000000000000000,45.000000000000000)
#~ Pixel Size = (0.083333333333333,-0.083333333333333)
#~ Metadata:
  #~ PCRASTER_VALUESCALE=VS_NOMINAL
#~ Image Structure Metadata:
  #~ INTERLEAVE=BAND
#~ Corner Coordinates:
#~ Upper Left  (  22.0000000,  45.0000000) 
#~ Lower Left  (  22.0000000,  40.0000000) 
#~ Upper Right (  30.0000000,  45.0000000) 
#~ Lower Right (  30.0000000,  40.0000000) 
#~ Center      (  26.0000000,  42.5000000) 
#~ Band 1 Block=96x21 Type=Int32, ColorInterp=Gray
  #~ NoData Value=-2147483647


input_files = "/scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_water_use_all/historical/1951-2005/gfdl-esm2m/discharge_monthAvg_output"
input_files = sys.argv[2]

output_file = "/scratch-shared/edwinhs/pcr-globwb-aqueduct/maritsa/test/historical/1951-2005/gfdl-esm2m/discharge_monthAvg_output_1951-2005.nc"
output_file = "/scratch-shared/edwinhs/pcr-globwb-aqueduct/maritsa/test/test.nc"
output_file = sys.argv[3]

# prepare directories if not exist
target_directory = os.path.dirname(output_file)
if os.path.exists(target_directory) == False:
	try:
		os.makedirs(target_directory)
	except:
		pass
os.chdir(target_directory)


# delete file if exist
if os.path.exists(output_file): os.remove(output_file)


# perform cdo
cmd = "CDO_TIMESTAT_DATE='last' cdo -L -settime,00:00:00 -monavg -sellonlatbox," + lonlatbox + " -mergetime " + input_files + "*.nc " + output_file
# - NOTE: Note that the -monvag is used in the combination with CDO_TIMESTAT_DATE='last' and -settime,00:00:00 in order to make all dates are always the last days of the months.   
print(cmd)
os.system(cmd)
