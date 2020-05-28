
set -x

MAIN_OUT_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct/china/"

#~ Paul: the bounding box for China is 54°N 73°E-18°N 135.5°E

LONLATBOX="72.0,137.0,16.0,56.0"

bash bash_script_for_cdo_sellonlatbox_historical.sh historical ${MAIN_OUT_FOLDER} ${LONLATBOX}

bash bash_script_for_cdo_sellonlatbox_rcpxxx.sh     rcp2p6     ${MAIN_OUT_FOLDER} ${LONLATBOX} &
bash bash_script_for_cdo_sellonlatbox_rcpxxx.sh     rcp6p0     ${MAIN_OUT_FOLDER} ${LONLATBOX} &
wait

bash bash_script_for_cdo_sellonlatbox_rcpxxx.sh     rcp4p5     ${MAIN_OUT_FOLDER} ${LONLATBOX} &
bash bash_script_for_cdo_sellonlatbox_rcpxxx.sh     rcp8p5     ${MAIN_OUT_FOLDER} ${LONLATBOX} &
wait

set +x
