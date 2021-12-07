
# first you have to start azcopy and login

unset GCM_NAME
unset SCENARIO_TYPE
unset STARTING_YEAR
unset LOCAL_FOLDER
unset DATALAKE_FOLDER

#~ GCM_NAME="gfdl-esm4"
#~ SCENARIO_TYPE="ssp585"
#~ STARTING_YEAR="2015"

#~ GCM_NAME="gfdl-esm4"
#~ SCENARIO_TYPE="historical"
#~ STARTING_YEAR="1960"

# please provide the following variables
GCM_NAME=$1
SCENARIO_TYPE=$2
STARTING_YEAR=$3


# local/source folder
LOCAL_FOLDER="/gcm_disk*/*/pcrglobwb/merged_daily/pcrglobwb_aqueduct_2021/version_2021-09-16/"${GCM_NAME}"/"${SCENARIO_TYPE}"/*/global"

# data lake location/folder
DATALAKE_FOLDER="https://uuwridata.dfs.core.windows.net/pgb-data-lake/pcrglobwb_output/pcrglobwb_aqueduct_2021/version_2021-09-16/"${GCM_NAME}"/"${SCENARIO_TYPE}"/begin_from_"${STARTING_YEAR}"/global"


# go to the local/source folder and make the signature of it
cd ${LOCAL_FOLDER}
cd netcdf_daily
pwd > 000_source.txt

# go to one folder up
cd ..
pwd > source_daily_files.txt


# upload using azcopy sync
echo azcopy sync "." ${DATALAKE_FOLDER}
azcopy sync "." ${DATALAKE_FOLDER}

