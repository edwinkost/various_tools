
set -x

GCM_CODE="gfdl-esm2m"
python merging_aqueduct_fossil_groundwater_abstraction.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_feb_rcp4p5/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp4p5/" 2006,2031,2039,2055,2080 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp4p5/2006-2099/${GCM_CODE}/" &

GCM_CODE="hadgem2-es"
python merging_aqueduct_fossil_groundwater_abstraction.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_feb_rcp4p5/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp4p5/" 2006,2012,2027,2031,2036,2056,2087 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp4p5/2006-2099/${GCM_CODE}/" &

GCM_CODE="ipsl-cm5a-lr"
python merging_aqueduct_fossil_groundwater_abstraction.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_feb_rcp4p5/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp4p5/" 2006,2031,2033,2049,2051,2082 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp4p5/2006-2099/${GCM_CODE}/" &

GCM_CODE="miroc-esm-chem"
python merging_aqueduct_fossil_groundwater_abstraction.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_feb_rcp4p5/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp4p5/" 2006,2030,2031,2033,2053,2084 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp4p5/2006-2099/${GCM_CODE}/" &

GCM_CODE="noresm1-m"
python merging_aqueduct_fossil_groundwater_abstraction.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_feb_rcp4p5/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp4p5/" 2006,2031,2033,2053,2084 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp4p5/2006-2099/${GCM_CODE}/" &

wait

set +x
