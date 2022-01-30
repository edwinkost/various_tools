
# first you have to start azcopy and login


#~ GCM_NAME="gfdl-esm4"
#~ SCENARIO_TYPE="historical"
#~ STARTING_YEAR="1960"


# please provide the following variables
GCM_NAME=$1
SCENARIO_TYPE=$2
STARTING_YEAR=$3


# source and target folders
SOURCE_FOLDER="https://uuwridata.dfs.core.windows.net/pgb-data-lake/pcrglobwb_output/pcrglobwb_aqueduct_2021/version_2021-09-16/"${GCM_NAME}"/"${SCENARIO_TYPE}"/begin_from_"${STARTING_YEAR}"/global/states/"

TARGET_FOLDER="/scratch-shared/edwindql/pcrglobwb_aqueduct_2021_states_files/version_2021-09-16/"${GCM_NAME}"/"${SCENARIO_TYPE}"/begin_from_"${STARTING_YEAR}"/global/"

set -x

# go to the TARGET_FOLDER and create a "states" directory and go there
mkdir -p ${TARGET_FOLDER}
cd ${TARGET_FOLDER}
mkdir states
cd states

set +x

#~ # download using azcopy - TOO BIG
#~ echo azcopy sync ${SOURCE_FOLDER} "."
#~ azcopy sync ${SOURCE_FOLDER} "."

# download using azcopy for some years only
echo azcopy sync ${SOURCE_FOLDER} "." --include-pattern '*1960*;*1969*;*1978*;*1979*;*1989*;*1999*;*2004*;*2009*;*2014*;*2019*;*2029*;*2039*;*2049*;*2059*;*2069*;*2079*;*2089*'
azcopy sync ${SOURCE_FOLDER} "." --include-pattern '*1960*;*1969*;*1978*;*1979*;*1989*;*1999*;*2004*;*2009*;*2014*;*2019*;*2029*;*2039*;*2049*;*2059*;*2069*;*2079*;*2089*'
