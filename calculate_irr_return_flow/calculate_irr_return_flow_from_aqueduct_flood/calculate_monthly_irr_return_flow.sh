
#~ Steps:

#~ 1. Calculate the consumption at the annual resolution.
#~ 2. Downscale the consumption to the monthly resolution:

#~ monthly_irrigation_water_consumption = (monthly_irrigation_withdrawal / annual_irrigation_withdrawal) x annual_irrigation_consumption
 
#~ 3. Calculate the monthly return flow. 

#~ monthly_irrigation_return_flow = monthly_irrigation_withdrawal - monthly_irrigation_water_consumption

 #~ 1024  cdo selyear,2000 annual_irrigation_consumption_1958-2015.nc annual_irrigation_consumption_2000.nc
 #~ 1025  ls -lah
 #~ 1026  cdo -L -f nc4 -selyear,2000 ../irrigationWaterWithdrawal/total_irrigation_withdrawal_monthTot_output_1958-01-31_to_2015-12-31.nc total_irrigation_withdrawal_monthTot_2000.nc
 #~ 1027  ls -lah
 #~ 1028  cdo -L -f nc4 -selyear,2000 ../irrigationWaterWithdrawal/total_irrigation_withdrawal_annuaTot_output_1958-01-31_to_2015-12-31.nc total_irrigation_withdrawal_annuaTot_2000.nc
 #~ 1029  ls -lah
 #~ 1030  cdo div total_irrigation_withdrawal_monthTot_2000.nc total_irrigation_withdrawal_annuaTot_2000.nc monthly_ratio_2000.nc
 #~ 1031  ncview monthly_ratio_2000.nc
 #~ 1032  cdo mul annual_irrigation_consumption_2000.nc monthly_ratio_2000.nc monthly_irrigation_consumption_2000.nc
 #~ 1033  ncview monthly_irrigation_consumption_2000.nc
 #~ 1034  cdo sub total_irrigation_withdrawal_monthTot_2000.nc monthly_irrigation_consumption_2000.nc monthly_irrigation_return_flow_2000.nc
 #~ 1035  ncview monthly_irrigation_return_flow_2000.nc
 #~ 1036  history


#~ edwinhs@int1.bullx:/scratch-shared/edwinhs/pcr-globwb-aqueduct_for_edward/irrigation_water_use_and_direct_runoff/historical/1951-2005/gfdl-esm2m$ ls -lah *2000*
#~ -r--r--r-- 1 edwinhs edwinhs  48M Apr 16 13:44 directRunoff_monthTot_output_2000-01-31_to_2000-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 2.0M Apr 16 13:44 evaporation_from_irrigation_annuaTot_output_2000-12-31_to_2000-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs  14M Apr 16 13:44 irrNonPaddyWaterWithdrawal_monthTot_output_2000-01-31_to_2000-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 9.5M Apr 16 13:44 irrPaddyWaterWithdrawal_monthTot_output_2000-01-31_to_2000-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 846K Apr 16 13:44 precipitation_annuaTot_output_2000-12-31_to_2000-12-31.nc

set -x

YEAR="2000"
#~ YEAR=$1

# output directory
OUT_DIR="/scratch-shared/edwinhs/pcr-globwb-aqueduct_for_edward/irrigation_water_use_and_direct_runoff_test/processed_irrigated/historical/1951-2005/gfdl-esm2m/"${YEAR}"/"
mkdir -p ${OUT_DIR}
cd ${OUT_DIR}
rm *

# input folder
INPUT_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct_for_edward/irrigation_water_use_and_direct_runoff/historical/1951-2005/gfdl-esm2m/"

# input files
IRR_NON_PADDY_ABS=${INPUT_FOLDER}"/irrNonPaddyWaterWithdrawal_monthTot_output_"${YEAR}"-01-31_to_"${YEAR}"-12-31.nc"
IRR_PADDY_ABS=${INPUT_FOLDER}"/irrPaddyWaterWithdrawal_monthTot_output_"${YEAR}"-01-31_to_"${YEAR}"-12-31.nc"
ANNUAL_PRECIP=${INPUT_FOLDER}"/precipitation_annuaTot_output_"${YEAR}"-12-31_to_"${YEAR}"-12-31.nc"
ANNUAL_ET_IRR=${INPUT_FOLDER}"/evaporation_from_irrigation_annuaTot_output_"${YEAR}"-12-31_to_"${YEAR}"-12-31.nc"

# calculate monthly total irrigation withdrawal
cdo -L -f nc4 -setname,"total_irrigation_withdrawal" -add ${IRR_NON_PADDY_ABS} ${IRR_PADDY_ABS} total_irrigation_withdrawal_monthTot_output_${YEAR}.nc

# calculate annual total irrigation withdrawal
cdo -L -f nc4 -setunit,m.year-1 -yearsum total_irrigation_withdrawal_monthTot_output_${YEAR}.nc total_irrigation_withdrawal_annuaTot_output_${YEAR}.nc

# calculate annual total supply
cdo -L -f nc4 -setname,"precipitation_and_irrigation_supply" -setunit,m.year-1 -add total_irrigation_withdrawal_annuaTot_output_${YEAR}.nc ${ANNUAL_PRECIP} annual_total_supply_from_p_and_irr.nc

# calculate annual irrigation consumption
# - fraction of supply
cdo -L -f nc4 -setname,"fraction_of_irr" -setunit,"1" -div total_irrigation_withdrawal_annuaTot_output_${YEAR}.nc annual_total_supply_from_p_and_irr.nc fraction_of_irrigation_supply.nc
# - annual irrigation consumption
cdo -L -f nc4 -setunit,m.year-1 -setname,"irrigation_consumption" -mul fraction_of_irrigation_supply.nc $ ${ANNUAL_ET_IRR} annual_irrigation_consumption_${YEAR}.nc


# get ratio of monthly to annual values of withdrawal
cdo -L -f nc4 -setname,"fraction_of_irr_month_to_year" -setunit,"1" -div total_irrigation_withdrawal_monthTot_output_${YEAR}.nc total_irrigation_withdrawal_annuaTot_output_${YEAR}.nc monthly_ratio_${YEAR}.nc


# get monthly irrigation consumption
cdo -L -f nc4 -setname,"irrigation_consumption" -setunit,"m.month-1" -mul monthly_ratio_${YEAR}.nc annual_irrigation_consumption_${YEAR}.nc monthly_irrigation_consumption_${YEAR}.nc


# get monthly return flow
cdo -L -f nc4 -setname,"irrigation_return_flow" -setunit,"m.month-1" -sub total_irrigation_withdrawal_monthTot_output_${YEAR}.nc monthly_irrigation_consumption_${YEAR}.nc monthly_irrigation_return_flow_${YEAR}.nc

set +x



