#!/bin/bash

#PBS -N touch-imperial

#PBS -l walltime=10:00:00
#PBS -l select=1:ncpus=1:mem=4gb

#~ #PBS -v NEXTDATE="01"

# mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL

# send mail to this address
#SBATCH --mail-user=edwinkost@gmail.com


# touch all of my important files on /rds/general/user/esutanud/ephemeral/edwin
find /rds/general/user/esutanud/ephemeral/edwin -exec touch {} \;
ls -lah /rds/general/user/esutanud/ephemeral/edwin


# submit a next job scheduled next month on the same date
cd ${PBS_O_WORKDIR}
set -x
qsub -a ${NEXTDATE}2359 -N touch_${NEXTDATE} -v NEXTDATE="""${NEXTDATE}""" touch_scratch.sh
set +x

