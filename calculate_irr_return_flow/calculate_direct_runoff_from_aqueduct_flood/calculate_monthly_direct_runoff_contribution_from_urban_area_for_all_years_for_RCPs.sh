
RCP_CODE="rcp4p5"
RCP_CODE=$1

OUTPUT_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct_for_edward/irrigation_water_use_and_direct_runoff/processed/historical/1951-2005/gfdl-esm2m/"
OUTPUT_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct_for_edward/irrigation_water_use_and_direct_runoff/processed/historical/1951-2005/"$2"/"

INPUT_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct_for_edward/irrigation_water_use_and_direct_runoff/rcp4p5/2006-2099/gfdl-esm2m/"
INPUT_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct_for_edward/irrigation_water_use_and_direct_runoff/"${RCP_CODE}"/2006-2099/"$2"/"


#~ edwinhs@tcn674.bullx:/scratch-shared/edwinhs/pcr-globwb-aqueduct_for_edward/irrigation_water_use_and_direct_runoff/rcp4p5/2006-2099/gfdl-esm2m$ ls -lah directRunoff_monthTot_output_201*
#~ -r--r--r-- 1 edwinhs edwinhs 47M Apr  6 12:38 directRunoff_monthTot_output_2010-01-31_to_2010-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 47M Apr  6 12:38 directRunoff_monthTot_output_2011-01-31_to_2011-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 47M Apr  6 12:38 directRunoff_monthTot_output_2012-01-31_to_2012-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 47M Apr  6 12:38 directRunoff_monthTot_output_2013-01-31_to_2013-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 47M Apr  6 12:38 directRunoff_monthTot_output_2014-01-31_to_2014-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 47M Apr  6 12:38 directRunoff_monthTot_output_2015-01-31_to_2015-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 46M Apr  6 12:38 directRunoff_monthTot_output_2016-01-31_to_2016-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 47M Apr  6 12:38 directRunoff_monthTot_output_2017-01-31_to_2017-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 47M Apr  6 12:38 directRunoff_monthTot_output_2018-01-31_to_2018-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 46M Apr  6 12:38 directRunoff_monthTot_output_2019-01-31_to_2019-12-31.nc

bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2006 2006 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2007 2007 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2008 2008 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2009 2009 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2010 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2011 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2012 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2013 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2014 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2015 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2016 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2017 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2018 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2019 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2020 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2021 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2022 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2023 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2024 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2025 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2026 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2027 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2028 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2029 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2030 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2031 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2032 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2033 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2034 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2035 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2036 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2037 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2038 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2039 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2040 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2041 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2042 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2043 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2044 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2045 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2046 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2047 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2048 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2049 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2050 2010 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &

wait



















