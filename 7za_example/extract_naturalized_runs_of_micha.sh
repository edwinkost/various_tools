
set -x

module load p7zip

RUN_CODE=$1

OUTPUT_DIR=/scratch/shared/edwinsu/aqueduct_naturalized_micha_test/${RUN_CODE}_naturalized/

INPUT_DIR="/projects/0/einf411/edwinsu/"

mkdir -p ${OUTPUT_DIR}
cd ${OUTPUT_DIR}

7za e '-ir!*baseflow*' '-ir!*channelStorage*' '-ir!*discharge*' '-ir!*dynamicFracWat*' '-ir!*flood*' '-ir!*gwRecharge*' '-ir!*runoff*' '-ir!*storGroundwater*' '-ir!*storUpp*' '-ir!*storLow*' '-ir!*totLandSurfaceActuaET*' '-ir!*totalEvaporation*' '-ir!*totalLandSurfacePotET*' '-ir!*totalPotentialEvaporation*' '-ir!*totalRunoff*' '-ir!*totalWaterStorageThickness*' '-ir!*aterBodyActEvaporation*' '-ir!*waterBodyPotEvaporation*' ${INPUT_DIR}/${RUN_CODE}*_netcdf.tar .

#~ # - do not overwrite existing files
#~ 7za e -aos '-ir!*baseflow*' '-ir!*channelStorage*' '-ir!*discharge*' '-ir!*dynamicFracWat*' '-ir!*flood*' '-ir!*gwRecharge*' '-ir!*runoff*' '-ir!*storGroundwater*' '-ir!*storUpp*' '-ir!*storLow*' '-ir!*totLandSurfaceActuaET*' '-ir!*totalEvaporation*' '-ir!*totalLandSurfacePotET*' '-ir!*totalPotentialEvaporation*' '-ir!*totalRunoff*' '-ir!*totalWaterStorageThickness*' '-ir!*aterBodyActEvaporation*' '-ir!*waterBodyPotEvaporation*' ${INPUT_DIR}/${RUN_CODE}/*_netcdf.tar .

cd - 

set +x
