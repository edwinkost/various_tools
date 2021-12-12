
set -x

#~ sutan101@gpu038.cluster:/scratch/depfg/sutan101/land_covers_global/version_2021-02-XX$ ls -lah 01_-180_to_-160/global_splitted_clone_30sec/netcdf/
#~ total 284G
#~ dr-xr-xr-x 2 sutan101 depfg    9 Dec 10 23:52 .
#~ dr-xr-xr-x 3 sutan101 depfg  168 Dec 10 23:49 ..
#~ -r--r--r-- 1 sutan101 depfg  71G Dec 11 01:14 composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg  71G Dec 11 00:53 composite-short-n-tall_crop_coefficient.nc
#~ -r--r--r-- 1 sutan101 depfg  71G Dec 11 01:14 composite-short-n-tall_intercept_capacity.nc
#~ -r--r--r-- 1 sutan101 depfg  71G Dec 11 01:14 composite-short-n-tall_leaf_area_index.nc
#~ -r--r--r-- 1 sutan101 depfg 198M Dec 10 23:51 maxrootdepth_all.nc
#~ -r--r--r-- 1 sutan101 depfg 198M Dec 10 23:51 meanrootdepth_all.nc
#~ -r--r--r-- 1 sutan101 depfg 198M Dec 10 23:51 minrootdepth_all.nc
#~ -r--r--r-- 1 sutan101 depfg 198M Dec 10 23:51 rfrac1_all.nc
#~ -r--r--r-- 1 sutan101 depfg 198M Dec 10 23:51 rfrac2_all.nc
#~ sutan101@gpu038.cluster:/scratch/depfg/sutan101/land_covers_global/version_2021-02-XX$ ls -lah */global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 01:14 01_-180_to_-160/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 00:54 02_-160_to_-140/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 01:14 03_-140_to_-120/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 00:54 04_-120_to_-100/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 00:52 05_-100_to_-80/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 01:13 06_-80_to_-60/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 00:52 07_-60_to_-40/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 00:53 08_-40_to_-20/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 10 23:45 09_-20_to_0/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 01:14 10_0_to_20/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 00:53 11_20_to_40/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 01:14 12_40_to_60/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 01:14 13_60_to_80/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 01:14 14_80_to_100/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 01:14 15_100_to_120/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 01:13 16_120_to_140/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 00:53 17_140_to_160/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc
#~ -r--r--r-- 1 sutan101 depfg 71G Dec 11 00:53 18_160_to_180/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc


MAIN_SOURCE_FOLDER="/scratch/depfg/sutan101/land_covers_global/version_2021-02-XX/"

MAIN_OUTPUT_FOLDER="/scratch/depfg/sutan101/land_covers_global/version_2021-02-XX/merged_with_collgrid/"


set -x

# clean output folder
mkdir -p ${MAIN_OUTPUT_FOLDER}
rm ${MAIN_OUTPUT_FOLDER}/*



cdo collgrid ${MAIN_SOURCE_FOLDER}/*/global_splitted_clone_30sec/netcdf/composite-short-n-tall_cover_fraction.nc     ${MAIN_OUTPUT_FOLDER}/composite-short-n-tall_cover_fraction.nc     &
cdo collgrid ${MAIN_SOURCE_FOLDER}/*/global_splitted_clone_30sec/netcdf/composite-short-n-tall_crop_coefficient.nc   ${MAIN_OUTPUT_FOLDER}/composite-short-n-tall_crop_coefficient.nc   &
cdo collgrid ${MAIN_SOURCE_FOLDER}/*/global_splitted_clone_30sec/netcdf/composite-short-n-tall_intercept_capacity.nc ${MAIN_OUTPUT_FOLDER}/composite-short-n-tall_intercept_capacity.nc &
cdo collgrid ${MAIN_SOURCE_FOLDER}/*/global_splitted_clone_30sec/netcdf/rfrac1_all.nc                                ${MAIN_OUTPUT_FOLDER}/rfrac1_all.nc                                &
cdo collgrid ${MAIN_SOURCE_FOLDER}/*/global_splitted_clone_30sec/netcdf/rfrac2_all.nc                                ${MAIN_OUTPUT_FOLDER}/rfrac2_all.nc                                &
wait

cdo collgrid ${MAIN_SOURCE_FOLDER}/*/global_splitted_clone_30sec/netcdf/composite-short-n-tall_leaf_area_index.nc    ${MAIN_OUTPUT_FOLDER}/composite-short-n-tall_leaf_area_index.nc    &
cdo collgrid ${MAIN_SOURCE_FOLDER}/*/global_splitted_clone_30sec/netcdf/minrootdepth_all.nc                          ${MAIN_OUTPUT_FOLDER}/minrootdepth_all.nc                          &
cdo collgrid ${MAIN_SOURCE_FOLDER}/*/global_splitted_clone_30sec/netcdf/maxrootdepth_all.nc                          ${MAIN_OUTPUT_FOLDER}/maxrootdepth_all.nc                          &
cdo collgrid ${MAIN_SOURCE_FOLDER}/*/global_splitted_clone_30sec/netcdf/meanrootdepth_all.nc                         ${MAIN_OUTPUT_FOLDER}/meanrootdepth_all.nc                         &
wait

set +x
