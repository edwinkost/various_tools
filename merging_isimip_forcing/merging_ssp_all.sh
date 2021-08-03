
bash merging_ssp_per_gcm.sh GFDL-ESM4     gfdl-esm4     ssp126 &
bash merging_ssp_per_gcm.sh IPSL-CM6A-LR  ipsl-cm6a-lr  ssp126 &
bash merging_ssp_per_gcm.sh MPI-ESM1-2-HR mpi-esm1-2-hr ssp126 &
bash merging_ssp_per_gcm.sh MRI-ESM2-0    mri-esm2-0    ssp126 &
bash merging_ssp_per_gcm.sh UKESM1-0-LL   ukesm1-0-ll   ssp126 &

wait

bash merging_ssp_per_gcm.sh GFDL-ESM4     gfdl-esm4     ssp370 &
bash merging_ssp_per_gcm.sh IPSL-CM6A-LR  ipsl-cm6a-lr  ssp370 &
bash merging_ssp_per_gcm.sh MPI-ESM1-2-HR mpi-esm1-2-hr ssp370 &
bash merging_ssp_per_gcm.sh MRI-ESM2-0    mri-esm2-0    ssp370 &
bash merging_ssp_per_gcm.sh UKESM1-0-LL   ukesm1-0-ll   ssp370 &

wait

bash merging_ssp_per_gcm.sh GFDL-ESM4     gfdl-esm4     ssp585 &
bash merging_ssp_per_gcm.sh IPSL-CM6A-LR  ipsl-cm6a-lr  ssp585 &
bash merging_ssp_per_gcm.sh MPI-ESM1-2-HR mpi-esm1-2-hr ssp585 &
bash merging_ssp_per_gcm.sh MRI-ESM2-0    mri-esm2-0    ssp585 &
bash merging_ssp_per_gcm.sh UKESM1-0-LL   ukesm1-0-ll   ssp585 &

wait

