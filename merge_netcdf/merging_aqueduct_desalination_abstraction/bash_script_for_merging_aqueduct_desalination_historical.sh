
set -x

# historical watch
python merging_aqueduct_desalination.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_watch_kinematicwave/no_correction/non-natural/" 1958,1976,1985 2001 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/historical/1958-2001_watch/" &

# historical gcm
GCM_CODE="gfdl-esm2m"
python merging_aqueduct_desalination.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/non-natural/" 1951,1958,1988,1990 2005 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/historical/1951-2005/${GCM_CODE}/" &

# historical gcm
GCM_CODE="hadgem2-es"
python merging_aqueduct_desalination.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/non-natural/" 1951,1955,1979,1988 2005 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/historical/1951-2005/${GCM_CODE}/" &

# historical gcm
GCM_CODE="ipsl-cm5a-lr"
python merging_aqueduct_desalination.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/non-natural/" 1951,1972,1993 2005 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/historical/1951-2005/${GCM_CODE}/" &

# historical gcm
GCM_CODE="miroc-esm-chem"
python merging_aqueduct_desalination.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/non-natural/" 1951,1960,1984 2005 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/historical/1951-2005/${GCM_CODE}/" &

# historical gcm
GCM_CODE="noresm1-m"
python merging_aqueduct_desalination.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_${GCM_CODE}/no_correction/non-natural/" 1951,1960,1990 2005 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/historical/1951-2005/${GCM_CODE}/" &

wait

set +x
