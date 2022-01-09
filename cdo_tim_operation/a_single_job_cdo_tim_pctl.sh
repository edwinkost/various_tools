#!/bin/bash 

#SBATCH -N 1
#SBATCH -t 1:29:00

#SBATCH -p thin

# mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL

# send mail to this address
#SBATCH --mail-user=edwinkost@gmail.com

#SBATCH -J hisw2000

#SBATCH --export INP_FOLDER="",OUT_FOLDER="",RCP_CODE="",GCM_CODE="",YEAR=""


# load software needed
. /home/edwin/load_all_default.sh

set -x

INP_FOLDER=${INP_FOLDER}
OUT_FOLDER=${OUT_FOLDER}

RCP_CODE=${RCP_CODE}
GCM_CODE=${GCM_CODE}

STA_YEAR=${YEAR}
END_YEAR=${YEAR}

python cdo_tim_pctl.py ${INPUT_FOLDER} ${OUT_FOLDER} ${RCP_CODE} ${GCM_CODE} ${STA_YEAR} ${END_YEAR}

set +x
