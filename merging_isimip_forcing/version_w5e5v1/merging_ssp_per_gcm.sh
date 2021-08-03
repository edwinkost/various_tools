
set -x

. /quanta1/home/sutan101/load_my_miniconda_and_my_default_env.sh

#~ GCM_CODE_CAPITAL="GFDL-ESM4"
#~ GCM_CODE_SMALL="gfdl-esm4"

GCM_CODE_CAPITAL=$1
GCM_CODE_SMALL=$2

SSP_CODE=$3

echo ${GCM_CODE_CAPITAL}
echo ${GCM_CODE_SMALL}
echo ${SSP_CODE}


SOURCE_DIR="/scratch/depfg/sutan101/data/isimip_forcing/isimip3b/copied_on_2020-12-XX/source/"${SSP_CODE}"/"${GCM_CODE_CAPITAL}"/"

OUTPUT_DIR="/scratch/depfg/sutan101/data/isimip_forcing/isimip3b/copied_on_2020-12-XX/merged/"${SSP_CODE}"/"${GCM_CODE_SMALL}"/"

#~ OUTPUT_DIR="/scratch/depfg/sutan101/data/isimip_forcing/isimip3b/copied_on_2020-12-XX/merged_test/"${SSP_CODE}"/"${GCM_CODE_SMALL}"/"

mkdir -p ${OUTPUT_DIR}
cd ${OUTPUT_DIR}

cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_${SSP_CODE}_hurs_global_daily_*.nc    ${GCM_CODE_SMALL}_w5e5v1_${SSP_CODE}_hurs_global_daily_2015_2100.nc    &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_${SSP_CODE}_pr_global_daily_*.nc      ${GCM_CODE_SMALL}_w5e5v1_${SSP_CODE}_pr_global_daily_2015_2100.nc      &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_${SSP_CODE}_ps_global_daily_*.nc      ${GCM_CODE_SMALL}_w5e5v1_${SSP_CODE}_ps_global_daily_2015_2100.nc      &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_${SSP_CODE}_rsds_global_daily_*.nc    ${GCM_CODE_SMALL}_w5e5v1_${SSP_CODE}_rsds_global_daily_2015_2100.nc    &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_${SSP_CODE}_sfcwind_global_daily_*.nc ${GCM_CODE_SMALL}_w5e5v1_${SSP_CODE}_sfcwind_global_daily_2015_2100.nc &
cdo -L -f nc4 -mergetime ${SOURCE_DIR}/${GCM_CODE_SMALL}_*_w5e5_${SSP_CODE}_tas_global_daily_*.nc     ${GCM_CODE_SMALL}_w5e5v1_${SSP_CODE}_tas_global_daily_2015_2100.nc     &

wait

set +x

#~ sutan101@gpu038.cluster:/scratch/depfg/sutan101/data/isimip_forcing/isimip3b/copied_on_2020-12-XX/source$ ls -lah ssp*/*/*huss*2100*
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 29 23:04 ssp126/GFDL-ESM4/gfdl-esm4_r1i1p1f1_w5e5_ssp126_huss_global_daily_2091_2100.nc
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 30 00:11 ssp126/IPSL-CM6A-LR/ipsl-cm6a-lr_r1i1p1f1_w5e5_ssp126_huss_global_daily_2091_2100.nc
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 30 01:14 ssp126/MPI-ESM1-2-HR/mpi-esm1-2-hr_r1i1p1f1_w5e5_ssp126_huss_global_daily_2091_2100.nc
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 30 02:17 ssp126/MRI-ESM2-0/mri-esm2-0_r1i1p1f1_w5e5_ssp126_huss_global_daily_2091_2100.nc
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 30 03:19 ssp126/UKESM1-0-LL/ukesm1-0-ll_r1i1p1f2_w5e5_ssp126_huss_global_daily_2091_2100.nc
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 30 04:21 ssp370/GFDL-ESM4/gfdl-esm4_r1i1p1f1_w5e5_ssp370_huss_global_daily_2091_2100.nc
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 30 05:25 ssp370/IPSL-CM6A-LR/ipsl-cm6a-lr_r1i1p1f1_w5e5_ssp370_huss_global_daily_2091_2100.nc
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 30 06:29 ssp370/MPI-ESM1-2-HR/mpi-esm1-2-hr_r1i1p1f1_w5e5_ssp370_huss_global_daily_2091_2100.nc
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 30 09:01 ssp370/MRI-ESM2-0/mri-esm2-0_r1i1p1f1_w5e5_ssp370_huss_global_daily_2091_2100.nc
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 30 09:56 ssp370/UKESM1-0-LL/ukesm1-0-ll_r1i1p1f2_w5e5_ssp370_huss_global_daily_2091_2100.nc
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 30 10:56 ssp585/GFDL-ESM4/gfdl-esm4_r1i1p1f1_w5e5_ssp585_huss_global_daily_2091_2100.nc
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 30 12:01 ssp585/IPSL-CM6A-LR/ipsl-cm6a-lr_r1i1p1f1_w5e5_ssp585_huss_global_daily_2091_2100.nc
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 30 13:00 ssp585/MPI-ESM1-2-HR/mpi-esm1-2-hr_r1i1p1f1_w5e5_ssp585_huss_global_daily_2091_2100.nc
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 30 14:01 ssp585/MRI-ESM2-0/mri-esm2-0_r1i1p1f1_w5e5_ssp585_huss_global_daily_2091_2100.nc
#~ -r--r--r-- 1 sutan101 depfg 2.6G Jun 30 15:08 ssp585/UKESM1-0-LL/ukesm1-0-ll_r1i1p1f2_w5e5_ssp585_huss_global_daily_2091_2100.nc
