
set -x

# historical watch
python merging_aqueduct_fossil_groundwater_abstraction.py "/projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_watch_kinematicwave/no_correction/non-natural/" 1958,1976,1985 2001 "/projects/0/dfguu/users/edwin/pcr-globwb-aqueduct/historical/1958-2001_watch/"

#~ # historical gcm
#~ GCM_CODE="gfdl-esm2m"

set +x
