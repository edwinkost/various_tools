
# first you have to start azcopy and login


#~ GCM_NAME="gfdl-esm4"
#~ SCENARIO_TYPE="historical"
#~ STARTING_YEAR="1960"


# please provide the following variables
GCM_NAME=$1
SCENARIO_TYPE=$2
STARTING_YEAR=$3


# source and target folders
SOURCE_FOLDER="https://uuwridata.dfs.core.windows.net/pgb-data-lake/pcrglobwb_output/pcrglobwb_aqueduct_2021/version_2021-09-16/"${GCM_NAME}"/"${SCENARIO_TYPE}"/begin_from_"${STARTING_YEAR}"/global/netcdf_daily"
TARGET_FOLDER="/gpfs/work4/0/dynql/edwindql/pcrglobwb_aqueduct_2021_daily_files/version_2021-09-16/"${GCM_NAME}"/"${SCENARIO_TYPE}"/begin_from_"${STARTING_YEAR}"/global/"

set -x

# go to the TARGET_FOLDER and create a "netcdf" directory and go there
mkdir -p ${TARGET_FOLDER}
cd ${TARGET_FOLDER}
mkdir netcdf
cd netcdf

set +x

# download using azcopy
echo azcopy sync ${SOURCE_FOLDER} "."
azcopy sync ${SOURCE_FOLDER} "."

