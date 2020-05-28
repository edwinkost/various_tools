
set -x

SCENARIO="rcp2p6"
SCENARIO=$1

MAIN_OUT_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct/random/"
MAIN_OUT_FOLDER=$2

LONLATBOX="22.0,30.0,40.0,45.0"
LONLATBOX=$3


MAIN_INP_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_water_use_all/"
MAIN_INP_FOLDER_LIVESTOCK="/scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_livestock/"


bash bash_script_for_cdo_sellonlatbox.sh ${MAIN_OUT_FOLDER} ${LONLATBOX} ${SCENARIO} 2006-2099 gfdl-esm2m     ${MAIN_INP_FOLDER} ${MAIN_INP_FOLDER_LIVESTOCK} &
bash bash_script_for_cdo_sellonlatbox.sh ${MAIN_OUT_FOLDER} ${LONLATBOX} ${SCENARIO} 2006-2099 hadgem2-es     ${MAIN_INP_FOLDER} ${MAIN_INP_FOLDER_LIVESTOCK} &
bash bash_script_for_cdo_sellonlatbox.sh ${MAIN_OUT_FOLDER} ${LONLATBOX} ${SCENARIO} 2006-2099 ipsl-cm5a-lr   ${MAIN_INP_FOLDER} ${MAIN_INP_FOLDER_LIVESTOCK} &
bash bash_script_for_cdo_sellonlatbox.sh ${MAIN_OUT_FOLDER} ${LONLATBOX} ${SCENARIO} 2006-2099 miroc-esm-chem ${MAIN_INP_FOLDER} ${MAIN_INP_FOLDER_LIVESTOCK} &
bash bash_script_for_cdo_sellonlatbox.sh ${MAIN_OUT_FOLDER} ${LONLATBOX} ${SCENARIO} 2006-2099 noresm1-m      ${MAIN_INP_FOLDER} ${MAIN_INP_FOLDER_LIVESTOCK} &

wait

set +x
