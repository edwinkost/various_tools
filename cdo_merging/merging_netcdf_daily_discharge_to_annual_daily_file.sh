
set -x

MAIN_SOURCE_FOLDER=/scratch-shared/edwinhs/pcrglobwb2_output_gmd_paper_rerun_201902XX/05min/non-natural_kinematic-wave/

MAIN_TARGET_FOLDER=/projects/0/dfguu/users/edwinhs/pcrglobwb2_output_gmd_paper_rerun_201902XX/05min/non-natural_kinematic-wave/
TARGET_FOLDER=${MAIN_TARGET_FOLDER}/merged_1958_to_2015/discharge_dailyTot/

LON_LAT_BOX_FOLDER=${TARGET_FOLDER}/longitudes_55_to_115_latitudes_0_to_50
LON_LAT_BOX_COORDINATE=55,115,0,50
# cdo sellonlatbox,lon1,lon2,lat1,lat2 infile.nc outfile.nc.

# preparing directories
rm -r ${TARGET_FOLDER}
mkdir -p ${TARGET_FOLDER}
mkdir -p ${LON_LAT_BOX_FOLDER}

STA_YEAR=1958
END_YEAR=1960
SOURCE_FOLDER=${MAIN_SOURCE_FOLDER}/*${STA_YEAR}/
for YEAR in {1958..1960}
do 
	# for each year merging monthly files to a single annual file
	cdo -L -f nc4 -mergetime ${SOURCE_FOLDER}/global/netcdf/discharge_dailyTot_output_${YEAR}*.nc ${TARGET_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc
	# sellonlatbox to crop netcdf files 
	cdo -L -f nc4 -sellonlatbox,${LON_LAT_BOX_COORDINATE} ${TARGET_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc ${LON_LAT_BOX_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc
	unset YEAR
done
unset STA_YEAR
unset END_YEAR

STA_YEAR=1961
END_YEAR=1977
SOURCE_FOLDER=${MAIN_SOURCE_FOLDER}/*${STA_YEAR}/
for YEAR in {1961..1977}
do 
	cdo -L -f nc4 -mergetime ${SOURCE_FOLDER}/global/netcdf/discharge_dailyTot_output_${YEAR}*.nc ${TARGET_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc
	cdo -L -f nc4 -sellonlatbox,${LON_LAT_BOX_COORDINATE} ${TARGET_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc ${LON_LAT_BOX_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc
	unset YEAR
done
unset STA_YEAR
unset END_YEAR

STA_YEAR=1978
END_YEAR=1997
SOURCE_FOLDER=${MAIN_SOURCE_FOLDER}/*${STA_YEAR}/
for YEAR in {1978..1997}
do 
	cdo -L -f nc4 -mergetime ${SOURCE_FOLDER}/global/netcdf/discharge_dailyTot_output_${YEAR}*.nc ${TARGET_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc
	cdo -L -f nc4 -sellonlatbox,${LON_LAT_BOX_COORDINATE} ${TARGET_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc ${LON_LAT_BOX_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc
	unset YEAR
done
unset STA_YEAR
unset END_YEAR

STA_YEAR=1998
END_YEAR=2013
SOURCE_FOLDER=${MAIN_SOURCE_FOLDER}/*${STA_YEAR}/
for YEAR in {1998..2013}
do 
	cdo -L -f nc4 -mergetime ${SOURCE_FOLDER}/global/netcdf/discharge_dailyTot_output_${YEAR}*.nc ${TARGET_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc
	cdo -L -f nc4 -sellonlatbox,${LON_LAT_BOX_COORDINATE} ${TARGET_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc ${LON_LAT_BOX_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc
	unset YEAR
done
unset STA_YEAR
unset END_YEAR

STA_YEAR=2014
END_YEAR=2015
SOURCE_FOLDER=${MAIN_SOURCE_FOLDER}/*${STA_YEAR}/
for YEAR in {2014..2015}
do 
	cdo -L -f nc4 -mergetime ${SOURCE_FOLDER}/global/netcdf/discharge_dailyTot_output_${YEAR}*.nc ${TARGET_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc
	cdo -L -f nc4 -sellonlatbox,${LON_LAT_BOX_COORDINATE} ${TARGET_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc ${LON_LAT_BOX_FOLDER}/discharge_dailyTot_output_${YEAR}-01-01_to_${YEAR}-12-31.nc
	unset YEAR
done
unset STA_YEAR
unset END_YEAR

set +x

