
set -x

python merge_netcdf_europe_mod.py /scratch/depfg/sutan101/pcrglobwb_output_europe_version_2021-06-XX/europe_30sec_with_30sec_forcing_all_europe/begin_from_1981/ /scratch/depfg/sutan101/pcrglobwb_output_europe_version_2021-06-XX/europe_30sec_with_30sec_forcing_all_europe/begin_from_1981/europe/netcdf/merged outMonthAvgNC 1981-01-31 2019-12-31 discharge,totalWaterStorageThickness,channelStorage NETCDF4 True 8 europe_30sec None &

python merge_netcdf_europe_mod.py /scratch/depfg/sutan101/pcrglobwb_output_europe_version_2021-06-XX/europe_30sec_with_30sec_forcing_all_europe/begin_from_1981/ /scratch/depfg/sutan101/pcrglobwb_output_europe_version_2021-06-XX/europe_30sec_with_30sec_forcing_all_europe/begin_from_1981/europe/netcdf/merged outMonthTotNC 1981-01-31 2019-12-31 totalEvaporation,gwRecharge,totalGroundwaterAbstraction,totalGrossDemand NETCDF4 True 8 europe_30sec None &

wait

set +x
