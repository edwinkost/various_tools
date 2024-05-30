#!/bin/bash
#SBATCH -N 1
#SBATCH -t 119:59:00
#SBATCH -p staging
#SBATCH -J touch

# set the begin time
#SBATCH --begin=now+172800

#~ # mail alert at start, end and abortion of execution
#~ #SBATCH --mail-type=ALL

#~ # send mail to this address
#~ #SBATCH --mail-user=nnn@nnn.com

squeue -u edwindql -o "%.10i %.10P %.24j %.10u %.12T %.12M %.12l %.5D %16R %20S"

# submit the next job
sbatch touch_regularly.sh

# touch all files on your scratch-shared - please modify "edwindemo"
cd /scratch-shared/edwindemo/
ls -lah .
find . -exec touch {} \;
ls -lah .
