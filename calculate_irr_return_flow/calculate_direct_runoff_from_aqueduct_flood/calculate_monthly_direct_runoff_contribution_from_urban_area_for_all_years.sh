
OUTPUT_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct_for_edward/irrigation_water_use_and_direct_runoff/processed/historical/1951-2005/gfdl-esm2m/"

INPUT_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct_for_edward/irrigation_water_use_and_direct_runoff/historical/1951-2005/gfdl-esm2m/"

#~ edwinhs@tcn674.bullx:/scratch-shared/edwinhs/pcr-globwb-aqueduct_for_edward/irrigation_water_use_and_direct_runoff/historical/1951-2005/gfdl-esm2m$ ls -lah directRunoff_monthTot_output_198*
#~ -r--r--r-- 1 edwinhs edwinhs 46M Apr  6 12:38 directRunoff_monthTot_output_1980-01-31_to_1980-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 47M Apr  6 12:38 directRunoff_monthTot_output_1981-01-31_to_1981-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 47M Apr  6 12:38 directRunoff_monthTot_output_1982-01-31_to_1982-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 47M Apr  6 12:38 directRunoff_monthTot_output_1983-01-31_to_1983-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 47M Apr  6 12:38 directRunoff_monthTot_output_1984-01-31_to_1984-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 48M Apr  6 12:38 directRunoff_monthTot_output_1985-01-31_to_1985-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 47M Apr  6 12:38 directRunoff_monthTot_output_1986-01-31_to_1986-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 47M Apr  6 12:38 directRunoff_monthTot_output_1987-01-31_to_1987-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 49M Apr  6 12:38 directRunoff_monthTot_output_1988-01-31_to_1988-12-31.nc
#~ -r--r--r-- 1 edwinhs edwinhs 48M Apr  6 12:38 directRunoff_monthTot_output_1989-01-31_to_1989-12-31.nc


bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1980 1980 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1981 1981 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1982 1982 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1983 1983 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1984 1984 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1985 1985 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1986 1986 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1987 1987 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1988 1988 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1989 1989 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1990 1990 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1991 1991 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1992 1992 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1993 1993 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1994 1994 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1995 1995 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1996 1996 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1997 1997 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1998 1998 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 1999 1999 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2000 2000 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2001 2001 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2002 2002 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2003 2003 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2004 2004 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &
bash calculate_monthly_direct_runoff_contribution_from_urban_area.sh 2005 2005 ${OUTPUT_FOLDER} ${INPUT_FOLDER} &

wait



















