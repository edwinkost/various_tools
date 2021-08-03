
set -x

. /quanta1/home/sutan101/load_my_miniconda_and_my_default_env.sh

GCM_CODE_CAPITAL="GFDL-ESM4"
GCM_CODE_SMALL="gfdl-esm4"
GCM_CODE_CAPITAL=$1
GCM_CODE_SMALL=$2

echo ${GCM_CODE_CAPITAL}
echo ${GCM_CODE_SMALL}


SOURCE_DIR="/scratch/depfg/sutan101/data/isimip_forcing/isimip3b_version_2021-05-XX/copied_on_2021-06-XX/source/historical/"${GCM_CODE_CAPITAL}"/"
OUTPUT_DIR="/scratch/depfg/sutan101/data/isimip_forcing/isimip3b_version_2021-05-XX/copied_on_2021-06-XX/merged/historical/"${GCM_CODE_SMALL}"/"

#~ -r--r--r-- 1 sutan101 depfg 957M Jun 29 22:46 gfdl-esm4_r1i1p1f1_w5e5_historical_hurs_global_daily_2011_2014.nc
#~ -r--r--r-- 1 sutan101 depfg 1.1G Jun 29 22:57 gfdl-esm4_r1i1p1f1_w5e5_historical_huss_global_daily_2011_2014.nc
#~ -r--r--r-- 1 sutan101 depfg 790M Jun 29 23:08 gfdl-esm4_r1i1p1f1_w5e5_historical_pr_global_daily_2011_2014.nc
#~ -r--r--r-- 1 sutan101 depfg 289M Jun 29 23:12 gfdl-esm4_r1i1p1f1_w5e5_historical_prsn_global_daily_2011_2014.nc
#~ -r--r--r-- 1 sutan101 depfg 805M Jun 29 23:22 gfdl-esm4_r1i1p1f1_w5e5_historical_ps_global_daily_2011_2014.nc
#~ -r--r--r-- 1 sutan101 depfg 938M Jun 29 23:36 gfdl-esm4_r1i1p1f1_w5e5_historical_rlds_global_daily_2011_2014.nc
#~ -r--r--r-- 1 sutan101 depfg 965M Jun 29 23:49 gfdl-esm4_r1i1p1f1_w5e5_historical_rsds_global_daily_2011_2014.nc
#~ -r--r--r-- 1 sutan101 depfg 1.1G Jun 30 00:03 gfdl-esm4_r1i1p1f1_w5e5_historical_sfcwind_global_daily_2011_2014.nc
#~ -r--r--r-- 1 sutan101 depfg 787M Jun 30 00:14 gfdl-esm4_r1i1p1f1_w5e5_historical_tas_global_daily_2011_2014.nc
#~ -r--r--r-- 1 sutan101 depfg 791M Jun 30 00:24 gfdl-esm4_r1i1p1f1_w5e5_historical_tasmax_global_daily_2011_2014.nc
#~ -r--r--r-- 1 sutan101 depfg 795M Jun 30 00:35 gfdl-esm4_r1i1p1f1_w5e5_historical_tasmin_global_daily_2011_2014.nc

mkdir -p ${OUTPUT_DIR}
cd ${OUTPUT_DIR}

cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_hurs_global_daily_*.nc    ${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_hurs_global_daily_1850_2014.nc    &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_pr_global_daily_*.nc      ${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_pr_global_daily_1850_2014.nc      &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_ps_global_daily_*.nc      ${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_ps_global_daily_1850_2014.nc      &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_rsds_global_daily_*.nc    ${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_rsds_global_daily_1850_2014.nc    &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_sfcwind_global_daily_*.nc ${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_sfcwind_global_daily_1850_2014.nc &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_tas_global_daily_*.nc     ${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_tas_global_daily_1850_2014.nc     &

#~ # - not merged, not needed for PCR-GLOBWB
#~ cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_huss_global_daily_*.nc    ${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_huss_global_daily_1850_2014.nc    &
#~ cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_prsn_global_daily_*.nc    ${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_prsn_global_daily_1850_2014.nc    &
#~ cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_rlds_global_daily_*.nc    ${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_rlds_global_daily_1850_2014.nc    &
#~ cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_tasmax_global_daily_*.nc  ${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_tasmax_global_daily_1850_2014.nc  &
#~ cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_tasmin_global_daily_*.nc  ${GCM_CODE_SMALL}_r1i1p1f1_w5e5_historical_tasmin_global_daily_1850_2014.nc  &

wait

set +x

