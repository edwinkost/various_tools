#!/bin/bash 

#~ sutan101@gpu038.cluster:/scratch/depfg/sutan101/data/isimip_forcing/w5e5_version_2.0/downloaded_on_2021-06-09$ ls -lah *1979*
#~ -rw-r--r-- 1 sutan101 depfg 479M May  1 06:57 hurs_W5E5v2.0_19790101-19801231.nc
#~ -rw-r--r-- 1 sutan101 depfg 507M May  1 07:05 huss_W5E5v2.0_19790101-19801231.nc
#~ -rw-r--r-- 1 sutan101 depfg 166M May  1 07:20 prsn_W5E5v2.0_19790101-19801231.nc
#~ -rw-r--r-- 1 sutan101 depfg 464M May  1 07:13 pr_W5E5v2.0_19790101-19801231.nc
#~ -rw-r--r-- 1 sutan101 depfg 365M May  1 07:35 psl_W5E5v2.0_19790101-19801231.nc
#~ -rw-r--r-- 1 sutan101 depfg 402M May  1 07:27 ps_W5E5v2.0_19790101-19801231.nc
#~ -rw-r--r-- 1 sutan101 depfg 468M May  1 07:43 rlds_W5E5v2.0_19790101-19801231.nc
#~ -rw-r--r-- 1 sutan101 depfg 479M May  1 07:50 rsds_W5E5v2.0_19790101-19801231.nc
#~ -rw-r--r-- 1 sutan101 depfg 535M May  1 07:58 sfcWind_W5E5v2.0_19790101-19801231.nc
#~ -rw-r--r-- 1 sutan101 depfg 403M May  1 08:13 tasmax_W5E5v2.0_19790101-19801231.nc
#~ -rw-r--r-- 1 sutan101 depfg 405M May  1 08:21 tasmin_W5E5v2.0_19790101-19801231.nc
#~ -rw-r--r-- 1 sutan101 depfg 399M May  1 08:05 tas_W5E5v2.0_19790101-19801231.nc
#~ sutan101@gpu038.cluster:/scratch/depfg/sutan101/data/isimip_forcing/w5e5_version_2.0/downloaded_on_2021-06-09$ ls -lah *2019*
#~ -rw-r--r-- 1 sutan101 depfg 2.1G May  2 06:54 hurs_W5E5v2.0_20110101-20191231.nc
#~ -rw-r--r-- 1 sutan101 depfg 2.3G May  2 07:28 huss_W5E5v2.0_20110101-20191231.nc
#~ -rw-r--r-- 1 sutan101 depfg 716M May  2 08:30 prsn_W5E5v2.0_20110101-20191231.nc
#~ -rw-r--r-- 1 sutan101 depfg 2.1G May  2 07:59 pr_W5E5v2.0_20110101-20191231.nc
#~ -rw-r--r-- 1 sutan101 depfg 1.6G May  2 09:35 psl_W5E5v2.0_20110101-20191231.nc
#~ -rw-r--r-- 1 sutan101 depfg 1.8G May  2 09:03 ps_W5E5v2.0_20110101-20191231.nc
#~ -rw-r--r-- 1 sutan101 depfg 2.1G May  2 10:07 rlds_W5E5v2.0_20110101-20191231.nc
#~ -rw-r--r-- 1 sutan101 depfg 2.1G May  2 10:40 rsds_W5E5v2.0_20110101-20191231.nc
#~ -rw-r--r-- 1 sutan101 depfg 2.4G May  2 11:13 sfcWind_W5E5v2.0_20110101-20191231.nc
#~ -rw-r--r-- 1 sutan101 depfg 1.8G May  2 12:19 tasmax_W5E5v2.0_20110101-20191231.nc
#~ -rw-r--r-- 1 sutan101 depfg 1.8G May  2 12:53 tasmin_W5E5v2.0_20110101-20191231.nc
#~ -rw-r--r-- 1 sutan101 depfg 1.8G May  2 11:45 tas_W5E5v2.0_20110101-20191231.nc


set -x

cd /scratch/depfg/sutan101/data/isimip_forcing/w5e5_version_2.0/downloaded_on_2021-06-09/merged/

cdo -L -f nc4 -selyear,1979/2019 -mergetime ../hurs_W5E5v2.0_*.nc    hurs_W5E5v2.0_19790101-20191231.nc     &
cdo -L -f nc4 -selyear,1979/2019 -mergetime ../huss_W5E5v2.0_*.nc    huss_W5E5v2.0_19790101-20191231.nc     &
cdo -L -f nc4 -selyear,1979/2019 -mergetime ../prsn_W5E5v2.0_*.nc    prsn_W5E5v2.0_19790101-20191231.nc     &
cdo -L -f nc4 -selyear,1979/2019 -mergetime ../pr_W5E5v2.0_*.nc      pr_W5E5v2.0_19790101-20191231.nc       &
cdo -L -f nc4 -selyear,1979/2019 -mergetime ../psl_W5E5v2.0_*.nc     psl_W5E5v2.0_19790101-20191231.nc      &
cdo -L -f nc4 -selyear,1979/2019 -mergetime ../ps_W5E5v2.0_*.nc      ps_W5E5v2.0_19790101-20191231.nc       &
cdo -L -f nc4 -selyear,1979/2019 -mergetime ../rlds_W5E5v2.0_*.nc    rlds_W5E5v2.0_19790101-20191231.nc     &
cdo -L -f nc4 -selyear,1979/2019 -mergetime ../rsds_W5E5v2.0_*.nc    rsds_W5E5v2.0_19790101-20191231.nc     &
cdo -L -f nc4 -selyear,1979/2019 -mergetime ../sfcWind_W5E5v2.0_*.nc sfcWind_W5E5v2.0_19790101-20191231.nc  &
cdo -L -f nc4 -selyear,1979/2019 -mergetime ../tasmax_W5E5v2.0_*.nc  tasmax_W5E5v2.0_19790101-20191231.nc   &
cdo -L -f nc4 -selyear,1979/2019 -mergetime ../tasmin_W5E5v2.0_*.nc  tasmin_W5E5v2.0_19790101-20191231.nc   &
cdo -L -f nc4 -selyear,1979/2019 -mergetime ../tas_W5E5v2.0_*.nc     tas_W5E5v2.0_19790101-20191231.nc      &

wait

cdo -L -f nc4 -setyear,1978 -ydayavg -delete,month=2,day=29 hurs_W5E5v2.0_19790101-20191231.nc    climatology_hurs_W5E5v2.0_19790101-20191231.nc    &
cdo -L -f nc4 -setyear,1978 -ydayavg -delete,month=2,day=29 huss_W5E5v2.0_19790101-20191231.nc    climatology_huss_W5E5v2.0_19790101-20191231.nc    &
cdo -L -f nc4 -setyear,1978 -ydayavg -delete,month=2,day=29 prsn_W5E5v2.0_19790101-20191231.nc    climatology_prsn_W5E5v2.0_19790101-20191231.nc    &
cdo -L -f nc4 -setyear,1978 -ydayavg -delete,month=2,day=29 pr_W5E5v2.0_19790101-20191231.nc      climatology_pr_W5E5v2.0_19790101-20191231.nc      &
cdo -L -f nc4 -setyear,1978 -ydayavg -delete,month=2,day=29 psl_W5E5v2.0_19790101-20191231.nc     climatology_psl_W5E5v2.0_19790101-20191231.nc     &
cdo -L -f nc4 -setyear,1978 -ydayavg -delete,month=2,day=29 ps_W5E5v2.0_19790101-20191231.nc      climatology_ps_W5E5v2.0_19790101-20191231.nc      &
cdo -L -f nc4 -setyear,1978 -ydayavg -delete,month=2,day=29 rlds_W5E5v2.0_19790101-20191231.nc    climatology_rlds_W5E5v2.0_19790101-20191231.nc    &
cdo -L -f nc4 -setyear,1978 -ydayavg -delete,month=2,day=29 rsds_W5E5v2.0_19790101-20191231.nc    climatology_rsds_W5E5v2.0_19790101-20191231.nc    &
cdo -L -f nc4 -setyear,1978 -ydayavg -delete,month=2,day=29 sfcWind_W5E5v2.0_19790101-20191231.nc climatology_sfcWind_W5E5v2.0_19790101-20191231.nc &
cdo -L -f nc4 -setyear,1978 -ydayavg -delete,month=2,day=29 tasmax_W5E5v2.0_19790101-20191231.nc  climatology_tasmax_W5E5v2.0_19790101-20191231.nc  &
cdo -L -f nc4 -setyear,1978 -ydayavg -delete,month=2,day=29 tasmin_W5E5v2.0_19790101-20191231.nc  climatology_tasmin_W5E5v2.0_19790101-20191231.nc  &
cdo -L -f nc4 -setyear,1978 -ydayavg -delete,month=2,day=29 tas_W5E5v2.0_19790101-20191231.nc     climatology_tas_W5E5v2.0_19790101-20191231.nc     &

wait

set +x
