
# request from Paul: discharge, water temperature, and sectoral consumption/withdrawal.
# - we will provide: discharge, temperature, precipitation, sectoral withdrawal, and demand

set -x

LONLATBOX="22.0,30.0,40.0,45.0"

# - discharge
INPUT_FILES="/scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_water_use_all/historical/1951-2005/gfdl-esm2m/discharge_monthAvg_output"
OUTPUT_FILE=/scratch-shared/edwinhs/pcr-globwb-aqueduct/maritsa/test/historical/1951-2005/gfdl-esm2m/discharge_monthAvg_output_1951-2005.nc 
python cdo_sellonlatbox.py ${LONLATBOX} ${INPUT_FILES} ${OUTPUT_FILE} &

# - temperature
INPUT_FILES="/scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_water_use_all/historical/1951-2005/gfdl-esm2m/temperature_annuaAvg_output"
OUTPUT_FILE=/scratch-shared/edwinhs/pcr-globwb-aqueduct/maritsa/test/historical/1951-2005/gfdl-esm2m/temperature_monthAvg_output_1951-2005.nc 
python cdo_sellonlatbox.py ${LONLATBOX} ${INPUT_FILES} ${OUTPUT_FILE} &

wait

set +x
