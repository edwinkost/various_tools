#!/bin/bash

#~ 1) water withdrawals from the domestic, industrial and irrigation sectors
#~ - totalAbstraction_annuaTot_output
#~ - domesticWaterWithdrawal_annuaTot_output
#~ - industryWaterWithdrawal_annuaTot_output
#~ - irrigation sector withdrawal (inclucing livestock): totalAbstraction - (domesticWaterWithdrawal + industryWaterWithdrawal)

#~ 2) domestic and industrial return flows (needed to be calculated from monthly values as return flow fraction changes over time)
#~ - domestic return flow_annua = sum( monthly_domestic_fraction * domesticWaterWithdrawal_monthTot)
#~ - industry_return_flow_annua = sum( monthly_industry_fraction * industryWaterWithdrawal_monthTot )

set -x

#~ YEAR="2000"

echo "Arg 0: $0"
echo "Arg 1: $1"

YEAR=$1

# preparing output folder
OUTPUT_FOLDER="/scratch-shared/edwinhs/data_for_edward_jones/uploaded_for_edward/05min/"
OUTPUT_FOLDER=${OUTPUT_FOLDER}/${YEAR}
mkdir -p ${OUTPUT_FOLDER}
cd ${OUTPUT_FOLDER} 
rm *.nc

# totalGrossDemand_annuaTot_output = totalSectoralWithdrawal
SOURCEFILE=/scratch-shared/edwinhs/data_for_edward_jones/total_withdrawals_for_satisfying_demands/totalGrossDemand_annuaTot_output_${YEAR}-12-31_to_${YEAR}-12-31.nc
TOT_OUTPUT=total_withdrawals_annuaTot_output_${YEAR}.nc
cdo -L -z zip -f nc4 -setname,"total_sectoral_withdrawal" -selyear,${YEAR} ${SOURCEFILE} ${TOT_OUTPUT}
ncatted -O -a standard_name,"total_sectoral_withdrawal",c,c,"total_sectoral_withdrawal" ${TOT_OUTPUT}
ncatted -O -a long_name,"total_sectoral_withdrawal",c,c,"total_sectoral_withdrawal" ${TOT_OUTPUT}
ncdump -h ${TOT_OUTPUT}
#~ ncview ${TOT_OUTPUT}

#~ edwinhs@tcn724.bullx:/scratch-shared/edwinhs/data_for_edward_jones/domestic_industrial_withdrawals_and_return_flows$ ls -lah */*
#~ -r--r--r-- 1 edwinhs edwinhs 1.7G Apr  8 15:32 domestic/domesticWaterWithdrawal_monthTot_output_1958-01-31_to_2000-12-31.zip.nc
#~ -r--r--r-- 1 edwinhs edwinhs 926M Apr  8 15:32 domestic/return_flow_from_domestic_water_withdrawals_annual_1990-2015.nc
#~ -r--r--r-- 1 edwinhs edwinhs  11G Apr  8 15:32 domestic/return_flow_from_domestic_water_withdrawals_monthly_1990-2015.nc
#~ -r--r--r-- 1 edwinhs edwinhs 1.3G Apr  8 15:32 industry/industryWaterWithdrawal_monthTot_output_1958-01-31_to_2000-12-31.zip.nc
#~ -r--r--r-- 1 edwinhs edwinhs 926M Apr  8 15:32 industry/return_flow_from_industry_water_withdrawals_annual_1990-2015.nc
#~ -r--r--r-- 1 edwinhs edwinhs  11G Apr  8 15:32 industry/return_flow_from_industry_water_withdrawals_monthly_1990-2015.nc

# domesticWaterWithdrawal_annuaTot_output
SOURCEFILE="/scratch-shared/edwinhs/data_for_edward_jones/domestic_industrial_withdrawals_and_return_flows/domestic/domesticWaterWithdrawal_monthTot_output_1958-01-31_to_2000-12-31.zip.nc"
DOM_OUTPUT=domesticWaterWithdrawal_annuaTot_output_${YEAR}.nc
CDO_TIMESTAT_DATE='last' cdo -L -z zip -f nc4 -settime,00:00:00 -setunit,"m.year-1" -yearsum -selyear,${YEAR} ${SOURCEFILE} ${DOM_OUTPUT}
ncdump -h ${DOM_OUTPUT}
#~ ncview ${DOM_OUTPUT}

# industryWaterWithdrawal_annuaTot_output
SOURCEFILE="/scratch-shared/edwinhs/data_for_edward_jones/domestic_industrial_withdrawals_and_return_flows/industry/industryWaterWithdrawal_monthTot_output_1958-01-31_to_2000-12-31.zip.nc"
IND_OUTPUT=industryWaterWithdrawal_annuaTot_output_${YEAR}.nc
CDO_TIMESTAT_DATE='last' cdo -L -z zip -f nc4 -settime,00:00:00 -setunit,"m.year-1" -yearsum -selyear,${YEAR} ${SOURCEFILE} ${IND_OUTPUT}
ncdump -h ${IND_OUTPUT}
#~ ncview ${IND_OUTPUT}

# domesticWaterWithdrawal_annuaTot_output + industryWaterWithdrawal_annuaTot_output
DOMIND_OUT=dom_n_ind_withdrawal_annuaTot_output_${YEAR}.nc
cdo -L -z zip -f nc4 -setname,"dom_n_ind_withdrawal" -add ${DOM_OUTPUT} ${IND_OUTPUT} ${DOMIND_OUT}
ncatted -O -a standard_name,"dom_n_ind_withdrawal",c,c,"dom_n_ind_withdrawal" ${DOMIND_OUT}
ncatted -O -a long_name,"dom_n_ind_withdrawal",c,c,"domestic_and_industry_water_withdrawal" ${DOMIND_OUT}
ncdump -h ${DOMIND_OUT}
#~ ncview ${DOMIND_OUT}

# aggriculture water withdrawal (including livestock)
AGGRIC_OUT=irr_and_liv_withdrawal_annuaTot_output_${YEAR}.nc
cdo -L -z zip -f nc4 -selyear,${YEAR} -setname,"irr_and_liv_withdrawal" -setrtoc,-inf,0,0 -sub ${TOT_OUTPUT} ${DOMIND_OUT} ${AGGRIC_OUT}
ncatted -O -a standard_name,"irr_and_liv_withdrawal",c,c,"irr_and_liv_withdrawal" ${AGGRIC_OUT}
ncatted -O -a long_name,"irr_and_liv_withdrawal",c,c,"irrigation_and_livestock_water_withdrawal" ${AGGRIC_OUT}
ncdump -h ${AGGRIC_OUT}
#~ ncview ${AGGRIC_OUT}

# domestic return flow
SOURCE_DOM_RETFLOW=/scratch-shared/edwinhs/data_for_edward_jones/domestic_industrial_withdrawals_and_return_flows/domestic/return_flow_from_domestic_water_withdrawals_annual_1990-2015.nc
OUTPUT_DOM_RETFLOW=return_flow_from_domestic_water_withdrawals_annuaTot_output_${YEAR}.nc
cdo -L -z zip -f nc4 -setname,"industry_return_flow" -min -selyear,${YEAR} ${DOM_OUTPUT} -selyear,${YEAR} ${SOURCE_DOM_RETFLOW} ${OUTPUT_DOM_RETFLOW}
ncdump -h ${OUTPUT_DOM_RETFLOW}
#~ ncview ${OUTPUT_DOM_RETFLOW}

# industrial return flow
SOURCE_IND_RETFLOW=/scratch-shared/edwinhs/data_for_edward_jones/domestic_industrial_withdrawals_and_return_flows/industry/return_flow_from_industry_water_withdrawals_annual_1990-2015.nc
OUTPUT_IND_RETFLOW=return_flow_from_industry_water_withdrawals_annuaTot_output_${YEAR}.nc
cdo -L -z zip -f nc4 -setname,"industry_return_flow" -min -selyear,${YEAR} ${IND_OUTPUT} -selyear,${YEAR} ${SOURCE_IND_RETFLOW} ${OUTPUT_IND_RETFLOW}
ncdump -h ${OUTPUT_IND_RETFLOW}
#~ ncview ${OUTPUT_IND_RETFLOW}

set +x


