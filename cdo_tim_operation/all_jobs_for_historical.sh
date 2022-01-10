
MAIN_INP_FOLDER="/scratch-shared/edwinhs/pcrglobwb_aqueduct_version_2016-2018/aqueduct_daily_discharge/historical/"
MAIN_OUT_FOLDER="/scratch-shared/edwin/pcrglobwb_aqueduct_version_2016-2018/aqueduct_daily_discharge_statistics/historical/"

bash all_jobs_flexible_template.sh hisg historical gfdl-esm2m     ${MAIN_INP_FOLDER}/1951-2005/gfdl-esm2m/     ${MAIN_OUT_FOLDER}/1951-2005/gfdl-esm2m/    
bash all_jobs_flexible_template.sh hish historical hadgem2-es     ${MAIN_INP_FOLDER}/1951-2005/hadgem2-es/     ${MAIN_OUT_FOLDER}/1951-2005/hadgem2-es/    
bash all_jobs_flexible_template.sh hisi historical ipsl-cm5a-lr   ${MAIN_INP_FOLDER}/1951-2005/ipsl-cm5a-lr/   ${MAIN_OUT_FOLDER}/1951-2005/ipsl-cm5a-lr/  
bash all_jobs_flexible_template.sh hism historical miroc-esm-chem ${MAIN_INP_FOLDER}/1951-2005/miroc-esm-chem/ ${MAIN_OUT_FOLDER}/1951-2005/miroc-esm-chem/
bash all_jobs_flexible_template.sh hisn historical noresm1-m      ${MAIN_INP_FOLDER}/1951-2005/noresm1-m/      ${MAIN_OUT_FOLDER}/1951-2005/noresm1-m/     

