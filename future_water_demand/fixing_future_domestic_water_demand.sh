
set -x

mkdir -p /scratch-shared/edwinhs/water_demand_for_land_subsidence_model/future_version_20200327/ssp2/domestic/
cd /scratch-shared/edwinhs/water_demand_for_land_subsidence_model/future_version_20200327/ssp2/industry/

HISTORICAL_DEMAND_SOURCE=
HISTORICAL_DEMAND_2010=

cdo -L -selyear,2010 ${HISTORICAL_DEMAND_SOURCE} ${HISTORICAL_DEMAND_2010}

FUTURE_DEMAND_SOURCE=
FUTURE_DEMAND_2010=

cdo -L -selyear,2010 ${FUTURE_DEMAND_SOURCE} ${FUTURE_DEMAND_2010}

DELTA_2010=



cdo -L -selmon,1  ${DELTA_2010} ${DELTA_2010}_month_01
cdo -L -selmon,2  ${DELTA_2010} ${DELTA_2010}_month_02
cdo -L -selmon,3  ${DELTA_2010} ${DELTA_2010}_month_03
cdo -L -selmon,4  ${DELTA_2010} ${DELTA_2010}_month_04
cdo -L -selmon,5  ${DELTA_2010} ${DELTA_2010}_month_05
cdo -L -selmon,6  ${DELTA_2010} ${DELTA_2010}_month_06
cdo -L -selmon,7  ${DELTA_2010} ${DELTA_2010}_month_07
cdo -L -selmon,8  ${DELTA_2010} ${DELTA_2010}_month_08
cdo -L -selmon,9  ${DELTA_2010} ${DELTA_2010}_month_09
cdo -L -selmon,10 ${DELTA_2010} ${DELTA_2010}_month_10
cdo -L -selmon,11 ${DELTA_2010} ${DELTA_2010}_month_11
cdo -L -selmon,12 ${DELTA_2010} ${DELTA_2010}_month_12

cdo -L -add DELTA_2010 -selmon, FUTURE_DEMAND_SOURCE

${FUTURE_DEMAND_2010} ${HISTORICAL_DEMAND_2010} ${DELTA_2010}

