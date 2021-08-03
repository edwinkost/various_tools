
set -x

. /quanta1/home/sutan101/load_my_miniconda_and_my_default_env.sh

#~ GCM_CODE_CAPITAL="GFDL-ESM4"
#~ GCM_CODE_SMALL="gfdl-esm4"

GCM_CODE_CAPITAL=$1
GCM_CODE_SMALL=$2

echo ${GCM_CODE_CAPITAL}
echo ${GCM_CODE_SMALL}


SOURCE_DIR="/scratch/depfg/sutan101/data/isimip_forcing/isimip3b/copied_on_2020-12-XX/source/historical/"${GCM_CODE_CAPITAL}"/"
OUTPUT_DIR="/scratch/depfg/sutan101/data/isimip_forcing/isimip3b/copied_on_2020-12-XX/merged/historical/"${GCM_CODE_SMALL}"/"

mkdir -p ${OUTPUT_DIR}
cd ${OUTPUT_DIR}

cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_historical_hurs_global_daily_*.nc    ${GCM_CODE_SMALL}_w5e5v1_historical_hurs_global_daily_1850_2014.nc    &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_historical_pr_global_daily_*.nc      ${GCM_CODE_SMALL}_w5e5v1_historical_pr_global_daily_1850_2014.nc      &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_historical_ps_global_daily_*.nc      ${GCM_CODE_SMALL}_w5e5v1_historical_ps_global_daily_1850_2014.nc      &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_historical_rsds_global_daily_*.nc    ${GCM_CODE_SMALL}_w5e5v1_historical_rsds_global_daily_1850_2014.nc    &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_historical_sfcwind_global_daily_*.nc ${GCM_CODE_SMALL}_w5e5v1_historical_sfcwind_global_daily_1850_2014.nc &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_historical_tas_global_daily_*.nc     ${GCM_CODE_SMALL}_w5e5v1_historical_tas_global_daily_1850_2014.nc     &

#~ # - not merged, not needed for PCR-GLOBWB
#~ cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_historical_huss_global_daily_*.nc    ${GCM_CODE_SMALL}_w5e5v1_historical_huss_global_daily_1850_2014.nc    &
#~ cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_historical_prsn_global_daily_*.nc    ${GCM_CODE_SMALL}_w5e5v1_historical_prsn_global_daily_1850_2014.nc    &
#~ cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_historical_rlds_global_daily_*.nc    ${GCM_CODE_SMALL}_w5e5v1_historical_rlds_global_daily_1850_2014.nc    &
#~ cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_historical_tasmax_global_daily_*.nc  ${GCM_CODE_SMALL}_w5e5v1_historical_tasmax_global_daily_1850_2014.nc  &
#~ cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_historical_tasmin_global_daily_*.nc  ${GCM_CODE_SMALL}_w5e5v1_historical_tasmin_global_daily_1850_2014.nc  &

wait

set +x

