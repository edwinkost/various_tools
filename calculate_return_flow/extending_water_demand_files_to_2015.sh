
/projects/0/dfguu/data/hydroworld/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/waterUse/waterDemand$ ls -lah */complete_uncompressed/*.nc
-rw-r--r-- 1 hydrowld dfguu 43G Dec  5 00:44 domestic/complete_uncompressed/domestic_water_demand_version_april_2015.nc
-rw-r--r-- 1 hydrowld dfguu 43G Dec  5 00:54 industry/complete_uncompressed/industry_water_demand_version_april_2015.nc
-rw-r--r-- 1 hydrowld dfguu 43G Dec  5 01:03 livestock/complete_uncompressed/livestock_water_demand_version_april_2015.nc

# domestic
SOURCE_FILE=

cdo -L -setyear, -selyear,2010 domestic/complete_uncompressed/domestic_water_demand_version_april_2015.nc domestic_2011.nc
