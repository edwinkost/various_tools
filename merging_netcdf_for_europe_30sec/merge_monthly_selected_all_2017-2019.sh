
set -x

INP_FOLDER="/scratch-shared/edwin/pcrglobwb_output_europe_version_2021-06-XX/europe_30sec_with_05min_forcing_all_europe/continue_from_2017/"
OUT_FOLDER="/scratch-shared/edwin/pcrglobwb_output_europe_version_2021-06-XX/europe_30sec_with_05min_forcing_all_europe/merged_netcdf_2017-2019/"

python merge_netcdf_europe_mod.py ${INP_FOLDER} ${OUT_FOLDER} outMonthAvgNC 2017-01-31 2019-12-31 discharge,totalWaterStorageThickness,channelStorage,satDegUpp,storUppTotal,temperature NETCDF4 True 8 europe_30sec None &

python merge_netcdf_europe_mod.py ${INP_FOLDER} ${OUT_FOLDER} outMonthTotNC 2017-01-31 2019-12-31 totalEvaporation,gwRecharge,totalGroundwaterAbstraction,totalGrossDemand,precipitation,totalRunoff NETCDF4 True 8 europe_30sec None &

INP_FOLDER="/scratch-shared/edwin/pcrglobwb_output_europe_version_2021-06-XX/europe_30sec_with_30min_forcing_all_europe/continue_from_2017/"
OUT_FOLDER="/scratch-shared/edwin/pcrglobwb_output_europe_version_2021-06-XX/europe_30sec_with_30min_forcing_all_europe/merged_netcdf_2017-2019/"

python merge_netcdf_europe_mod.py ${INP_FOLDER} ${OUT_FOLDER} outMonthAvgNC 2017-01-31 2019-12-31 discharge,totalWaterStorageThickness,channelStorage,satDegUpp,storUppTotal,temperature NETCDF4 True 8 europe_30sec None &

python merge_netcdf_europe_mod.py ${INP_FOLDER} ${OUT_FOLDER} outMonthTotNC 2017-01-31 2019-12-31 totalEvaporation,gwRecharge,totalGroundwaterAbstraction,totalGrossDemand,precipitation,totalRunoff NETCDF4 True 8 europe_30sec None &

wait

set +x
