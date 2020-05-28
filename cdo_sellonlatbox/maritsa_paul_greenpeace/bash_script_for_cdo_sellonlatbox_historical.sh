
set -x

MAIN_OUT_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct/maritsa/"

LONLATBOX="22.0,30.0,40.0,45.0"

SCENARIO="historical"

MAIN_INP_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_water_use_all/"
MAIN_INP_FOLDER_LIVESTOCK="/scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_livestock/"


bash bash_script_for_cdo_sellonlatbox.sh ${MAIN_OUT_FOLDER} ${LONLATBOX} ${SCENARIO} 1951-2005 gfdl-esm2m     ${MAIN_INP_FOLDER} ${MAIN_INP_FOLDER_LIVESTOCK} &
bash bash_script_for_cdo_sellonlatbox.sh ${MAIN_OUT_FOLDER} ${LONLATBOX} ${SCENARIO} 1951-2005 hadgem2-es     ${MAIN_INP_FOLDER} ${MAIN_INP_FOLDER_LIVESTOCK} &
bash bash_script_for_cdo_sellonlatbox.sh ${MAIN_OUT_FOLDER} ${LONLATBOX} ${SCENARIO} 1951-2005 ipsl-cm5a-lr   ${MAIN_INP_FOLDER} ${MAIN_INP_FOLDER_LIVESTOCK} &
bash bash_script_for_cdo_sellonlatbox.sh ${MAIN_OUT_FOLDER} ${LONLATBOX} ${SCENARIO} 1951-2005 miroc-esm-chem ${MAIN_INP_FOLDER} ${MAIN_INP_FOLDER_LIVESTOCK} &
bash bash_script_for_cdo_sellonlatbox.sh ${MAIN_OUT_FOLDER} ${LONLATBOX} ${SCENARIO} 1951-2005 noresm1-m      ${MAIN_INP_FOLDER} ${MAIN_INP_FOLDER_LIVESTOCK} &

bash bash_script_for_cdo_sellonlatbox.sh ${MAIN_OUT_FOLDER} ${LONLATBOX} ${SCENARIO} 1958-2001 watch          ${MAIN_INP_FOLDER} ${MAIN_INP_FOLDER_LIVESTOCK} &


wait

set +x
