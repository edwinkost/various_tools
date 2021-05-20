#!/bin/bash

#~ The unsaturated hydraulic conductivity K(s), which depends on the degree of saturation s, is calculated based on the relationship suggested by Campbell (1974):
#~ K(s) = Ksat × s^(2B + 3)

#~ We have to find s that corresponds to groundwater recharge. 
#~ gwRecharge (m/day) = Ksat . s^(2B + 3)

#~ log gwRecharge = log Ksat + (2B + 3) x log s

#~ log s = (log gwRecharge - log Ksat) / (2B + 3)

#~ log s = log (gwRecharge / Ksat) / (2B + 3)

#~ s = 10 ^ [ (log gwRecharge / Ksat) / (2B + 3) ]

#~ s = effective_theta / effective_theta_sat

#~ effective_theta = s x effective_theta_sat

# calculate the pore velocity
#~ v = gwRecharge / effective_theta

WORK_DIRECTORY="/scratch/depfg/sutan101/calculate_pore_velocity_jaivime/gmd_paper_naturalized/"
mkdir -p ${WORK_DIRECTORY}
cd ${WORK_DIRECTORY}

#~ # cleaning working directory - DANGEROUS
#~ rm *

# get the groundwater recharge (naturalized condition of groundwater recharge)
cp /scratch/depfg/sutan101/data/pcrglobwb_gmglob_input/develop/example_output/pcrglobwb/global_05min_naturalized/average_gwRecharge_m_per_day_1960_to_2010.map .

#~ sutan101@gpu038.cluster:/scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/landSurface/soil$ cdo showvar soilProperties5ArcMin.nc
 #~ firstStorDepth secondStorDepth soilWaterStorageCap1 soilWaterStorageCap2 airEntryValue1 airEntryValue2 poreSizeBeta1 poreSizeBeta2 resVolWC1 resVolWC2 satVolWC1 satVolWC2 KSat1 KSat2 percolationImp
#~ cdo    showname: Processed 15 variables [0.16s 16MB].
#~ sutan101@gpu038.cluster:/scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/landSurface/soil$ cdo showunit soilProperties5ArcMin.nc
 #~ m m m m m m 1 1 m3 m-3 m3 m-3 m3 m-3 m3 m-3 m day-1 m day-1 1
#~ cdo    showunit: Processed 15 variables [0.02s 16MB].

# get the kSat
cdo selvar,KSat2 /scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/landSurface/soil/soilProperties5ArcMin.nc kSat2_soilProperties5ArcMin.nc
gdal_translate -of PCRaster kSat2_soilProperties5ArcMin.nc kSat2_m_per_day_soilProperties5ArcMin.map

# get the effective_theta_sat
cdo selvar,satVolWC2 /scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/landSurface/soil/soilProperties5ArcMin.nc satVolWC2_soilProperties5ArcMin.nc
cdo selvar,resVolWC2 /scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/landSurface/soil/soilProperties5ArcMin.nc resVolWC2_soilProperties5ArcMin.nc
gdal_translate -of PCRaster satVolWC2_soilProperties5ArcMin.nc satVolWC2_soilProperties5ArcMin.map
gdal_translate -of PCRaster resVolWC2_soilProperties5ArcMin.nc resVolWC2_soilProperties5ArcMin.map
pcrcalc eff_theta_sat.map = "max(0.0, satVolWC2_soilProperties5ArcMin.map - resVolWC2_soilProperties5ArcMin.map)"
aguila eff_theta_sat.map

# get the poreSizeBeta2
cdo selvar,poreSizeBeta2 /scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/landSurface/soil/soilProperties5ArcMin.nc poreSizeBeta2_soilProperties5ArcMin.nc
gdal_translate -of PCRaster poreSizeBeta2_soilProperties5ArcMin.nc poreSizeBeta2_soilProperties5ArcMin.map

# make sure that all maps have the same mapattr
rm *.xml
mapattr -c average_gwRecharge_m_per_day_1960_to_2010.map *.map

# calculate degree_of_saturation that corresponds to groundwater recharge
pcrcalc degree_of_saturation_on_gw_recharge.map = "10 ** ( log10(  average_gwRecharge_m_per_day_1960_to_2010.map /  kSat2_m_per_day_soilProperties5ArcMin.map) / (2.0 * poreSizeBeta2_soilProperties5ArcMin.map + 3.0) )"
pcrcalc degree_of_saturation_on_gw_recharge.map = "min(1.0, degree_of_saturation_on_gw_recharge.map)"
aguila degree_of_saturation_on_gw_recharge.map

# get the effective_theta
pcrcalc effective_theta_on_gw_recharge.map = "degree_of_saturation_on_gw_recharge.map * eff_theta_sat.map"
aguila effective_theta_on_gw_recharge.map

# calculate pore velocity
pcrcalc pore_velocity_m_per_day_on_gw_recharge.map = "if(average_gwRecharge_m_per_day_1960_to_2010.map gt 0, average_gwRecharge_m_per_day_1960_to_2010.map / effective_theta_on_gw_recharge.map, 0)"
aguila pore_velocity_m_per_day_on_gw_recharge.map


