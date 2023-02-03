#!/bin/bash
#SBATCH -N 1
#SBATCH -n 48
#~ #SBATCH -t 240:00:00

#~ #SBATCH -p defq

#SBATCH -J merging

#~ #SBATCH --exclusive

# mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL

# send mail to this address
#SBATCH --mail-user=edwinkost@gmail.com

#SBATCH --export GCM_NAME="test",SCN_TYPE="test",START_YR="test",FINAL_YR="test"



# load all software
. load_anaconda_and_my_default_env.sh

# go to the script folder
cd /eejit/home/sutan101/github/edwinkost/various_tools/merging_netcdf_aqueduct_2021/merging_with_cdo/

# set variables/arguments for the python script
GCM_NAME = ${GCM_NAME}
SCN_TYPE = ${SCN_TYPE}
START_YR = ${START_YR}
FINAL_YR = ${FINAL_YR}
SRC_FOLD = "/scratch/depfg/sutan101/pcrglobwb_wri_aqueduct_2021/pcrglobwb_aqueduct_2021_monthly_annual_files/version_2021-09-16/"${GCM_NAME}"/"${SCN_TYPE}"/begin_from_/"${START_YR}"/global/netcdf/"
OUT_FOLD = "/scratch/depfg/sutan101/pcrglobwb_wri_aqueduct_2021/pcrglobwb_aqueduct_2021_monthly_annual_files/version_2021-09-16_merged/"${GCM_NAME}"/"${SCN_TYPE}"/"

# call the script
python cdo_merge_type ${GCM_NAME} ${SCN_TYPE} ${START_YR} ${FINAL_YR} ${SRC_FOLD} ${OUT_FOLD} 
