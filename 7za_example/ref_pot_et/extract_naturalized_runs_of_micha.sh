
set -x

cd
. load_my_miniconda_and_my_default_env.sh
module load p7zip

RUN_CODE=$1

#~ OUTPUT_DIR=/scratch/shared/edwinsu/aqueduct_naturalized_micha_test_complete/${RUN_CODE}_naturalized/

OUTPUT_DIR=/projects/0/einf411/edwinsu/aqueduct_naturalized_micha/${RUN_CODE}_naturalized/

OUTPUT_DIR=/projects/0/einf411/edwinsu/aqueduct_naturalized_micha_et0_only/${RUN_CODE}_naturalized/


INPUT_DIR="/projects/0/einf411/edwinsu/"

mkdir -p ${OUTPUT_DIR}
cd ${OUTPUT_DIR}

#~ 7za e '-ir!*precipitation*month*' '-ir!*d*month*' "${INPUT_DIR}/${RUN_CODE}*_netcdf.tar" .

#~ baseflow
#~ discharge
#~ channelStorage
#~ gwRecharge
#~ totalRunoff
#~ runoff
#~ precipitation
#~ totalEvaporation
#~ totalPotentialEvaporation
#~ storUppTotal
#~ storLowTotal
#~ storGroundwater
#~ totalWaterStorageThickness

#~ 7za e '-ir!*precipitation*month*' '-ir!*baseflow*month*' '-ir!*channelStorage*month*' '-ir!*discharge*month*' '-ir!*dynamicFracWat*month*' '-ir!*flood*month*' '-ir!*gwRecharge*month*' '-ir!*runoff*month*' '-ir!*storGroundwater*month*' '-ir!*storUpp*month*' '-ir!*storLow*month*' '-ir!*totLandSurfaceActuaET*month*' '-ir!*totalEvaporation*month*' '-ir!*totalLandSurfacePotET*month*' '-ir!*totalPotentialEvaporation*month*' '-ir!*totalRunoff*month*' '-ir!*totalWaterStorageThickness*month*' '-ir!*waterBodyActEvaporation*month*' '-ir!*waterBodyPotEvaporation*month*' "${INPUT_DIR}/${RUN_CODE}*_netcdf.tar" .

7za e '-ir!*referencePotET*month*' "${INPUT_DIR}/${RUN_CODE}*_netcdf.tar" .


MERGED_YEARS=$2
MERGED_NC_FOLDER="merged_"${MERGED_YEARS}

mkdir ${MERGED_NC_FOLDER}

cdo -L -z zip -f nc4 -mergetime referencePotET_monthTot_output_*.nc ${MERGED_NC_FOLDER}/referencePotET_monthTot_output_${MERGED_YEARS}.nc

set +x
