
#~ sutan101@node032.cluster:/scratch/depfg/sutan101/pcrglobwb_wri_aqueduct_2021/pcrglobwb_aqueduct_2021_monthly_annual_files/version_2021-09-16$ ls -lah
#~ total 13K
#~ dr-xr-xr-x 9 sutan101 depfg 9 Jan 17 03:57 .
#~ drwxr-xr-x 4 sutan101 depfg 4 Feb  3 14:27 ..
#~ dr-xr-xr-x 6 sutan101 depfg 6 Jan 16 20:01 gfdl-esm4
#~ dr-xr-xr-x 3 sutan101 depfg 3 Jan 16 20:38 gswp3-w5e5
#~ dr-xr-xr-x 3 sutan101 depfg 3 Jan 16 21:10 gswp3-w5e5_rerun
#~ dr-xr-xr-x 6 sutan101 depfg 6 Jan 16 23:10 ipsl-cm6a-lr
#~ dr-xr-xr-x 6 sutan101 depfg 6 Jan 17 01:13 mpi-esm1-2-hr
#~ dr-xr-xr-x 6 sutan101 depfg 6 Jan 17 03:20 mri-esm2-0
#~ dr-xr-xr-x 6 sutan101 depfg 6 Jan 17 05:27 ukesm1-0-ll

GCM_NAME="gfdl-esm4"
sbatch -J gfdlhist --export GCM_NAME=${GCM_NAME},SCN_TYPE="historical",START_YR="1960",FINAL_YR="2014"
sbatch -J gfdlssp1 --export GCM_NAME=${GCM_NAME},SCN_TYPE="ssp126",START_YR="2015",FINAL_YR="2100"
sbatch -J gfdlssp3 --export GCM_NAME=${GCM_NAME},SCN_TYPE="ssp370",START_YR="2015",FINAL_YR="2100"
sbatch -J gfdlssp5 --export GCM_NAME=${GCM_NAME},SCN_TYPE="ssp585",START_YR="2015",FINAL_YR="2100"
  
#~ GCM_NAME="ipsl-cm6a-lr"
#~ sbatch -J ipslhist --export GCM_NAME=${GCM_NAME},SCN_TYPE="historical",START_YR="1960",FINAL_YR="2014"
#~ sbatch -J ipslssp1 --export GCM_NAME=${GCM_NAME},SCN_TYPE="ssp126",START_YR="2015",FINAL_YR="2100"
#~ sbatch -J ipslssp3 --export GCM_NAME=${GCM_NAME},SCN_TYPE="ssp370",START_YR="2015",FINAL_YR="2100"
#~ sbatch -J ipslssp5 --export GCM_NAME=${GCM_NAME},SCN_TYPE="ssp585",START_YR="2015",FINAL_YR="2100"

#~ GCM_NAME="mpi-esm1-2-hr"
#~ sbatch -J ipslhist --export GCM_NAME=${GCM_NAME},SCN_TYPE="historical",START_YR="1960",FINAL_YR="2014"
#~ sbatch -J ipslssp1 --export GCM_NAME=${GCM_NAME},SCN_TYPE="ssp126",START_YR="2015",FINAL_YR="2100"
#~ sbatch -J ipslssp3 --export GCM_NAME=${GCM_NAME},SCN_TYPE="ssp370",START_YR="2015",FINAL_YR="2100"
#~ sbatch -J ipslssp5 --export GCM_NAME=${GCM_NAME},SCN_TYPE="ssp585",START_YR="2015",FINAL_YR="2100"

#~ mri-esm2-0

#~ ukesm1-0-ll


#~ sutan101@node032.cluster:/scratch/depfg/sutan101/pcrglobwb_wri_aqueduct_2021/pcrglobwb_aqueduct_2021_monthly_annual_files/version_2021-09-16$ ls -lah gfdl-esm4/
#~ total 11K
#~ dr-xr-xr-x 6 sutan101 depfg 6 Jan 16 20:01 .
#~ dr-xr-xr-x 9 sutan101 depfg 9 Jan 17 03:57 ..
#~ dr-xr-xr-x 3 sutan101 depfg 3 Jan 16 15:02 historical
#~ dr-xr-xr-x 3 sutan101 depfg 3 Jan 16 18:57 ssp126
#~ dr-xr-xr-x 3 sutan101 depfg 3 Jan 16 19:27 ssp370
#~ dr-xr-xr-x 3 sutan101 depfg 3 Jan 16 20:01 ssp585
