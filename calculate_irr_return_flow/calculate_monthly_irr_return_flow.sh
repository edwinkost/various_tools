
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

set -x

YEAR=$1

OUT_DIR="/scratch-shared/edwinhs/monthly_irr_return_flow/"${YEAR}"/"
cd ${OUT_DIR}
rm *

INP_ANNUAL_IRR_CON="/scratch-shared/edwinhs/calculate_irr_return_flow/irrigation_consumption_and_return_flow/annual_irrigation_consumption_1958-2015.nc"
INP_ANNUAL_IRR_ABS="/scratch-shared/edwinhs/calculate_irr_return_flow/irrigationWaterWithdrawal/total_irrigation_withdrawal_annuaTot_output_1958-01-31_to_2015-12-31.nc"

INP_MONTHLY_IRR_ABS="/scratch-shared/edwinhs/calculate_irr_return_flow/irrigationWaterWithdrawal/total_irrigation_withdrawal_monthTot_output_1958-01-31_to_2015-12-31.nc"


# get annual irrigation consumption and withdrawal for that year
cdo selyear,${YEAR} ${INP_ANNUAL_IRR_CON} annual_irrigation_consumption_${YEAR}.nc
cdo selyear,${YEAR} ${INP_ANNUAL_IRR_ABS} annual_irrigation_withdrawal_${YEAR}.nc

# get monthly withdrawal for that year
cdo selyear,${YEAR} ${INP_MONTHLY_IRR_ABS} monthly_irrigation_withdrawal_${YEAR}.nc

# get ratio of monthlt to annual values of withdrawal
cdo div monthly_irrigation_withdrawal_${YEAR}.nc annual_irrigation_withdrawal_${YEAR}.nc monthly_ratio_${YEAR}.nc

# get monthly irrigation consumption
cdo -L -setname,"irrigation_consumption" -setunit,"m.month-1" -mul monthly_ratio_${YEAR}.nc annual_irrigation_consumption_${YEAR}.nc monthly_irrigation_consumption_${YEAR}.nc

# get monthly return flow
cdo -L -setname,"irrigation_return_flow" -setunit,"m.month-1" -sub monthly_irrigation_withdrawal_${YEAR}.nc monthly_irrigation_consumption_${YEAR}.nc monthly_irrigation_return_flow_${YEAR}.nc

set +x



