
set -x

bash bash_script_for_merging_aqueduct_daily-discharge_historical.sh &

bash bash_script_for_merging_aqueduct_daily-discharge_rcp2p6.sh &

bash bash_script_for_merging_aqueduct_daily-discharge_rcp6p0.sh &

bash bash_script_for_merging_aqueduct_daily-discharge_rcp4p5.sh &

bash bash_script_for_merging_aqueduct_daily-discharge_rcp8p5.sh &

wait

set +x
