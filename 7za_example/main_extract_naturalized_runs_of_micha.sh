
#~ edwinsu@srv1.bullx:/projects/0/einf411/edwinsu$ ls -lah *hist*2005*
#~ -rw-r--r-- 1 edwinsu sd6183 92G Dec 21 10:15 GFDL-ESM2M_hist_Nat_KW_1988_2005_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 92G Dec 21 12:04 HadGEM2-ES_hist_Nat_KW_1988_2005_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 92G Dec 21 13:51 IPSL-CM5A-LR_hist_Nat_KW_1988_2005_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 91G Dec 21 15:32 MIROC-ESM-CHEM_hist_Nat_KW_1988_2005_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 91G Dec 21 17:11 NorESM1-M_hist_Nat_KW_1988_2005_netcdf.tar

#~ edwinsu@srv1.bullx:/projects/0/einf411/edwinsu$ ls -lah *2099*
#~ -rw-r--r-- 1 edwinsu sd6183 78G Dec 21 10:45 GFDL-ESM2M_rcp26_Nat_KW_2085_2099_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 78G Dec 21 11:15 GFDL-ESM2M_rcp45_Nat_KW_2085_2099_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 77G Dec 21 11:46 GFDL-ESM2M_rcp85_Nat_KW_2085_2099_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 78G Dec 21 12:34 HadGEM2-ES_rcp26_Nat_KW_2085_2099_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 77G Dec 21 13:05 HadGEM2-ES_rcp45_Nat_KW_2085_2099_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 77G Dec 21 13:35 HadGEM2-ES_rcp85_Nat_KW_2085_2099_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 78G Dec 21 14:19 IPSL-CM5A-LR_rcp26_Nat_KW_2085_2099_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 77G Dec 21 14:47 IPSL-CM5A-LR_rcp45_Nat_KW_2085_2099_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 77G Dec 21 15:15 IPSL-CM5A-LR_rcp85_Nat_KW_2085_2099_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 77G Dec 21 16:00 MIROC-ESM-CHEM_rcp26_Nat_KW_2085_2099_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 77G Dec 21 16:28 MIROC-ESM-CHEM_rcp45_Nat_KW_2085_2099_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 77G Dec 21 16:55 MIROC-ESM-CHEM_rcp85_Nat_KW_2085_2099_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 77G Dec 21 17:40 NorESM1-M_rcp26_Nat_KW_2085_2099_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 77G Dec 21 18:08 NorESM1-M_rcp45_Nat_KW_2085_2099_netcdf.tar
#~ -rw-r--r-- 1 edwinsu sd6183 77G Dec 21 18:36 NorESM1-M_rcp85_Nat_KW_2085_2099_netcdf.tar

module load p7zip

bash extract_naturalized_runs_of_micha.sh GFDL-ESM2M_hist      1951-2005 & 
#~ bash extract_naturalized_runs_of_micha.sh HadGEM2-ES_hist      1951-2005 & 
#~ bash extract_naturalized_runs_of_micha.sh IPSL-CM5A-LR_hist    1951-2005 & 
#~ bash extract_naturalized_runs_of_micha.sh MIROC-ESM-CHEM_hist  1951-2005 & 
#~ bash extract_naturalized_runs_of_micha.sh NorESM1-M_hist       1951-2005 &

#~ bash extract_naturalized_runs_of_micha.sh GFDL-ESM2M_rcp26     2006-2099 & 
#~ bash extract_naturalized_runs_of_micha.sh GFDL-ESM2M_rcp45     2006-2099 & 
#~ bash extract_naturalized_runs_of_micha.sh GFDL-ESM2M_rcp85     2006-2099 & 
#~ bash extract_naturalized_runs_of_micha.sh HadGEM2-ES_rcp26     2006-2099 & 
#~ bash extract_naturalized_runs_of_micha.sh HadGEM2-ES_rcp45     2006-2099 & 
#~ bash extract_naturalized_runs_of_micha.sh HadGEM2-ES_rcp85     2006-2099 & 
#~ bash extract_naturalized_runs_of_micha.sh IPSL-CM5A-LR_rcp26   2006-2099 & 
#~ bash extract_naturalized_runs_of_micha.sh IPSL-CM5A-LR_rcp45   2006-2099 & 
#~ bash extract_naturalized_runs_of_micha.sh IPSL-CM5A-LR_rcp85   2006-2099 & 
#~ bash extract_naturalized_runs_of_micha.sh MIROC-ESM-CHEM_rcp26 2006-2099 & 
#~ bash extract_naturalized_runs_of_micha.sh MIROC-ESM-CHEM_rcp45 2006-2099 & 
#~ bash extract_naturalized_runs_of_micha.sh MIROC-ESM-CHEM_rcp85 2006-2099 & 
#~ bash extract_naturalized_runs_of_micha.sh NorESM1-M_rcp26      2006-2099 & 
#~ bash extract_naturalized_runs_of_micha.sh NorESM1-M_rcp45      2006-2099 & 
bash extract_naturalized_runs_of_micha.sh NorESM1-M_rcp85      2006-2099 & 

wait
