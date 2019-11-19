set -x

cd ~

source activate py3_pcrglobwb_edwin

source /scratch/depfg/pcraster/pcraster-4.3.0.sh

export PCRASTER_NR_WORKER_THREADS=16

cd -

set +x
