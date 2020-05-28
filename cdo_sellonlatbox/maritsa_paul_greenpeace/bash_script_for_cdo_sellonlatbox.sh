
# request from Paul: discharge, water temperature, and sectoral consumption/withdrawal.
# - we will provide: discharge, temperature, precipitation, sectoral withdrawal, and demand

set -x

MAIN_INP_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_water_use_all/"

LONLATBOX="22.0,30.0,40.0,45.0"

SCENARIO="historical"

PERIODYR="1951-2005"

GCM_CODE="gfdl-esm2m"

MAIN_OUT_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct/maritsa/test_with_bash/"


#~ # - discharge
#~ FILE_VARIABLE_NAME=discharge_monthAvg
#~ INPUT_FILES=${MAIN_INP_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}
#~ OUTPUT_FILE=${MAIN_OUT_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}_output_${PERIODYR}_${SCENARIO}_${GCM_CODE}.nc 
#~ python cdo_sellonlatbox.py ${LONLATBOX} ${INPUT_FILES} ${OUTPUT_FILE} &

# - temperature - annual resolution
FILE_VARIABLE_NAME=temperature_annuaAvg
INPUT_FILES=${MAIN_INP_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}
OUTPUT_FILE=${MAIN_OUT_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}_output_${PERIODYR}_${SCENARIO}_${GCM_CODE}.nc 
python cdo_sellonlatbox.py ${LONLATBOX} ${INPUT_FILES} ${OUTPUT_FILE} &
#~ 
#~ # - precipitation
#~ FILE_VARIABLE_NAME=precipitation_monthTot
#~ INPUT_FILES=${MAIN_INP_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}
#~ OUTPUT_FILE=${MAIN_OUT_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}_output_${PERIODYR}_${SCENARIO}_${GCM_CODE}.nc 
#~ python cdo_sellonlatbox.py ${LONLATBOX} ${INPUT_FILES} ${OUTPUT_FILE} &
#~ 
#~ # - domestic withdrawal
#~ FILE_VARIABLE_NAME=domesticWaterWithdrawal_monthTot
#~ INPUT_FILES=${MAIN_INP_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}
#~ OUTPUT_FILE=${MAIN_OUT_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}_output_${PERIODYR}_${SCENARIO}_${GCM_CODE}.nc 
#~ python cdo_sellonlatbox.py ${LONLATBOX} ${INPUT_FILES} ${OUTPUT_FILE} &
#~ 
#~ # - industrial withdrawal
#~ FILE_VARIABLE_NAME=industryWaterWithdrawal_monthTot
#~ INPUT_FILES=${MAIN_INP_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}
#~ OUTPUT_FILE=${MAIN_OUT_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}_output_${PERIODYR}_${SCENARIO}_${GCM_CODE}.nc 
#~ python cdo_sellonlatbox.py ${LONLATBOX} ${INPUT_FILES} ${OUTPUT_FILE} &
#~ 
#~ # - livestock withdrawal
#~ FILE_VARIABLE_NAME=livestockWaterWithdrawal_monthTot
#~ INPUT_FILES=${MAIN_INP_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}
#~ OUTPUT_FILE=${MAIN_OUT_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}_output_${PERIODYR}_${SCENARIO}_${GCM_CODE}.nc 
#~ python cdo_sellonlatbox.py ${LONLATBOX} ${INPUT_FILES} ${OUTPUT_FILE} &
#~ 
#~ # - irrigation withdrawal
#~ FILE_VARIABLE_NAME=irrGrossDemand_monthTot_outpu
#~ INPUT_FILES=${MAIN_INP_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}
#~ OUTPUT_FILE=${MAIN_OUT_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}_output_${PERIODYR}_${SCENARIO}_${GCM_CODE}.nc 
#~ python cdo_sellonlatbox.py ${LONLATBOX} ${INPUT_FILES} ${OUTPUT_FILE} &

wait

set +x
