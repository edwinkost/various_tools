
set -x

bash bash_script_for_merging_aqueduct_baseflow_historical.sh 

bash bash_script_for_merging_aqueduct_baseflow_rcp2p6.sh 

bash bash_script_for_merging_aqueduct_baseflow_rcp6p0.sh 

bash bash_script_for_merging_aqueduct_baseflow_rcp4p5.sh 

bash bash_script_for_merging_aqueduct_baseflow_rcp8p5.sh

set +x
