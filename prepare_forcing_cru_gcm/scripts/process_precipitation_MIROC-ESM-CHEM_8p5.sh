set -x 
rm -rf /scratch-shared/edwinhs/forcing_ISI-MIP_CRU-TS3.23_ERA20C/rcp8p5/MIROC-ESM-CHEM/precipitation//* 
mkdir -p /scratch-shared/edwinhs/forcing_ISI-MIP_CRU-TS3.23_ERA20C/rcp8p5/MIROC-ESM-CHEM/precipitation/ 
cd /scratch-shared/edwinhs/forcing_ISI-MIP_CRU-TS3.23_ERA20C/rcp8p5/MIROC-ESM-CHEM/precipitation/ 
cdo -L -f nc4 -ymonmean -seldate,1961-01-01,1990-12-31 /projects/0/dfguu/data/hydroworld/forcing/ERA20C/CRU-TS3.23_ERA20C_daily_precipitation_1901_to_2010.nc precipitation_reference.nc 
cdo -L -f nc4 -ymonmean /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_precipitation_2011_to_2100.nc precipitation_forcing.nc 
cdo -L -f nc4 -div precipitation_reference.nc precipitation_forcing.nc precipitation_div.nc 
cdo -L -f nc4 -mul -lec,100 precipitation_div.nc precipitation_div.nc temp.nc
cdo -L -f nc4 -add -mulc,100 -gtc,100 precipitation_div.nc temp.nc temp2.nc
cdo -L -f nc4 -setmisstoc,0 temp2.nc precipitation_div.nc
rm temp.nc
rm temp2.nc
cdo -L -f nc4 -ymonmean -seldate,1961-01-01,1990-12-31 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/MIROC-ESM-CHEM/pr_bced_1960-1999_miroc-esm-chem_historical_1951-2005.nc precipitation_gcm_reference.nc 
cdo -L -f nc4 -monmean /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/MIROC-ESM-CHEM/pr_bced_1960-1999_miroc-esm-chem_8p5_2006-2099.nc temp.nc
cdo -L -f nc4 -seldate,2090-01-01,2099-12-31 temp.nc temp2.nc
cdo -L -f nc4 -shifttime,+10years temp2.nc temp3.nc
cdo -L -f nc4 -mergetime temp.nc temp3.nc precipitation_gcm_tss.nc
rm temp.nc
rm temp2.nc
rm temp3.nc
cdo -L -f nc4 -selmon,1 precipitation_gcm_tss.nc temp01.nc
cdo -L -f nc4 -runmean,11 temp01.nc temp_run_01.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_01.nc temp_run2_01.nc
cdo -L -f nc4 -selmon,2 precipitation_gcm_tss.nc temp02.nc
cdo -L -f nc4 -runmean,11 temp02.nc temp_run_02.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_02.nc temp_run2_02.nc
cdo -L -f nc4 -selmon,3 precipitation_gcm_tss.nc temp03.nc
cdo -L -f nc4 -runmean,11 temp03.nc temp_run_03.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_03.nc temp_run2_03.nc
cdo -L -f nc4 -selmon,4 precipitation_gcm_tss.nc temp04.nc
cdo -L -f nc4 -runmean,11 temp04.nc temp_run_04.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_04.nc temp_run2_04.nc
cdo -L -f nc4 -selmon,5 precipitation_gcm_tss.nc temp05.nc
cdo -L -f nc4 -runmean,11 temp05.nc temp_run_05.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_05.nc temp_run2_05.nc
cdo -L -f nc4 -selmon,6 precipitation_gcm_tss.nc temp06.nc
cdo -L -f nc4 -runmean,11 temp06.nc temp_run_06.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_06.nc temp_run2_06.nc
cdo -L -f nc4 -selmon,7 precipitation_gcm_tss.nc temp07.nc
cdo -L -f nc4 -runmean,11 temp07.nc temp_run_07.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_07.nc temp_run2_07.nc
cdo -L -f nc4 -selmon,8 precipitation_gcm_tss.nc temp08.nc
cdo -L -f nc4 -runmean,11 temp08.nc temp_run_08.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_08.nc temp_run2_08.nc
cdo -L -f nc4 -selmon,9 precipitation_gcm_tss.nc temp09.nc
cdo -L -f nc4 -runmean,11 temp09.nc temp_run_09.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_09.nc temp_run2_09.nc
cdo -L -f nc4 -selmon,10 precipitation_gcm_tss.nc temp10.nc
cdo -L -f nc4 -runmean,11 temp10.nc temp_run_10.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_10.nc temp_run2_10.nc
cdo -L -f nc4 -selmon,11 precipitation_gcm_tss.nc temp11.nc
cdo -L -f nc4 -runmean,11 temp11.nc temp_run_11.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_11.nc temp_run2_11.nc
cdo -L -f nc4 -selmon,12 precipitation_gcm_tss.nc temp12.nc
cdo -L -f nc4 -runmean,11 temp12.nc temp_run_12.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_12.nc temp_run2_12.nc
cdo -L -f nc4 -mergetime  temp_run2_01.nc temp_run2_02.nc temp_run2_03.nc temp_run2_04.nc temp_run2_05.nc temp_run2_06.nc temp_run2_07.nc temp_run2_08.nc temp_run2_09.nc temp_run2_10.nc temp_run2_11.nc temp_run2_12.nc precipitation_run_tss.nc
rm  temp01.nc temp_run_01.nc temp_run2_01.nc temp02.nc temp_run_02.nc temp_run2_02.nc temp03.nc temp_run_03.nc temp_run2_03.nc temp04.nc temp_run_04.nc temp_run2_04.nc temp05.nc temp_run_05.nc temp_run2_05.nc temp06.nc temp_run_06.nc temp_run2_06.nc temp07.nc temp_run_07.nc temp_run2_07.nc temp08.nc temp_run_08.nc temp_run2_08.nc temp09.nc temp_run_09.nc temp_run2_09.nc temp10.nc temp_run_10.nc temp_run2_10.nc temp11.nc temp_run_11.nc temp_run2_11.nc temp12.nc temp_run_12.nc temp_run2_12.nc
cdo -L -f nc4 -ymondiv precipitation_run_tss.nc precipitation_gcm_reference.nc precipitation_gcm_ano.nc
cdo -L -f nc4 -mul -lec,100 precipitation_gcm_ano.nc precipitation_gcm_ano.nc temp.nc
cdo -L -f nc4 -add -mulc,100 -gtc,100 precipitation_gcm_ano.nc temp.nc temp2.nc
cdo -L -f nc4 -setmisstoc,0 temp2.nc precipitation_gcm_ano.nc
rm temp.nc
rm temp2.nc
cdo -L -f nc4 -ymonmul precipitation_gcm_ano.nc precipitation_div.nc precipitation_ano.nc
cdo -L -f nc4 -monmul /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_precipitation_2011_to_2100.nc precipitation_ano.nc /scratch-shared/edwinhs/forcing_ISI-MIP_CRU-TS3.23_ERA20C/rcp8p5/MIROC-ESM-CHEM/precipitation//CRU-TS3.23_ERA20C_GLO_daily_precipitation_2011_to_2100_MIROC-ESM-CHEM_rcp8p5.nc
cdo -L -f nc4 -gridweights precipitation_gcm_ano.nc temp_cellweights.nc
cdo -L -f nc4 -fldmean -mul temp_cellweights.nc precipitation_gcm_ano.nc precipitation_gcm_global_ano.nc
rm -f temp_cellweights.nc precipitation_ano.nc precipitation_gcm_ano.nc precipitation_gcm_tss.nc precipitation_run_tss.nc precipitation_forcing.nc precipitation_gcm_reference.nc precipitation_reference.nc precipitation_sub.nc
