
set -x

cd
. load_my_miniconda_and_my_default_env.sh
module load p7zip

RUN_CODE=$1

OUTPUT_DIR=/scratch/shared/edwinsu/aqueduct_naturalized_micha_test/${RUN_CODE}_naturalized/

INPUT_DIR="/projects/0/einf411/edwinsu/"

mkdir -p ${OUTPUT_DIR}
cd ${OUTPUT_DIR}

7za e '-ir!*precipitation*month*' '-ir!*baseflow*month*' '-ir!*channelStorage*month*' '-ir!*discharge*month*' '-ir!*dynamicFracWat*month*' '-ir!*flood*month*' '-ir!*gwRecharge*month*' '-ir!*runoff*month*' '-ir!*storGroundwater*month*' '-ir!*storUpp*month*' '-ir!*storLow*month*' '-ir!*totLandSurfaceActuaET*month*' '-ir!*totalEvaporation*month*' '-ir!*totalLandSurfacePotET*month*' '-ir!*totalPotentialEvaporation*month*' '-ir!*totalRunoff*month*' '-ir!*totalWaterStorageThickness*month*' '-ir!*waterBodyActEvaporation*month*' '-ir!*waterBodyPotEvaporation*month*' "${INPUT_DIR}/${RUN_CODE}*_netcdf.tar" .

MERGED_YEARS=$2
MERGED_NC_FOLDER="merged_"${MERGED_YEARS}

mkdir ${MERGED_NC_FOLDER}

cdo -L -f nc4 -s zip -mergetime discharge_monthAvg_output_*.nc                  ${MERGED_NC_FOLDER}/discharge_monthAvg_output_${MERGED_YEARS}.nc

cdo -L -f nc4 -s zip -mergetime channelStorage_monthAvg_output_*.nc             ${MERGED_NC_FOLDER}/channelStorage_monthAvg_output_${MERGED_YEARS}.nc
cdo -L -f nc4 -s zip -mergetime gwRecharge_monthTot_output_*.nc                 ${MERGED_NC_FOLDER}/gwRecharge_monthTot_output_${MERGED_YEARS}.nc
cdo -L -f nc4 -s zip -mergetime totalRunoff_monthTot_output_*.nc                ${MERGED_NC_FOLDER}/totalRunoff_monthTot_output_${MERGED_YEARS}.nc

cdo -L -f nc4 -s zip -mergetime runoff_monthTot_output_*.nc                     ${MERGED_NC_FOLDER}/runoff_monthTot_output_${MERGED_YEARS}.nc &

cdo -L -f nc4 -s zip -mergetime precipitation_monthTot_output_*.nc              ${MERGED_NC_FOLDER}/precipitation_monthTot_output_${MERGED_YEARS}.nc &

cdo -L -f nc4 -s zip -mergetime totalPotentialEvaporation_monthTot_output_*.nc  ${MERGED_NC_FOLDER}/totalPotentialEvaporation_monthTot_output_${MERGED_YEARS}.nc &
cdo -L -f nc4 -s zip -mergetime totalLandSurfacePotET_monthTot_output_*.nc      ${MERGED_NC_FOLDER}/totalLandSurfacePotET_monthTot_output__${MERGED_YEARS}.nc &

cdo -L -f nc4 -s zip -mergetime totalWaterStorageThickness_monthAvg_output_*.nc ${MERGED_NC_FOLDER}/totalWaterStorageThickness_monthAvg_output_${MERGED_YEARS}.nc

set +x
