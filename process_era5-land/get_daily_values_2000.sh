
set -x

MAIN_HOURLY_SOURCE_DIR="/scratch-shared/edwinhs/test_arise_meteo/hourly/"

#~ edwinhs@fcn17.bullx:/scratch-shared/edwinhs/test_arise_meteo/hourly$ ls -lah
#~ total 64K
#~ drwxr-xr-x 8 edwinhs edwinhs 4.0K Mar 11 16:18 .
#~ drwxr-xr-x 3 edwinhs edwinhs 4.0K Mar 12 00:40 ..
#~ drwxr-xr-x 2 edwinhs edwinhs 4.0K Mar 11 16:54 Variable_Falb
#~ drwxr-xr-x 2 edwinhs edwinhs 4.0K Mar 11 16:54 Variable_Snsr
#~ drwxr-xr-x 2 edwinhs edwinhs 4.0K Mar 11 16:55 Variable_Spre
#~ drwxr-xr-x 2 edwinhs edwinhs 4.0K Mar 11 17:37 Variable_Temp
#~ drwxr-xr-x 2 edwinhs edwinhs 4.0K Mar 11 16:55 Variable_Tpre
#~ drwxr-xr-x 2 edwinhs edwinhs 4.0K Mar 11 17:30 Variable_Wind

DAILY_OUTPUT_FOLDER="/scratch-shared/edwinhs/test_arise_meteo/daily/"
mkdir -p ${DAILY_OUTPUT_FOLDER}

# tp, total precipitation
HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Tpre
# - daily total precipitation, NOTE: using daymax (as hourly source data are accumulative on each day)
cdo -L -b F64 -settime,00:00:00 -setunit,m.day-1 -daymax -selyear,2000/2000 -shifttime,-25min -selvar,tp -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${DAILY_OUTPUT_FOLDER}/tanzania_era5-land_daily_total-preci_2000-2000.nc &

# ssr, surface solar radiation
HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Snsr
# - daily total, NOTE: using daymax (as hourly source data are accumulative on each day)
cdo -L -b F64 -settime,00:00:00 -setunit,J.m-2.day-1 -daymax -selyear,2000/2000 -shifttime,-25min -selvar,ssr -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${DAILY_OUTPUT_FOLDER}/tanzania_era5-land_daily_total-ssrad_2000-2000.nc &

# d2m
HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Temp
# - maximum
cdo -L -b F64 -settime,00:00:00 -setunit,K -daymax -selyear,2000/2000 -shifttime,-25min -selvar,d2m -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${DAILY_OUTPUT_FOLDER}/tanzania_era5-land_daily_d2m-maximum_2000-2000.nc &
# - mean
cdo -L -b F64 -settime,00:00:00 -setunit,K -daymean -selyear,2000/2000 -shifttime,-25min -selvar,d2m -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${DAILY_OUTPUT_FOLDER}/tanzania_era5-land_daily_d2m-average_2000-2000.nc &
# - minimum
cdo -L -b F64 -settime,00:00:00 -setunit,K -daymin -selyear,2000/2000 -shifttime,-25min -selvar,d2m -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${DAILY_OUTPUT_FOLDER}/tanzania_era5-land_daily_d2m-minimum_2000-2000.nc &

# t2m
HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Temp
# - maximum
cdo -L -b F64 -settime,00:00:00 -setunit,K -daymax -selyear,2000/2000 -shifttime,-25min -selvar,t2m -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${DAILY_OUTPUT_FOLDER}/tanzania_era5-land_daily_t2m-maximum_2000-2000.nc &
# - mean
cdo -L -b F64 -settime,00:00:00 -setunit,K -daymean -selyear,2000/2000 -shifttime,-25min -selvar,t2m -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${DAILY_OUTPUT_FOLDER}/tanzania_era5-land_daily_t2m-average_2000-2000.nc &
# - minimum
cdo -L -b F64 -settime,00:00:00 -setunit,K -daymin -selyear,2000/2000 -shifttime,-25min -selvar,t2m -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${DAILY_OUTPUT_FOLDER}/tanzania_era5-land_daily_t2m-minimum_2000-2000.nc &

# fal
HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Falb
# - mean
cdo -L -b F64 -settime,00:00:00 -setunit,dimensionless -daymean -selyear,2000/2000 -shifttime,-25min -selvar,fal -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${DAILY_OUTPUT_FOLDER}/tanzania_era5-land_daily_fal-average_2000-2000.nc &

# sp
HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Spre
# - mean
cdo -L -b F64 -settime,00:00:00 -setunit,Pa -daymean -selyear,2000/2000 -shifttime,-25min -selvar,sp -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${DAILY_OUTPUT_FOLDER}/tanzania_era5-land_daily_spressu-avg_2000-2000.nc &

# u10
HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Wind
# - mean
cdo -L -b F64 -settime,00:00:00 -setunit,m.s-1 -daymean -selyear,2000/2000 -shifttime,-25min -selvar,u10 -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${DAILY_OUTPUT_FOLDER}/tanzania_era5-land_daily_u10-average_2000-2000.nc &

# v10
HOURLY_SOURCE_DIR=${MAIN_HOURLY_SOURCE_DIR}/Variable_Wind
# - mean
cdo -L -b F64 -settime,00:00:00 -setunit,m.s-1 -daymean -selyear,2000/2000 -shifttime,-25min -selvar,v10 -mergetime ${HOURLY_SOURCE_DIR}/*.nc ${DAILY_OUTPUT_FOLDER}/tanzania_era5-land_daily_v10-average_2000-2000.nc &

wait

set +x
