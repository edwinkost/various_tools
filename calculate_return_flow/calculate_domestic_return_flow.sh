
set -x

# domestic

OUTPUT_DIR="/scratch-shared/edwinhs/data_for_edward_jones/domestic_industrial_withdrawals_and_return_flows/domestic/"
mkdir -p ${OUTPUT_DIR}
cd ${OUTPUT_DIR} 
rm *.nc

# - merging 

OUTPUT_WITHDRAWAL_FILE="domesticWaterWithdrawal_monthTot_output_1958-01-31_to_2000-12-31.zip.nc"
SOURCE_FILES="/scratch-shared/edwinhs/data_for_edward_jones/monthly_domestic_industrial_withdrawals_per_year/domesticWaterWithdrawal_monthTot_output_*.nc"

#~ edwinhs@tcn724.bullx:/scratch-shared/edwinhs/data_for_edward_jones/monthly_domestic_industrial_withdrawals_per_year$ ls -lah *2000*
#~ -r--r--r-- 1 edwinhs edwinhs 24M Apr  6 01:14 domesticWaterWithdrawal_monthTot_output_2000-01-31_to_2000-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 19M Apr  6 01:14 industryWaterWithdrawal_monthTot_output_2000-01-31_to_2000-12-31.nc

cdo -L -z zip -f nc4 -mergetime ${SOURCE_FILES} ${OUTPUT_WITHDRAWAL_FILE}

# - calculate return flow

MONTHLY_OUTPUT_RETURN_FLOW_FILE="return_flow_from_domestic_water_withdrawals_monthly_1958-2015.nc"
RETURN_FLOW_FRACTION_FILE="/scratch-shared/edwinhs/data_for_edward_jones/water_demands_and_return_flow_fractions/domestic/domestic_return_flow_fraction_gmd_paper.nc"

#~ edwinhs@tcn724.bullx:/scratch-shared/edwinhs/data_for_edward_jones/water_demands_and_return_flow_fractions$ ls -lah */*_return_flow_fraction_gmd_paper.nc 
#~ -rw-r--r-- 1 edwinhs edwinhs 24G Apr  5 23:51 domestic/domestic_return_flow_fraction_gmd_paper.nc
#~ -rw-r--r-- 1 edwinhs edwinhs 24G Apr  6 00:03 industry/industry_return_flow_fraction_gmd_paper.nc


cdo -L mul -shifttime,-1day -shifttime,1month ${RETURN_FLOW_FRACTION_FILE} ${OUTPUT_WITHDRAWAL_FILE} ${MONTHLY_OUTPUT_RETURN_FLOW_FILE}

ncdump -h ${MONTHLY_OUTPUT_RETURN_FLOW_FILE}
ncview ${MONTHLY_OUTPUT_RETURN_FLOW_FILE}

# - calculate annual resolution

ANNUAL_OUTPUT_RETURN_FLOW_FILE="return_flow_from_domestic_water_withdrawals_annual_1958-2015.nc"

cdo -L -setunit,m.year-1 -yearsum ${MONTHLY_OUTPUT_RETURN_FLOW_FILE} ${ANNUAL_OUTPUT_RETURN_FLOW_FILE}
 
ncdump -h ${ANNUAL_OUTPUT_RETURN_FLOW_FILE}
ncview ${ANNUAL_OUTPUT_RETURN_FLOW_FILE}

set +x

