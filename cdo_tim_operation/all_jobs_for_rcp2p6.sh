

# rcp2p6

MAIN_INP_FOLDER="/scratch-shared/edwinhs/pcrglobwb_aqueduct_version_2016-2018/aqueduct_daily_discharge/rcp2p6/"
MAIN_OUT_FOLDER="/scratch-shared/edwinhs/pcrglobwb_aqueduct_version_2016-2018/aqueduct_daily_discharge_statistics/rcp2p6/"

bash all_jobs_flexible_template.sh 2p6g rcp2p6 gfdl-esm2m     ${MAIN_INP_FOLDER}/2006-2099/gfdl-esm2m/     ${MAIN_OUT_FOLDER}/2006-2099/gfdl-esm2m/    
bash all_jobs_flexible_template.sh 2p6h rcp2p6 hadgem2-es     ${MAIN_INP_FOLDER}/2006-2099/hadgem2-es/     ${MAIN_OUT_FOLDER}/2006-2099/hadgem2-es/    
bash all_jobs_flexible_template.sh 2p6i rcp2p6 ipsl-cm5a-lr   ${MAIN_INP_FOLDER}/2006-2099/ipsl-cm5a-lr/   ${MAIN_OUT_FOLDER}/2006-2099/ipsl-cm5a-lr/  
bash all_jobs_flexible_template.sh 2p6m rcp2p6 miroc-esm-chem ${MAIN_INP_FOLDER}/2006-2099/miroc-esm-chem/ ${MAIN_OUT_FOLDER}/2006-2099/miroc-esm-chem/
bash all_jobs_flexible_template.sh 2p6n rcp2p6 noresm1-m      ${MAIN_INP_FOLDER}/2006-2099/noresm1-m/      ${MAIN_OUT_FOLDER}/2006-2099/noresm1-m/     

