
# request from Paul: discharge, water temperature, and sectoral consumption/withdrawal.
# - we will provide: discharge, temperature, precipitation, sectoral withdrawal, and demand

set -x

MAIN_INP_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct/aqueduct_water_use_all/"
MAIN_OUT_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct/maritsa/test/"

LONLATBOX="22.0,30.0,40.0,45.0"

SCENARIO="historical"

PERIODYR="1951-2005"

GCM_CODE="gfdl-esm2m"



# - discharge
FILE_VARIABLE_NAME=discharge_monthAvg_output
INPUT_FILES=${MAIN_INP_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}
OUTPUT_FILE=${MAIN_OUT_FOLDER}/${SCENARIO}/${PERIODYR}/${GCM_CODE}/${FILE_VARIABLE_NAME}_output_${PERIODYR}_${SCENARIO}_${GCM_CODE}.nc 
python cdo_sellonlatbox.py ${LONLATBOX} ${INPUT_FILES} ${OUTPUT_FILE} &

# - temperature - annual resolution
FILE_VARIABLE_NAME=temperature_annuaAvg_output

# - precipitation
FILE_VARIABLE_NAME=precipitation_monthTot


# - domestic withdrawal
FILE_VARIABLE_NAME=domesticWaterWithdrawal_monthTot


# - industrial withdrawal
FILE_VARIABLE_NAME=industryWaterWithdrawal_monthTot_output

# - livestock withdrawal
FILE_VARIABLE_NAME=industryWaterWithdrawal_monthTot_output

# - irr
irrGrossDemand_monthTot_outpu


wait

set +x
