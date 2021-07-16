
set -x

#~ w5e5   - low  (original unit: kg m-2 s-1)
#~ chirps - high (mm/day)

#~ # source files location:
#~ w5e5: /scratch/depfg/sutan101/data/isimip_forcing/w5e5_version_2.0/downloaded_on_2021-06-09/merged/pr_W5E5v2.0_19790101-20191231.nc
#~ chirps: /scratch/depfg/sutan101/meteo_arise/version_2021-02-XX/chirps_africa/150_arcsec/africa_chirps-v2.0_1981-2020_p05_rempacon-150-arcsec_daily.nc

# working directory
cd /scratch/depfg/sutan101/downscaling_w5e5v2/with_chirps/africa/final_all_years/
rm /scratch/depfg/sutan101/downscaling_w5e5v2/with_chirps/africa/final_all_years/*

#~ # sellonlatbox for w5e5 (crop to africa)
#~ Upper Left  ( -19.0000000,  39.0000000)
#~ Lower Left  ( -19.0000000, -36.0000000)ls 
#~ Upper Right (  61.0000000,  39.0000000)
#~ Lower Right (  61.0000000, -36.0000000)
#~ Center      (  21.0000000,   1.5000000)
cdo -L -selyear,1981/2019 -sellonlatbox,-19,61,39,-36 ../pr_W5E5v2.0_19790101-20191231_mm_per_day.nc pr_W5E5v2.0_1981-2019_mm_per_day_africa.nc
cdo griddes pr_W5E5v2.0_1981-2019_mm_per_day_africa.nc > griddes_w5e5_africa.txt

# set minimum treshold to original chirps (mm/day), e.g. chirps_mod = "max(1.0, chirps)" and cover everything with 1.0 
rm africa_chirps-v2.0_1981-2019_p05_rempacon-150-arcsec_daily_MODIFIED.nc
cdo -L -setmisstoc,1.0 -setrtoc,-inf,1.0,1.0 -selyear,1981/2019 ../africa_chirps-v2.0_1981-2020_p05_rempacon-150-arcsec_daily.nc africa_chirps-v2.0_1981-2019_p05_rempacon-150-arcsec_daily_MODIFIED.nc

# remapcon to make chirps_mod at low resolution, chirps_mod_low = remapcon from chirps_mod
rm africa_chirps-v2.0_1981-2019_p05_rempacon-150-arcsec_daily_MODIFIED_UPSCALED.nc
cdo remapcon,griddes_w5e5_africa.txt africa_chirps-v2.0_1981-2019_p05_rempacon-150-arcsec_daily_MODIFIED.nc africa_chirps-v2.0_1981-2019_p05_rempacon-150-arcsec_daily_MODIFIED_UPSCALED.nc


# DOWNSCALING: w5e5_high = w5e5 * (chirps_mod / chirps_mod_low) 

# before doing the downscaling, all input files must have the same grid/resolution of africa_chirps-v2.0_1981-2019_p05_rempacon-150-arcsec_daily_MODIFIED.nc
cdo griddes africa_chirps-v2.0_1981-2019_p05_rempacon-150-arcsec_daily_MODIFIED.nc > griddes_chirps_africa.txt
cdo remapcon,griddes_chirps_africa.txt africa_chirps-v2.0_1981-2019_p05_rempacon-150-arcsec_daily_MODIFIED_UPSCALED.nc africa_chirps-v2.0_1981-2019_p05_rempacon-150-arcsec_daily_MODIFIED_UPSCALED_REMAPCON.nc 
cdo remapcon,griddes_chirps_africa.txt pr_W5E5v2.0_1981-2019_mm_per_day_africa.nc pr_W5E5v2.0_1981-2019_mm_per_day_africa_REMAPCON.nc

# calculate the fraction = (chirps_mod / chirps_mod_low)
cdo div africa_chirps-v2.0_1981-2019_p05_rempacon-150-arcsec_daily_MODIFIED.nc africa_chirps-v2.0_1981-2019_p05_rempacon-150-arcsec_daily_MODIFIED_UPSCALED_REMAPCON.nc fraction.nc

# set minimum and maximum fraction to 0.2 and 5.0 and update the fraction for rescaling
cdo -L -setrtoc,5.0,inf,5.0 -setmisstoc,0.2 -setrtoc,-inf,0.2,0.2 fraction.nc fraction_with_limits.nc
cdo remapcon,griddes_w5e5_africa.txt fraction_with_limits.nc fraction_with_limits_UPSCALED.nc
cdo remapcon,griddes_chirps_africa.txt fraction_with_limits_UPSCALED.nc fraction_with_limits_UPSCALED_REMAPCON.nc
cdo div fraction_with_limits.nc fraction_with_limits_UPSCALED_REMAPCON.nc fractions_used.nc

# redo the rescaling
cdo -L -setrtoc,5.0,inf,5.0 -setmisstoc,0.2 -setrtoc,-inf,0.2,0.2 fractions_used.nc fraction_with_limits.nc
cdo remapcon,griddes_w5e5_africa.txt fraction_with_limits.nc fraction_with_limits_UPSCALED.nc
cdo remapcon,griddes_chirps_africa.txt fraction_with_limits_UPSCALED.nc fraction_with_limits_UPSCALED_REMAPCON.nc
cdo div fraction_with_limits.nc fraction_with_limits_UPSCALED_REMAPCON.nc fractions_used.nc

# redo the rescaling
cdo -L -setrtoc,5.0,inf,5.0 -setmisstoc,0.2 -setrtoc,-inf,0.2,0.2 fractions_used.nc fraction_with_limits.nc
cdo remapcon,griddes_w5e5_africa.txt fraction_with_limits.nc fraction_with_limits_UPSCALED.nc
cdo remapcon,griddes_chirps_africa.txt fraction_with_limits_UPSCALED.nc fraction_with_limits_UPSCALED_REMAPCON.nc
cdo div fraction_with_limits.nc fraction_with_limits_UPSCALED_REMAPCON.nc fractions_used.nc

# include cell area, to make sure that mass balance is conserved
cdo gridarea fractions_used.nc gridarea_fractions_used.nc
cdo mul fractions_used.nc gridarea_fractions_used.nc fraction_with_limits.nc
cdo remapcon,griddes_w5e5_africa.txt fraction_with_limits.nc fraction_with_limits_UPSCALED.nc
cdo remapcon,griddes_chirps_africa.txt fraction_with_limits_UPSCALED.nc fraction_with_limits_UPSCALED_REMAPCON.nc
cdo div fraction_with_limits.nc fraction_with_limits_UPSCALED_REMAPCON.nc fractions_used.nc

# check maximum fractions
cdo timmax fractions_used.nc timmax_fractions_used.nc

# downscaling
cdo mul pr_W5E5v2.0_1981-2019_mm_per_day_africa_REMAPCON.nc fractions_used.nc pr_W5E5v2.0_1981-2019_mm_per_day_africa_downscaled_with_chirps.nc

# check yearly values
cdo -L -setunit,mm.year-1 -yearsum pr_W5E5v2.0_1981-2019_mm_per_day_africa_downscaled_with_chirps.nc yearsum_pr_W5E5v2.0_1981-2019_mm_per_day_africa_downscaled_with_chirps.nc
cdo -L -setunit,mm.year-1 -yearsum pr_W5E5v2.0_1981-2019_mm_per_day_africa.nc yearsum_pr_W5E5v2.0_1981-2019_mm_per_day_africa.nc

set +x

