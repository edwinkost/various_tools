
# request from Paul: discharge, water temperature, and sectoral consumption/withdrawal.
# - we will provide: discharge, temperature, precipitation, sectoral withdrawal, and demand

set -x

LONLATBOX="22.0,30.0,40.0,45.0"

# - discharge
INPUT_FILES=
OUTPUT_FILE= 
python cdo_sellonlatbox.py

# temperature

wait

set +x
