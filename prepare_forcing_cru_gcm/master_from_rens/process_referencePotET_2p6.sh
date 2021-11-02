cdo ymonmean -seldate,1961-01-01,1990-12-31 /projects/0/dfguu/data/hydroworld/forcing/ERA20C/CRU-TS3.23_ERA20C_daily_referencePotET_1901_to_2010.nc referencePotET_reference.nc 
cdo ymonmean /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_referencePotET_2011_to_2100.nc referencePotET_forcing.nc 
cdo div referencePotET_reference.nc referencePotET_forcing.nc referencePotET_div.nc 
cdo mul -lec,100 referencePotET_div.nc referencePotET_div.nc temp.nc
cdo add -mulc,100 -gtc,100 referencePotET_div.nc temp.nc temp2.nc
cdo setmisstoc,0 temp2.nc referencePotET_div.nc
rm temp.nc
rm temp2.nc
cdo ymonmean -seldate,1961-01-01,1990-12-31 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/epot_bced_1960_1999_hadgem2-es_hist_1951-2005.nc referencePotET_gcm_reference.nc 
cdo monmean /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/epot_bced_1960_1999_hadgem2-es_2p6_2006-2099.nc temp.nc
cdo seldate,2090-01-01,2099-12-31 temp.nc temp2.nc
cdo shifttime,+10years temp2.nc temp3.nc
cdo mergetime temp.nc temp3.nc referencePotET_gcm_tss.nc
rm temp.nc
rm temp2.nc
rm temp3.nc
cdo selmon,1 referencePotET_gcm_tss.nc temp01.nc
cdo runmean,11 temp01.nc temp_run_01.nc
cdo seldate,2011-01-01,2100-12-31 temp_run_01.nc temp_run2_01.nc
cdo selmon,2 referencePotET_gcm_tss.nc temp02.nc
cdo runmean,11 temp02.nc temp_run_02.nc
cdo seldate,2011-01-01,2100-12-31 temp_run_02.nc temp_run2_02.nc
cdo selmon,3 referencePotET_gcm_tss.nc temp03.nc
cdo runmean,11 temp03.nc temp_run_03.nc
cdo seldate,2011-01-01,2100-12-31 temp_run_03.nc temp_run2_03.nc
cdo selmon,4 referencePotET_gcm_tss.nc temp04.nc
cdo runmean,11 temp04.nc temp_run_04.nc
cdo seldate,2011-01-01,2100-12-31 temp_run_04.nc temp_run2_04.nc
cdo selmon,5 referencePotET_gcm_tss.nc temp05.nc
cdo runmean,11 temp05.nc temp_run_05.nc
cdo seldate,2011-01-01,2100-12-31 temp_run_05.nc temp_run2_05.nc
cdo selmon,6 referencePotET_gcm_tss.nc temp06.nc
cdo runmean,11 temp06.nc temp_run_06.nc
cdo seldate,2011-01-01,2100-12-31 temp_run_06.nc temp_run2_06.nc
cdo selmon,7 referencePotET_gcm_tss.nc temp07.nc
cdo runmean,11 temp07.nc temp_run_07.nc
cdo seldate,2011-01-01,2100-12-31 temp_run_07.nc temp_run2_07.nc
cdo selmon,8 referencePotET_gcm_tss.nc temp08.nc
cdo runmean,11 temp08.nc temp_run_08.nc
cdo seldate,2011-01-01,2100-12-31 temp_run_08.nc temp_run2_08.nc
cdo selmon,9 referencePotET_gcm_tss.nc temp09.nc
cdo runmean,11 temp09.nc temp_run_09.nc
cdo seldate,2011-01-01,2100-12-31 temp_run_09.nc temp_run2_09.nc
cdo selmon,10 referencePotET_gcm_tss.nc temp10.nc
cdo runmean,11 temp10.nc temp_run_10.nc
cdo seldate,2011-01-01,2100-12-31 temp_run_10.nc temp_run2_10.nc
cdo selmon,11 referencePotET_gcm_tss.nc temp11.nc
cdo runmean,11 temp11.nc temp_run_11.nc
cdo seldate,2011-01-01,2100-12-31 temp_run_11.nc temp_run2_11.nc
cdo selmon,12 referencePotET_gcm_tss.nc temp12.nc
cdo runmean,11 temp12.nc temp_run_12.nc
cdo seldate,2011-01-01,2100-12-31 temp_run_12.nc temp_run2_12.nc
cdo mergetime  temp_run2_01.nc temp_run2_02.nc temp_run2_03.nc temp_run2_04.nc temp_run2_05.nc temp_run2_06.nc temp_run2_07.nc temp_run2_08.nc temp_run2_09.nc temp_run2_10.nc temp_run2_11.nc temp_run2_12.nc referencePotET_run_tss.nc
rm  temp01.nc temp_run_01.nc temp_run2_01.nc temp02.nc temp_run_02.nc temp_run2_02.nc temp03.nc temp_run_03.nc temp_run2_03.nc temp04.nc temp_run_04.nc temp_run2_04.nc temp05.nc temp_run_05.nc temp_run2_05.nc temp06.nc temp_run_06.nc temp_run2_06.nc temp07.nc temp_run_07.nc temp_run2_07.nc temp08.nc temp_run_08.nc temp_run2_08.nc temp09.nc temp_run_09.nc temp_run2_09.nc temp10.nc temp_run_10.nc temp_run2_10.nc temp11.nc temp_run_11.nc temp_run2_11.nc temp12.nc temp_run_12.nc temp_run2_12.nc
cdo ymondiv referencePotET_run_tss.nc referencePotET_gcm_reference.nc referencePotET_gcm_ano.nc
cdo mul -lec,100 referencePotET_gcm_ano.nc referencePotET_gcm_ano.nc temp.nc
cdo add -mulc,100 -gtc,100 referencePotET_gcm_ano.nc temp.nc temp2.nc
cdo setmisstoc,0 temp2.nc referencePotET_gcm_ano.nc
rm temp.nc
rm temp2.nc
cdo ymonmul referencePotET_gcm_ano.nc referencePotET_div.nc referencePotET_ano.nc
cdo monmul /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_referencePotET_2011_to_2100.nc referencePotET_ano.nc /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_referencePotET_2011_to_2100_rcp2p6.nc
cdo gridweights referencePotET_gcm_ano.nc temp_cellweights.nc
cdo fldmean -mul temp_cellweights.nc referencePotET_gcm_ano.nc referencePotET_gcm_global_ano.nc
rm -f temp_cellweights.nc referencePotET_ano.nc referencePotET_gcm_ano.nc referencePotET_gcm_tss.nc referencePotET_run_tss.nc referencePotET_forcing.nc referencePotET_gcm_reference.nc referencePotET_reference.nc referencePotET_sub.nc
