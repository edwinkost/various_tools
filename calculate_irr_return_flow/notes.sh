
#~ working directory: /scratch-shared/edwinhs/calculate_irr_return_flow/

#~ - evaporation_from_irrigation
#~ edwinhs@int1.bullx:/scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/M53/netcdf$ ls -lah evaporation_from_irrigation_annuaTot_output.nc
#~ -rw-r--r-- 1 edwinvua edwinvua 2.6M Feb 23 06:53 evaporation_from_irrigation_annuaTot_output.nc

python merge_netcdf.py /scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/ /scratch-shared/edwinhs/calculate_irr_return_flow/evaporation_from_irr/ outAnnuaTotNC 1958-12-31 2015-12-31 evaporation_from_irrigation NETCDF4 True 1 Global

#~ irrigationWaterWithdrawal: 
#~ edwinhs@int1.bullx:/scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/M53/netcdf$ ls -lah *addy*month*
#~ -rw-r--r-- 1 edwinvua edwinvua  18M Feb 23 06:53 irrNonPaddyWaterWithdrawal_monthTot_output.nc
#~ -rw-r--r-- 1 edwinvua edwinvua 6.4M Feb 23 06:53 irrPaddyWaterWithdrawal_monthTot_output.nc

python merge_netcdf.py /scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/ /scratch-shared/edwinhs/calculate_irr_return_flow/irrigationWaterWithdrawal/ outMonthTotNC 1958-01-31 2015-12-31 irrNonPaddyWaterWithdrawal,irrPaddyWaterWithdrawal NETCDF4 True 2 Global

Formula A:
- irrigation_water_consumption = evaporation_from_irrigation * irrigationWaterWithdrawal / (precipitation + irrigationWaterWithdrawal) 
- irrigation_return_flow = irrigationWaterWithdrawal  - irrigation_water_consumption 

Formula B:
- irrigation_water_consumption = irrigation_efficiency * irrigationWaterWithdrawal  
- irrigation_return_flow = irrigationWaterWithdrawal  - irrigation_water_consumption 
- irrigation_return_flow = (1 - irrigation_efficiency) * irrigationWaterWithdrawal

Steps:
1. Calculate the return flow at the annual resolution. 
2. Downscale step 1 to the monthly resolution with the formula B.

FRACTION OF SURFACE RUNOFF

python merge_netcdf.py /scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/ /scratch-shared/edwinhs/calculate_irr_return_flow/fraction_of_surface_runoff/ outMonthTotNC 1958-01-31 2015-12-31 directRunoff,runoff NETCDF4 True 2 Global

SURFACE_RUNOFF_FLOW from urban area (m3/month): urban_area_fraction x directRunoff




#~ edwinhs@tcn886.bullx:/home/edwinhs$ ls -lah /scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/M53/netcdf/baseflow_*
#~ -rw-r--r-- 1 edwinvua edwinvua 6.7M Feb 23 06:53 /scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/M53/netcdf/baseflow_annuaTot_output.nc
#~ -rw-r--r-- 1 edwinvua edwinvua  82M Feb 23 06:53 /scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/M53/netcdf/baseflow_monthTot_output.nc
#~ edwinhs@tcn886.bullx:/home/edwinhs$ ls -lah /scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/M53/netcdf/inter
#~ interceptStor_annuaAvg_output.nc   interceptStor_annuaEnd_output.nc   interceptStor_monthAvg_output.nc   interflowTotal_monthTot_output.nc
#~ edwinhs@tcn886.bullx:/home/edwinhs$ ls -lah /scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/M53/netcdf/interflowTotal_monthTot_output.nc
#~ -rw-r--r-- 1 edwinvua edwinvua 69M Feb 23 06:53 /scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/M53/netcdf/interflowTotal_monthTot_output.nc
#~ edwinhs@tcn886.bullx:/home/edwinhs$ ls -lah /scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/M53/netcdf/directRunoff_monthTot_output.nc
#~ -rw-r--r-- 1 edwinvua edwinvua 65M Feb 23 06:53 /scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/M53/netcdf/directRunoff_monthTot_outp

