
MAIN_INP_FOLDER="/scratch-shared/edwinhs/pcrglobwb_aqueduct_version_2016-2018/aqueduct_daily_discharge/historical/"
MAIN_OUT_FOLDER="/scratch-shared/edwinhs/pcrglobwb_aqueduct_version_2016-2018/aqueduct_daily_discharge_statistics/historical/"

bash all_jobs_flexible_template.sh hisg historical gfdl-esm2m     ${MAIN_INP_FOLDER}/1951-2005/gfdl-esm2m/     ${MAIN_OUT_FOLDER}/1951-2005/gfdl-esm2m/    
bash all_jobs_flexible_template.sh hish historical hadgem2-es     ${MAIN_INP_FOLDER}/1951-2005/hadgem2-es/     ${MAIN_OUT_FOLDER}/1951-2005/hadgem2-es/    
bash all_jobs_flexible_template.sh hisi historical ipsl-cm5a-lr   ${MAIN_INP_FOLDER}/1951-2005/ipsl-cm5a-lr/   ${MAIN_OUT_FOLDER}/1951-2005/ipsl-cm5a-lr/  
bash all_jobs_flexible_template.sh hism historical miroc-esm-chem ${MAIN_INP_FOLDER}/1951-2005/miroc-esm-chem/ ${MAIN_OUT_FOLDER}/1951-2005/miroc-esm-chem/
bash all_jobs_flexible_template.sh hisn historical noresm1-m      ${MAIN_INP_FOLDER}/1951-2005/noresm1-m/      ${MAIN_OUT_FOLDER}/1951-2005/noresm1-m/     

#~ -r--r--r-- 1 edwinhs edwinhs 4399163672 Jan  6 23:25 rcp2p6/2006-2099/gfdl-esm2m     /discharge_dailyTot_output_2099-01-01_to_2099-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 4407988128 Jan  6 22:13 rcp2p6/2006-2099/hadgem2-es     /discharge_dailyTot_output_2099-01-01_to_2099-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 4360588471 Jan  6 23:26 rcp2p6/2006-2099/ipsl-cm5a-lr   /discharge_dailyTot_output_2099-01-01_to_2099-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 4304269057 Jan  6 20:27 rcp2p6/2006-2099/miroc-esm-chem /discharge_dailyTot_output_2099-01-01_to_2099-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 4322008939 Jan  7 00:50 rcp2p6/2006-2099/noresm1-m      /discharge_dailyTot_output_2099-01-01_to_2099-12-31.nc
