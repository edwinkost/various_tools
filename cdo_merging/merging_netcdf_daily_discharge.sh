set -x

MAIN_SOURCE_FOLDER=/scratch-shared/edwinhs/pcrglobwb2_output_gmd_paper_rerun_201902XX/05min/non-natural_kinematic-wave/
TARGET_FOLDER=${MAIN_SOURCE_FOLDER}/merged_1958_to_2015/discharge_dailyTot/

mkdir -p ${TARGET_FOLDER}

STA_YEAR=1958
END_YEAR=1960
SOURCE_FOLDER=${MAIN_SOURCE_FOLDER}/begin_from_1958/
cdo -L -f nc4 -cat ${SOURCE_FOLDER}/global/netcdf/discharge_dailyTot_output_*.nc ${TARGET_FOLDER}/temp.nc
cdo -L -f nc4 -selyear,${STA_YEAR}/${END_YEAR} ${TARGET_FOLDER}/temp.nc ${TARGET_FOLDER}/discharge_dailyTot_output_${STA_YEAR}-01-01_to_${END_YEAR}-12-31.nc
rm ${TARGET_FOLDER}/temp.nc
unset STA_YEAR
unset END_YEAR

STA_YEAR=1961
END_YEAR=1977
SOURCE_FOLDER=${MAIN_SOURCE_FOLDER}/continue_from_1961/
cdo -L -f nc4 -cat ${SOURCE_FOLDER}/global/netcdf/discharge_dailyTot_output_*.nc ${TARGET_FOLDER}/temp.nc
cdo -L -f nc4 -selyear,${STA_YEAR}/${END_YEAR} ${TARGET_FOLDER}/temp.nc ${TARGET_FOLDER}/discharge_dailyTot_output_${STA_YEAR}-01-01_to_${END_YEAR}-12-31.nc
rm ${TARGET_FOLDER}/temp.nc
unset STA_YEAR
unset END_YEAR

STA_YEAR=1978
END_YEAR=1997
SOURCE_FOLDER=${MAIN_SOURCE_FOLDER}/continue_from_1978/
cdo -L -f nc4 -cat ${SOURCE_FOLDER}/global/netcdf/discharge_dailyTot_output_*.nc ${TARGET_FOLDER}/temp.nc
cdo -L -f nc4 -selyear,${STA_YEAR}/${END_YEAR} ${TARGET_FOLDER}/temp.nc ${TARGET_FOLDER}/discharge_dailyTot_output_${STA_YEAR}-01-01_to_${END_YEAR}-12-31.nc
rm ${TARGET_FOLDER}/temp.nc
unset STA_YEAR
unset END_YEAR

STA_YEAR=1998
END_YEAR=2013
SOURCE_FOLDER=${MAIN_SOURCE_FOLDER}/continue_from_1998/
cdo -L -f nc4 -cat ${SOURCE_FOLDER}/global/netcdf/discharge_dailyTot_output_*.nc ${TARGET_FOLDER}/temp.nc
cdo -L -f nc4 -selyear,${STA_YEAR}/${END_YEAR} ${TARGET_FOLDER}/temp.nc ${TARGET_FOLDER}/discharge_dailyTot_output_${STA_YEAR}-01-01_to_${END_YEAR}-12-31.nc
rm ${TARGET_FOLDER}/temp.nc
unset STA_YEAR
unset END_YEAR

STA_YEAR=2014
END_YEAR=2015
SOURCE_FOLDER=${MAIN_SOURCE_FOLDER}/continue_from_2014/
cdo -L -f nc4 -cat ${SOURCE_FOLDER}/global/netcdf/discharge_dailyTot_output_*.nc ${TARGET_FOLDER}/temp.nc
cdo -L -f nc4 -selyear,${STA_YEAR}/${END_YEAR} ${TARGET_FOLDER}/temp.nc ${TARGET_FOLDER}/discharge_dailyTot_output_${STA_YEAR}-01-01_to_${END_YEAR}-12-31.nc
rm ${TARGET_FOLDER}/temp.nc
unset STA_YEAR
unset END_YEAR

set +x
