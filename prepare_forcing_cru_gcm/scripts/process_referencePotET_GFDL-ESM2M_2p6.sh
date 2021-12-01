set -x 
rm -rf /scratch-shared/edwinhs/forcing_ISI-MIP_CRU-TS3.23_ERA20C/rcp2p6/GFDL-ESM2M/referencePotET//* 
mkdir -p /scratch-shared/edwinhs/forcing_ISI-MIP_CRU-TS3.23_ERA20C/rcp2p6/GFDL-ESM2M/referencePotET/ 
cd /scratch-shared/edwinhs/forcing_ISI-MIP_CRU-TS3.23_ERA20C/rcp2p6/GFDL-ESM2M/referencePotET/ 
cdo -L -f nc4 -ymonmean -seldate,1961-01-01,1990-12-31 /projects/0/dfguu/data/hydroworld/forcing/ERA20C/CRU-TS3.23_ERA20C_daily_referencePotET_1901_to_2010.nc referencePotET_reference.nc 
cdo -L -f nc4 -ymonmean /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_referencePotET_2011_to_2100.nc referencePotET_forcing.nc 
cdo -L -f nc4 -div referencePotET_reference.nc referencePotET_forcing.nc referencePotET_div.nc 
cdo -L -f nc4 -mul -lec,100 referencePotET_div.nc referencePotET_div.nc temp.nc
cdo -L -f nc4 -add -mulc,100 -gtc,100 referencePotET_div.nc temp.nc temp2.nc
cdo -L -f nc4 -setmisstoc,0 temp2.nc referencePotET_div.nc
rm temp.nc
rm temp2.nc
cdo -L -f nc4 -ymonmean -seldate,1961-01-01,1990-12-31 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/GFDL-ESM2M/epot_bced_1960_1999_gfdl-esm2m_hist_1951-2005.nc referencePotET_gcm_reference.nc 
cdo -L -f nc4 -monmean /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/GFDL-ESM2M/epot_bced_1960_1999_gfdl-esm2m_2p6_2006-2099.nc temp.nc
cdo -L -f nc4 -seldate,2090-01-01,2099-12-31 temp.nc temp2.nc
cdo -L -f nc4 -shifttime,+10years temp2.nc temp3.nc
cdo -L -f nc4 -mergetime temp.nc temp3.nc referencePotET_gcm_tss.nc
rm temp.nc
rm temp2.nc
rm temp3.nc
cdo -L -f nc4 -selmon,1 referencePotET_gcm_tss.nc temp01.nc
cdo -L -f nc4 -runmean,11 temp01.nc temp_run_01.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_01.nc temp_run2_01.nc
cdo -L -f nc4 -selmon,2 referencePotET_gcm_tss.nc temp02.nc
cdo -L -f nc4 -runmean,11 temp02.nc temp_run_02.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_02.nc temp_run2_02.nc
cdo -L -f nc4 -selmon,3 referencePotET_gcm_tss.nc temp03.nc
cdo -L -f nc4 -runmean,11 temp03.nc temp_run_03.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_03.nc temp_run2_03.nc
cdo -L -f nc4 -selmon,4 referencePotET_gcm_tss.nc temp04.nc
cdo -L -f nc4 -runmean,11 temp04.nc temp_run_04.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_04.nc temp_run2_04.nc
cdo -L -f nc4 -selmon,5 referencePotET_gcm_tss.nc temp05.nc
cdo -L -f nc4 -runmean,11 temp05.nc temp_run_05.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_05.nc temp_run2_05.nc
cdo -L -f nc4 -selmon,6 referencePotET_gcm_tss.nc temp06.nc
cdo -L -f nc4 -runmean,11 temp06.nc temp_run_06.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_06.nc temp_run2_06.nc
cdo -L -f nc4 -selmon,7 referencePotET_gcm_tss.nc temp07.nc
cdo -L -f nc4 -runmean,11 temp07.nc temp_run_07.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_07.nc temp_run2_07.nc
cdo -L -f nc4 -selmon,8 referencePotET_gcm_tss.nc temp08.nc
cdo -L -f nc4 -runmean,11 temp08.nc temp_run_08.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_08.nc temp_run2_08.nc
cdo -L -f nc4 -selmon,9 referencePotET_gcm_tss.nc temp09.nc
cdo -L -f nc4 -runmean,11 temp09.nc temp_run_09.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_09.nc temp_run2_09.nc
cdo -L -f nc4 -selmon,10 referencePotET_gcm_tss.nc temp10.nc
cdo -L -f nc4 -runmean,11 temp10.nc temp_run_10.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_10.nc temp_run2_10.nc
cdo -L -f nc4 -selmon,11 referencePotET_gcm_tss.nc temp11.nc
cdo -L -f nc4 -runmean,11 temp11.nc temp_run_11.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_11.nc temp_run2_11.nc
cdo -L -f nc4 -selmon,12 referencePotET_gcm_tss.nc temp12.nc
cdo -L -f nc4 -runmean,11 temp12.nc temp_run_12.nc
cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_12.nc temp_run2_12.nc
cdo -L -f nc4 -mergetime  temp_run2_01.nc temp_run2_02.nc temp_run2_03.nc temp_run2_04.nc temp_run2_05.nc temp_run2_06.nc temp_run2_07.nc temp_run2_08.nc temp_run2_09.nc temp_run2_10.nc temp_run2_11.nc temp_run2_12.nc referencePotET_run_tss.nc
rm  temp01.nc temp_run_01.nc temp_run2_01.nc temp02.nc temp_run_02.nc temp_run2_02.nc temp03.nc temp_run_03.nc temp_run2_03.nc temp04.nc temp_run_04.nc temp_run2_04.nc temp05.nc temp_run_05.nc temp_run2_05.nc temp06.nc temp_run_06.nc temp_run2_06.nc temp07.nc temp_run_07.nc temp_run2_07.nc temp08.nc temp_run_08.nc temp_run2_08.nc temp09.nc temp_run_09.nc temp_run2_09.nc temp10.nc temp_run_10.nc temp_run2_10.nc temp11.nc temp_run_11.nc temp_run2_11.nc temp12.nc temp_run_12.nc temp_run2_12.nc
cdo -L -f nc4 -ymondiv referencePotET_run_tss.nc referencePotET_gcm_reference.nc referencePotET_gcm_ano.nc
cdo -L -f nc4 -mul -lec,100 referencePotET_gcm_ano.nc referencePotET_gcm_ano.nc temp.nc
cdo -L -f nc4 -add -mulc,100 -gtc,100 referencePotET_gcm_ano.nc temp.nc temp2.nc
cdo -L -f nc4 -setmisstoc,0 temp2.nc referencePotET_gcm_ano.nc
rm temp.nc
rm temp2.nc
cdo -L -f nc4 -ymonmul referencePotET_gcm_ano.nc referencePotET_div.nc referencePotET_ano.nc
cdo -L -f nc4 -monmul /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_referencePotET_2011_to_2100.nc referencePotET_ano.nc /scratch-shared/edwinhs/forcing_ISI-MIP_CRU-TS3.23_ERA20C/rcp2p6/GFDL-ESM2M/referencePotET//CRU-TS3.23_ERA20C_GLO_daily_referencePotET_2011_to_2100_GFDL-ESM2M_rcp2p6.nc
cdo -L -f nc4 -gridweights referencePotET_gcm_ano.nc temp_cellweights.nc
cdo -L -f nc4 -fldmean -mul temp_cellweights.nc referencePotET_gcm_ano.nc referencePotET_gcm_global_ano.nc
rm -f temp_cellweights.nc referencePotET_ano.nc referencePotET_gcm_ano.nc referencePotET_gcm_tss.nc referencePotET_run_tss.nc referencePotET_forcing.nc referencePotET_gcm_reference.nc referencePotET_reference.nc referencePotET_sub.nc
