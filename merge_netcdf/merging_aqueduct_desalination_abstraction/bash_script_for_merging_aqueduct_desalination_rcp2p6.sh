
set -x

GCM_CODE="gfdl-esm2m"
python merging_aqueduct_desalination.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_may_jun_rcp2p6/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp2p6/" 2006,2011,2017,2048,2079 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp2p6/2006-2099/${GCM_CODE}/" &

GCM_CODE="hadgem2-es"
python merging_aqueduct_desalination.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_may_jun_rcp2p6/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp2p6/" 2006,2037,2043,2074 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp2p6/2006-2099/${GCM_CODE}/" &

GCM_CODE="ipsl-cm5a-lr"
python merging_aqueduct_desalination.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_may_jun_rcp2p6/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp2p6/" 2006,2037,2051,2074 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp2p6/2006-2099/${GCM_CODE}/" &

GCM_CODE="miroc-esm-chem"
python merging_aqueduct_desalination.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_may_jun_rcp2p6/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp2p6/" 2006,2037,2050,2073 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp2p6/2006-2099/${GCM_CODE}/" &

GCM_CODE="noresm1-m"
python merging_aqueduct_desalination.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2017_may_jun_rcp2p6/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/rcp2p6/" 2006,2037,2051,2075,2099 2099 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/rcp2p6/2006-2099/${GCM_CODE}/" &

wait

set +x
