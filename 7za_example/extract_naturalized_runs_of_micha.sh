
set -x

cd
. load_my_miniconda_and_my_default_env.sh
module load p7zip

RUN_CODE=$1

#~ OUTPUT_DIR=/scratch/shared/edwinsu/aqueduct_naturalized_micha_test_complete/${RUN_CODE}_naturalized/

OUTPUT_DIR=/projects/0/einf411/edwinsu/aqueduct_naturalized_micha/${RUN_CODE}_naturalized/

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

7za e '-ir!*precipitation*month*' '-ir!*baseflow*month*' '-ir!*channelStorage*month*' '-ir!*discharge*month*' '-ir!*dynamicFracWat*month*' '-ir!*flood*month*' '-ir!*gwRecharge*month*' '-ir!*runoff*month*' '-ir!*storGroundwater*month*' '-ir!*storUpp*month*' '-ir!*storLow*month*' '-ir!*totLandSurfaceActuaET*month*' '-ir!*totalEvaporation*month*' '-ir!*totalLandSurfacePotET*month*' '-ir!*totalPotentialEvaporation*month*' '-ir!*totalRunoff*month*' '-ir!*totalWaterStorageThickness*month*' '-ir!*waterBodyActEvaporation*month*' '-ir!*waterBodyPotEvaporation*month*' "${INPUT_DIR}/${RUN_CODE}*_netcdf.tar" .

MERGED_YEARS=$2
MERGED_NC_FOLDER="merged_"${MERGED_YEARS}

mkdir ${MERGED_NC_FOLDER}


cdo -L -f nc4 -z zip -mergetime discharge_monthAvg_output_*.nc                  ${MERGED_NC_FOLDER}/discharge_monthAvg_output_${MERGED_YEARS}.nc

cdo -L -f nc4 -z zip -mergetime channelStorage_monthAvg_output_*.nc             ${MERGED_NC_FOLDER}/channelStorage_monthAvg_output_${MERGED_YEARS}.nc

cdo -L -f nc4 -z zip -mergetime gwRecharge_monthTot_output_*.nc                 ${MERGED_NC_FOLDER}/gwRecharge_monthTot_output_${MERGED_YEARS}.nc

cdo -L -f nc4 -z zip -mergetime baseflow_monthTot_output_*.nc                   ${MERGED_NC_FOLDER}/baseflow_monthTot_output_${MERGED_YEARS}.nc
cdo -L -f nc4 -z zip -mergetime runoff_monthTot_output_*.nc                     ${MERGED_NC_FOLDER}/runoff_monthTot_output_${MERGED_YEARS}.nc
cdo -L -f nc4 -z zip -mergetime totalRunoff_monthTot_output_*.nc                ${MERGED_NC_FOLDER}/totalRunoff_monthTot_output_${MERGED_YEARS}.nc

cdo -L -f nc4 -z zip -mergetime precipitation_monthTot_output_*.nc              ${MERGED_NC_FOLDER}/precipitation_monthTot_output_${MERGED_YEARS}.nc

cdo -L -f nc4 -z zip -mergetime totalEvaporation_monthTot_output_*.nc           ${MERGED_NC_FOLDER}/totalEvaporation_monthTot_output_${MERGED_YEARS}.nc

cdo -L -f nc4 -z zip -mergetime totalPotentialEvaporation_monthTot_output_*.nc  ${MERGED_NC_FOLDER}/totalPotentialEvaporation_monthTot_output_${MERGED_YEARS}.nc
cdo -L -f nc4 -z zip -mergetime totalLandSurfacePotET_monthTot_output_*.nc      ${MERGED_NC_FOLDER}/totalLandSurfacePotET_monthTot_output_${MERGED_YEARS}.nc

cdo -L -f nc4 -z zip -mergetime storUppTotal_monthAvg_output_*.nc               ${MERGED_NC_FOLDER}/storUppTotal_monthAvg_output_${MERGED_YEARS}.nc
cdo -L -f nc4 -z zip -mergetime storLowTotal_monthAvg_output_*.nc               ${MERGED_NC_FOLDER}/storLowTotal_monthAvg_output_${MERGED_YEARS}.nc

cdo -L -f nc4 -z zip -mergetime totalWaterStorageThickness_monthAvg_output_*.nc ${MERGED_NC_FOLDER}/totalWaterStorageThickness_monthAvg_output_${MERGED_YEARS}.nc

set +x
