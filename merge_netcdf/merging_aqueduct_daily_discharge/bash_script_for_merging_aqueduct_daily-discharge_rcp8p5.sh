
set -x

GCM_CODE="gfdl-esm2m"
python merging_aqueduct_daily-discharge.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp8p5/" 2006,2031,2039,2059,2061,2092 2099 "/scratch-shared/edwinhs/pcrglobwb_aqueduct_version_2016-2018/aqueduct_daily_discharge/rcp8p5/2006-2099/${GCM_CODE}/" &

GCM_CODE="hadgem2-es"
python merging_aqueduct_daily-discharge.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp8p5/" 2006,2013,2027,2031,2035,2055,2086 2099 "/scratch-shared/edwinhs/pcrglobwb_aqueduct_version_2016-2018/aqueduct_daily_discharge/rcp8p5/2006-2099/${GCM_CODE}/" &

GCM_CODE="ipsl-cm5a-lr"
python merging_aqueduct_daily-discharge.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp8p5/" 2006,2031,2033,2053,2084 2099 "/scratch-shared/edwinhs/pcrglobwb_aqueduct_version_2016-2018/aqueduct_daily_discharge/rcp8p5/2006-2099/${GCM_CODE}/" &

GCM_CODE="miroc-esm-chem"
python merging_aqueduct_daily-discharge.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp8p5/" 2006,2030,2031,2033,2053,2084 2099 "/scratch-shared/edwinhs/pcrglobwb_aqueduct_version_2016-2018/aqueduct_daily_discharge/rcp8p5/2006-2099/${GCM_CODE}/" &

GCM_CODE="noresm1-m"
python merging_aqueduct_daily-discharge.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp8p5/" 2006,2025,2031,2033,2053,2084 2099 "/scratch-shared/edwinhs/pcrglobwb_aqueduct_version_2016-2018/aqueduct_daily_discharge/rcp8p5/2006-2099/${GCM_CODE}/" &

wait

set +x
