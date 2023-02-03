

#~ sutan101@login01.cluster:/depfg/sutan101/pcrglobwb_wri_aqueduct_2021/pcrglobwb_aqueduct_2021_daily_files/version_2021-09-16$ ls -lah g*/*/begin_from_1960/global/netcdf_daily/*2014*
#~ -r--r--r-- 1 sutan101 depfg 4.2G Jan 18 14:36 gfdl-esm4/historical/begin_from_1960/global/netcdf_daily/baseflow_dailyTot_output_2014-01-01_to_2014-12-31.nc
#~ -r--r--r-- 1 sutan101 depfg 571M Jan 18 14:41 gfdl-esm4/historical/begin_from_1960/global/netcdf_daily/directRunoff_dailyTot_output_2014-01-01_to_2014-12-31.nc
#~ -r--r--r-- 1 sutan101 depfg 2.3G Jan 18 14:57 gfdl-esm4/historical/begin_from_1960/global/netcdf_daily/interflowTotal_dailyTot_output_2014-01-01_to_2014-12-31.nc
#~ -r--r--r-- 1 sutan101 depfg 3.0G Jan 16 12:09 gfdl-esm4/historical/begin_from_1960/global/netcdf_daily/referencePotET_dailyTot_output_2014-01-01_to_2014-12-31.nc
#~ -r--r--r-- 1 sutan101 depfg 4.2G Jan 18 18:51 gswp3-w5e5/historical-reference/begin_from_1960/global/netcdf_daily/baseflow_dailyTot_output_2014-01-01_to_2014-12-31.nc
#~ -r--r--r-- 1 sutan101 depfg 576M Jan 18 18:57 gswp3-w5e5/historical-reference/begin_from_1960/global/netcdf_daily/directRunoff_dailyTot_output_2014-01-01_to_2014-12-31.nc
#~ -r--r--r-- 1 sutan101 depfg 2.2G Jan 18 19:12 gswp3-w5e5/historical-reference/begin_from_1960/global/netcdf_daily/interflowTotal_dailyTot_output_2014-01-01_to_2014-12-31.nc
#~ -r--r--r-- 1 sutan101 depfg 3.0G Jan 16 13:29 gswp3-w5e5/historical-reference/begin_from_1960/global/netcdf_daily/referencePotET_dailyTot_output_2014-01-01_to_2014-12-31.nc

SOURCE_DIR="/depfg/sutan101/pcrglobwb_wri_aqueduct_2021/pcrglobwb_aqueduct_2021_daily_files/version_2021-09-16/"

GCM_NAME="gswp3-w5e5"
VAR_NAME="baseflow"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical-reference_dailyTot_output_1960-2019.nc &
VAR_NAME="interflowTotal"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical-reference_dailyTot_output_1960-2019.nc &
VAR_NAME="directRunoff"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical-reference_dailyTot_output_1960-2019.nc &

GCM_NAME="gfdl-esm4"
VAR_NAME="baseflow"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &
VAR_NAME="interflowTotal"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &
VAR_NAME="directRunoff"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &

wait

GCM_NAME="ipsl-cm6a-lr"
VAR_NAME="baseflow"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &
VAR_NAME="interflowTotal"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &
VAR_NAME="directRunoff"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &

GCM_NAME="mpi-esm1-2-hr"
VAR_NAME="baseflow"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &
VAR_NAME="interflowTotal"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &
VAR_NAME="directRunoff"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &

wait

GCM_NAME="mri-esm2-0"
VAR_NAME="baseflow"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &
VAR_NAME="interflowTotal"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &
VAR_NAME="directRunoff"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &

GCM_NAME="ukesm1-0-ll"
VAR_NAME="baseflow"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &
VAR_NAME="interflowTotal"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &
VAR_NAME="directRunoff"
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/histo*/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_historical_dailyTot_output_1960-2014.nc &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp126/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp126_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp370/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp370_dailyTot_output_2015-2100.nc     &
cdo -L -f nc4 -z zip -setgrid,griddes_clone_global_05min.txt -mergetime ${SOURCE_DIR}/${GCM_NAME}/ssp585/*/global/netcdf_daily/${VAR_NAME}_dailyTot_output_*.nc ${VAR_NAME}_${GCM_NAME}_ssp585_dailyTot_output_2015-2100.nc     &

wait


