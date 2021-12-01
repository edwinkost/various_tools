
set -x

CLONE_DIR="clone_01_30sec"
CLONE_DIR=$1

# go to the folder
cd /rds/general/user/esutanud/projects/arise/live/HydroModelling/edwin/pcrglobwb_output_africa_agmip/version_2021-10-XX/${CLONE_DIR}

# prepare the output folder and go to it
mkdir vmc_1981-1982
cd vmc_1981-1982

# load all software needed
cd /rds/general/user/esutanud/home/
. load_all_default.sh
cd -

# merge soil moisture files 
cdo -L -selyear,1981/1982 -mergetime ../*/netcdf/satDegUpp_dailyTot_output.nc satDegUpp_dailyTot_output_1981-1982.nc &
cdo -L -selyear,1981/1982 -mergetime ../*/netcdf/satDegLow_dailyTot_output.nc satDegLow_dailyTot_output_1981-1982.nc &
wait

# make grid description files
cdo griddes satDegUpp_dailyTot_output_1981-1982.nc > griddes.txt

# using soilgrids ; note that vmcRes values are zero in soilgrids
cdo remapcon,griddes.txt ../../soilgrids/version_2021-02-XX/vmcSat_average_1_africa_30sec.nc clone_vmcSat_average_1_africa_30sec.nc &
cdo remapcon,griddes.txt ../../soilgrids/version_2021-02-XX/vmcSat_average_2_africa_30sec.nc clone_vmcSat_average_2_africa_30sec.nc &
wait

# calculate vmc for each layer
cdo -L -setname,"vmc_upp" -mul clone_vmcSat_average_1_africa_30sec.nc satDegUpp_dailyTot_output_1981-1982.nc vmc_upp_from_satDegUpp_dailyTot_output_1981-1982.nc &
cdo -L -setname,"vmc_low" -mul clone_vmcSat_average_1_africa_30sec.nc satDegLow_dailyTot_output_1981-1982.nc vmc_low_from_satDegLow_dailyTot_output_1981-1982.nc &
wait

# modify variable attributes - units
ncatted -O -a units,vmc_upp,o,c,"m3.m-3" vmc_upp_from_satDegUpp_dailyTot_output_1981-1982.nc
ncatted -O -a units,vmc_low,o,c,"m3.m-3" vmc_low_from_satDegLow_dailyTot_output_1981-1982.nc

# modify variable attributes - standard_name
ncatted -O -a standard_name,vmc_upp,o,c,"vmc_upp" vmc_upp_from_satDegUpp_dailyTot_output_1981-1982.nc
ncatted -O -a standard_name,vmc_low,o,c,"vmc_low" vmc_low_from_satDegLow_dailyTot_output_1981-1982.nc

# modify variable attributes - long_name
ncatted -O -a long_name,vmc_upp,o,c,"volumetric_moisture_content_0p00_to_0p30m" vmc_upp_from_satDegUpp_dailyTot_output_1981-1982.nc
ncatted -O -a long_name,vmc_low,o,c,"volumetric_moisture_content_0p30_to_1p50m" vmc_low_from_satDegLow_dailyTot_output_1981-1982.nc

# modify/add description (global attribute)
ncatted -O -h -a description,global,a,c," ; Volmetric moisture content (vmc) values were calculated based on the SoilGrids with residual vmc equal to zero. ; theta = theta_res + satDeg * (theta_sat  theta_res). " vmc_upp_from_satDegUpp_dailyTot_output_1981-1982.nc
ncatted -O -h -a description,global,a,c," ; Volmetric moisture content (vmc) values were calculated based on the SoilGrids with residual vmc equal to zero  ; theta = theta_res + satDeg * (theta_sat  theta_res). " vmc_low_from_satDegLow_dailyTot_output_1981-1982.nc


# calculate average vmc over two layers
cdo mulc,0.3 vmc_upp_from_satDegUpp_dailyTot_output_1981-1982.nc temp_upp.nc
cdo mulc,1.2 vmc_low_from_satDegLow_dailyTot_output_1981-1982.nc temp_low.nc
cdo add temp_upp.nc temp_low.nc temp_total.nc
cdo -L -setname,"vmc_avg" -divc,1.5 temp_total.nc vmc_average_dailyTot_output_1981-1982.nc 
ncatted -O -a standard_name,vmc_avg,o,c,"vmc_avg" vmc_average_dailyTot_output_1981-1982.nc
ncatted -O -a long_name,vmc_avg,o,c,"volumetric_moisture_content_0p00_to_1p50m" vmc_average_dailyTot_output_1981-1982.nc


# check
ncdump -h vmc_upp_from_satDegUpp_dailyTot_output_1981-1982.nc
ncdump -h vmc_low_from_satDegLow_dailyTot_output_1981-1982.nc
ncdump -h vmc_average_dailyTot_output_1981-1982.nc

