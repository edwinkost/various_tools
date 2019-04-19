set -x

TARGET_FOLDER=merged_1958_to_2015

STA_YEAR=1958
END_YEAR=1960
SOURCE_FOLDER=begin_from_1958
cdo -L -mergetime ${SOURCE_FOLDER}/global/netcdf/discharge_monthAvg_output_*.nc ${TARGET_FOLDER}/temp.nc
cdo -L -selyear,${STA_YEAR}/${END_YEAR} ${TARGET_FOLDER}/temp.nc ${TARGET_FOLDER}/discharge_monthAvg_output_${STA_YEAR}-01-31_to_${END_YEAR}-12-31.nc
rm ${TARGET_FOLDER}/temp.nc
unset STA_YEAR
unset END_YEAR

STA_YEAR=1961
END_YEAR=1977
SOURCE_FOLDER=continue_from_1961
cdo -L -mergetime ${SOURCE_FOLDER}/global/netcdf/discharge_monthAvg_output_*.nc ${TARGET_FOLDER}/temp.nc
cdo -L -selyear,${STA_YEAR}/${END_YEAR} ${TARGET_FOLDER}/temp.nc ${TARGET_FOLDER}/discharge_monthAvg_output_${STA_YEAR}-01-31_to_${END_YEAR}-12-31.nc
rm ${TARGET_FOLDER}/temp.nc
unset STA_YEAR
unset END_YEAR

STA_YEAR=1978
END_YEAR=1997
SOURCE_FOLDER=continue_from_1978
cdo -L -mergetime ${SOURCE_FOLDER}/global/netcdf/discharge_monthAvg_output_*.nc ${TARGET_FOLDER}/temp.nc
cdo -L -selyear,${STA_YEAR}/${END_YEAR} ${TARGET_FOLDER}/temp.nc ${TARGET_FOLDER}/discharge_monthAvg_output_${STA_YEAR}-01-31_to_${END_YEAR}-12-31.nc
rm ${TARGET_FOLDER}/temp.nc
unset STA_YEAR
unset END_YEAR

STA_YEAR=1998
END_YEAR=2013
SOURCE_FOLDER=continue_from_1998
cdo -L -mergetime ${SOURCE_FOLDER}/global/netcdf/discharge_monthAvg_output_*.nc ${TARGET_FOLDER}/temp.nc
cdo -L -selyear,${STA_YEAR}/${END_YEAR} ${TARGET_FOLDER}/temp.nc ${TARGET_FOLDER}/discharge_monthAvg_output_${STA_YEAR}-01-31_to_${END_YEAR}-12-31.nc
rm ${TARGET_FOLDER}/temp.nc
unset STA_YEAR
unset END_YEAR

STA_YEAR=2014
END_YEAR=2015
SOURCE_FOLDER=continue_from_2014
cdo -L -mergetime ${SOURCE_FOLDER}/global/netcdf/discharge_monthAvg_output_*.nc ${TARGET_FOLDER}/temp.nc
cdo -L -selyear,${STA_YEAR}/${END_YEAR} ${TARGET_FOLDER}/temp.nc ${TARGET_FOLDER}/discharge_monthAvg_output_${STA_YEAR}-01-31_to_${END_YEAR}-12-31.nc
rm ${TARGET_FOLDER}/temp.nc
unset STA_YEAR
unset END_YEAR

set +x
