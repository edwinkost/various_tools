
set -x

#~ /projects/0/dfguu/data/hydroworld/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/waterUse/waterDemand$ ls -lah */complete_uncompressed/*.nc
#~ -rw-r--r-- 1 hydrowld dfguu 43G Dec  5 00:44 domestic/complete_uncompressed/domestic_water_demand_version_april_2015.nc
#~ -rw-r--r-- 1 hydrowld dfguu 43G Dec  5 00:54 industry/complete_uncompressed/industry_water_demand_version_april_2015.nc
#~ -rw-r--r-- 1 hydrowld dfguu 43G Dec  5 01:03 livestock/complete_uncompressed/livestock_water_demand_version_april_2015.nc


MAIN_SOURCE_DIR="/projects/0/dfguu/data/hydroworld/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/waterUse/waterDemand"


# for domestic water demands

OUTPUT_DIR="/scratch-shared/edwinhs/data_for_edward_jones/water_demands_and_return_flow_fractions/domestic/"
#~ mkdir -p ${OUTPUT_DIR}
cd ${OUTPUT_DIR}
#~ rm *.nc

SOURCE_FILE=${MAIN_SOURCE_DIR}/domestic/complete_uncompressed/domestic_water_demand_version_april_2015.nc
#~ cdo -L -setyear,2011 -selyear,2010 ${SOURCE_FILE} domestic_demand_2011.nc
#~ cdo -L -setyear,2012 -selyear,2010 ${SOURCE_FILE} domestic_demand_2012.nc
#~ cdo -L -setyear,2013 -selyear,2010 ${SOURCE_FILE} domestic_demand_2013.nc
#~ cdo -L -setyear,2014 -selyear,2010 ${SOURCE_FILE} domestic_demand_2014.nc
#~ cdo -L -setyear,2015 -selyear,2010 ${SOURCE_FILE} domestic_demand_2015.nc
#~ cdo -L -mergetime ${SOURCE_FILE} domestic_*.nc domestic_water_demand_gmd_paper.nc

cdo -L expr,"dom_ret_flow_frac = ( (domesticGrossDemand > 0.0) ? 1-(domesticNettoDemand/domesticGrossDemand) : 0.0)" domestic_water_demand_gmd_paper.nc domestic_return_flow_fraction_gmd_paper.nc 
ncview domestic_water_demand_gmd_paper.nc domestic_return_flow_fraction_gmd_paper.nc

# for industry water demands

OUTPUT_DIR="/scratch-shared/edwinhs/data_for_edward_jones/water_demands_and_return_flow_fractions/industry/"
#~ mkdir -p ${OUTPUT_DIR}
cd ${OUTPUT_DIR}
#~ rm *.nc

SOURCE_FILE=${MAIN_SOURCE_DIR}/industry/complete_uncompressed/industry_water_demand_version_april_2015.nc
#~ cdo -L -setyear,2011 -selyear,2010 ${SOURCE_FILE} industry_demand_2011.nc
#~ cdo -L -setyear,2012 -selyear,2010 ${SOURCE_FILE} industry_demand_2012.nc
#~ cdo -L -setyear,2013 -selyear,2010 ${SOURCE_FILE} industry_demand_2013.nc
#~ cdo -L -setyear,2014 -selyear,2010 ${SOURCE_FILE} industry_demand_2014.nc
#~ cdo -L -setyear,2015 -selyear,2010 ${SOURCE_FILE} industry_demand_2015.nc
#~ cdo -L -mergetime ${SOURCE_FILE} industry_*.nc industry_water_demand_gmd_paper.nc

cdo -L expr,"in_ret_flow_frac = ( (industryGrossDemand > 0.0) ? 1-(industryNettoDemand/industryGrossDemand) : 0.0)" industry_water_demand_gmd_paper.nc industry_return_flow_fraction_gmd_paper.nc 
ncview industry_water_demand_gmd_paper.nc industry_return_flow_fraction_gmd_paper.nc 


set +x


