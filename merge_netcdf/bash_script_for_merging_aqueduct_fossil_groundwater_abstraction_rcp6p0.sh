
set -x

GCM_CODE="gfdl-esm2m"
python merging_aqueduct_fossil_groundwater_abstraction.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_feb_rcp6p0/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp6p0/" 2006,2036,2065,2094 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp6p0/2006-2099/${GCM_CODE}/" &

GCM_CODE="hadgem2-es"
python merging_aqueduct_fossil_groundwater_abstraction.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_feb_rcp6p0/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp6p0/" 2006,2037,2067,2098 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp6p0/2006-2099/${GCM_CODE}/" &

GCM_CODE="ipsl-cm5a-lr"
python merging_aqueduct_fossil_groundwater_abstraction.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_feb_rcp6p0/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp6p0/" 2006,2037,2067,2098 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp6p0/2006-2099/${GCM_CODE}/" &

GCM_CODE="miroc-esm-chem"
python merging_aqueduct_fossil_groundwater_abstraction.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_feb_rcp6p0/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp6p0/" 2006,2037,2067,2098 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp6p0/2006-2099/${GCM_CODE}/" &

GCM_CODE="noresm1-m"
python merging_aqueduct_fossil_groundwater_abstraction.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_feb_rcp6p0/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp6p0/" 2006,2037,2067,2098,2099 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp6p0/2006-2099/${GCM_CODE}/" &

wait

set +x
