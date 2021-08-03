
bash merging_historical_per_gcm.sh GFDL-ESM4     gfdl-esm4     &
bash merging_historical_per_gcm.sh IPSL-CM6A-LR  ipsl-cm6a-lr  &
bash merging_historical_per_gcm.sh MPI-ESM1-2-HR mpi-esm1-2-hr &
bash merging_historical_per_gcm.sh MRI-ESM2-0    mri-esm2-0    &
bash merging_historical_per_gcm.sh UKESM1-0-LL   ukesm1-0-ll   &

wait

#~ sutan101@gpu038.cluster:/scratch/depfg/sutan101/data/isimip_forcing/isimip3b_version_2021-05-XX/copied_on_2021-06-XX/source/historical$ ls -lah
#~ total 3.5K
#~ dr-xr-xr-x 7 sutan101 depfg   5 Jun 29 22:39 .
#~ dr-xr-xr-x 6 sutan101 depfg   9 Aug  3 14:46 ..
#~ dr-xr-xr-x 2 sutan101 depfg 198 Jun 30 00:35 GFDL-ESM4
#~ dr-xr-xr-x 2 sutan101 depfg 198 Jun 30 02:34 IPSL-CM6A-LR
#~ dr-xr-xr-x 2 sutan101 depfg 198 Jun 30 04:32 MPI-ESM1-2-HR
#~ dr-xr-xr-x 2 sutan101 depfg 198 Jun 30 06:34 MRI-ESM2-0
#~ dr-xr-xr-x 2 sutan101 depfg 198 Jun 30 08:11 UKESM1-0-LL

#~ sutan101@gpu038.cluster:/scratch/depfg/sutan101/data/isimip_forcing/isimip3b_version_2021-05-XX/copied_on_2021-06-XX/source/historical$ ls -lah ls -lah */*huss*2014*
#~ ls: cannot access ls: No such file or directory
#~ -r--r--r-- 1 sutan101 depfg 1.1G Jun 29 22:57 GFDL-ESM4/gfdl-esm4_r1i1p1f1_w5e5_historical_huss_global_daily_2011_2014.nc
#~ -r--r--r-- 1 sutan101 depfg 1.1G Jun 30 01:01 IPSL-CM6A-LR/ipsl-cm6a-lr_r1i1p1f1_w5e5_historical_huss_global_daily_2011_2014.nc
#~ -r--r--r-- 1 sutan101 depfg 1.1G Jun 30 02:59 MPI-ESM1-2-HR/mpi-esm1-2-hr_r1i1p1f1_w5e5_historical_huss_global_daily_2011_2014.nc
#~ -r--r--r-- 1 sutan101 depfg 1.1G Jun 30 04:58 MRI-ESM2-0/mri-esm2-0_r1i1p1f1_w5e5_historical_huss_global_daily_2011_2014.nc
#~ -r--r--r-- 1 sutan101 depfg 1.1G Jun 30 06:52 UKESM1-0-LL/ukesm1-0-ll_r1i1p1f2_w5e5_historical_huss_global_daily_2011_2014.nc

