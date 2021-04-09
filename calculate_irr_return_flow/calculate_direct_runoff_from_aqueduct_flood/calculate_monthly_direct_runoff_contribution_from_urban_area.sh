
set -x

#~ FRACTION OF SURFACE RUNOFF

#~ python merge_netcdf.py /scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/ /scratch-shared/edwinhs/calculate_irr_return_flow/fraction_of_surface_runoff/ outMonthTotNC 1958-01-31 2015-12-31 directRunoff,runoff NETCDF4 True 2 Global

#~ SURFACE_RUNOFF_FLOW from urban area (m/month): urban_area_fraction x directRunoff

. /home/edwinhs/load_my_miniconda_and_my_default_env.sh

YEAR=$1
YEAR_FOR_URBAN=$2

OUT_DIR="/scratch-shared/edwinhs/monthly_direct_runoff_contribution/"${YEAR}"/"
OUT_DIR=$3"/"${YEAR}"/"

mkdir -p ${OUT_DIR}
cd ${OUT_DIR}
rm *

INP_ANNUAL_URBAN_AREA_FRACTION="/scratch-shared/edwinhs/calculate_irr_return_flow/urban_area_fraction/fraction_urban_historical_1970-2010.nc"

INP_MONTHLY_DIRECT_RUNOFF="/scratch-shared/edwinhs/calculate_irr_return_flow/fraction_of_surface_runoff/directRunoff_monthTot_output_1958-01-31_to_2015-12-31.nc"

INP_MONTHLY_DIRECT_RUNOFF=$4"/directRunoff_monthTot_output_"${YEAR}"-01-31_to_"${YEAR}"-12-31.nc"

# get annual urban area fraction
cdo selyear,${YEAR_FOR_URBAN} ${INP_ANNUAL_URBAN_AREA_FRACTION} urban_area_fraction_${YEAR}.nc

# get monthly direct runoff for that year
cdo selyear,${YEAR} ${INP_MONTHLY_DIRECT_RUNOFF} monthly_direct_runoff_${YEAR}.nc

# get monthly direct runoff from urban area
cdo -L -setname,"direct_runoff_from_urban" -setunit,"m.month-1" -mul urban_area_fraction_${YEAR}.nc monthly_direct_runoff_${YEAR}.nc monthly_urban_direct_runoff_${YEAR}.nc

set +x



