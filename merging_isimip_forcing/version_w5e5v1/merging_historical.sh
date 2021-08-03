
bash merging_historical_per_gcm.sh GFDL-ESM4     gfdl-esm4     &
bash merging_historical_per_gcm.sh IPSL-CM6A-LR  ipsl-cm6a-lr  &
bash merging_historical_per_gcm.sh MPI-ESM1-2-HR mpi-esm1-2-hr &
bash merging_historical_per_gcm.sh MRI-ESM2-0    mri-esm2-0    &
bash merging_historical_per_gcm.sh UKESM1-0-LL   ukesm1-0-ll   &

wait

#~ sutan101@gpu038.cluster:/scratch/depfg/sutan101/data/isimip_forcing/isimip3b/copied_on_2020-12-XX/source$ ls -lah
#~ total 5.0K
#~ dr-xr-xr-x 6 sutan101 depfg   8 Aug  3 21:55 .
#~ drwxr-xr-x 3 sutan101 depfg   1 Aug  3 21:55 ..
#~ dr-xr-xr-x 7 sutan101 depfg   5 Dec  8  2020 historical
#~ -r--r--r-- 1 sutan101 depfg 237 Dec  8  2020 rsync_from_isimip3b_historical.sh
#~ -r--r--r-- 1 sutan101 depfg 229 Dec  8  2020 rsync_from_isimip3b_ssp126.sh
#~ -r--r--r-- 1 sutan101 depfg 229 Dec  8  2020 rsync_from_isimip3b_ssp370.sh
#~ -r--r--r-- 1 sutan101 depfg 229 Dec  8  2020 rsync_from_isimip3b_ssp585.sh
#~ dr-xr-xr-x 7 sutan101 depfg   5 Dec  8  2020 ssp126
#~ dr-xr-xr-x 7 sutan101 depfg   5 Dec  8  2020 ssp370
#~ dr-xr-xr-x 7 sutan101 depfg   5 Dec  8  2020 ssp585
