#!/bin/bash
#PBS -N touch
#PBS -q nf
#PBS -l EC_total_tasks=1
#PBS -l EC_billing_account=c3s432l3
#PBS -l walltime=48:00:00

#~ #PBS -v NEXTDATE="01"

# mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL

# send mail to this address
#SBATCH --mail-user=edwinkost@gmail.com


# touch all of my important files on /scratch/ms/copext/cyes
find /scratch/ms/copext/cyes/edwin -exec touch {} \;
ls -lah /scratch/ms/copext/cyes/edwin

# touch all of my important files on /scratch/mo/nest
find /scratch/mo/nest/ulysses/data/pgb -exec touch {} \;
ls -lah /scratch/mo/nest/ulysses/data/pgb


# submit a next job scheduled next month on the same date
cd ${PBS_O_WORKDIR}
set -x
qsub -a ${NEXTDATE}2359 -N touch_${NEXTDATE} -v NEXTDATE="""${NEXTDATE}""" touch_scratch.sh
set +x

