
# historical

MAIN_JOB_NAME="hisw" 

RCP_CODE="historical"
GCM_CODE="watch"

INP_FOLDER="/scratch-shared/edwinhs/pcrglobwb_aqueduct_version_2016-2018/aqueduct_daily_discharge/historical/1958-2001_watch/watch/"
OUT_FOLDER="/scratch-shared/edwinhs/pcrglobwb_aqueduct_version_2016-2018/aqueduct_daily_discharge_statistics/historical/1958-2001_watch/watch/"

#~ STA_YEAR=2000
#~ END_YEAR=2000

MAIN_JOB_NAME=$1 
RCP_CODE=$2
GCM_CODE=$3

INP_FOLDER=$4
OUT_FOLDER=$5

#~ STA_YEAR=$(($6))
#~ END_YEAR=$(($7))

#~ for i in {${STA_YEAR}..${END_YEAR}}

for i in {1950..2100}

do

JOB_NAME=${MAIN_JOB_NAME}${i}

sbatch -J ${JOB_NAME} --export INP_FOLDER=${INP_FOLDER},OUT_FOLDER=${OUT_FOLDER},RCP_CODE=${RCP_CODE},GCM_CODE=${GCM_CODE},YEAR=${i} a_single_job_cdo_tim_pctl.sh 

sleep 0.1s
 
done

#~ -r--r--r-- 1 edwinhs edwinhs 4399163672 Jan  6 23:25 rcp2p6/2006-2099/gfdl-esm2m/discharge_dailyTot_output_2099-01-01_to_2099-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 4407988128 Jan  6 22:13 rcp2p6/2006-2099/hadgem2-es/discharge_dailyTot_output_2099-01-01_to_2099-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 4360588471 Jan  6 23:26 rcp2p6/2006-2099/ipsl-cm5a-lr/discharge_dailyTot_output_2099-01-01_to_2099-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 4304269057 Jan  6 20:27 rcp2p6/2006-2099/miroc-esm-chem/discharge_dailyTot_output_2099-01-01_to_2099-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 4322008939 Jan  7 00:50 rcp2p6/2006-2099/noresm1-m/discharge_dailyTot_output_2099-01-01_to_2099-12-31.nc
