
set -x

INP_FOLDER="/scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/netcdf_irr/"

OUTPUT_FOLDER="/scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/netcdf_irr/merged_annual/"
mkdir -p ${OUTPUT_FOLDER}
cd ${OUTPUT_FOLDER}


GRID_FILE_SOURCE="/scratch/depfg/sutan101/data/pcrglobwb_input_arise/develop/global_05min/routing/cell_area/cdo_gridarea_clone_global_05min_correct_lats.nc"
cdo griddes ${GRID_FILE_SOURCE} > griddes_global_05min.txt

#~ (pcrglobwb_python3) sutan101@gpu038.cluster:/scratch/depfg/sutan101/data/pcrglobwb_input_arise/develop/global_05min/routing/cell_area$ cdo griddes cdo_gridarea_clone_global_05min_correct_lats.nc
#~ #
#~ # gridID 1
#~ #
#~ gridtype  = lonlat
#~ gridsize  = 9331200
#~ xsize     = 4320
#~ ysize     = 2160
#~ xname     = lon
#~ xlongname = "longitude"
#~ xunits    = "degrees_east"
#~ yname     = lat
#~ ylongname = "latitude"
#~ yunits    = "degrees_north"
#~ xfirst    = -179.958333333333
#~ xinc      = 0.0833333333333333
#~ yfirst    = 89.9583333333333
#~ yinc      = -0.0833333333333333
#~ cdo    griddes: Processed 1 variable [0.06s 15MB].


#~ (pcrglobwb_python3) sutan101@gpu038.cluster:/scratch/depfg/sutan101/data/hyde3.2/downloaded_on_2021-08-11_baseline_only/baseline/zip_extracted_1800-2017/netcdf_irr/merged_annual$ ls -lah ../*2017*.nc
#~ -r--r--r-- 1 sutan101 depfg 36M Aug 12 11:44 ../ir_rice2017AD.nc
#~ -r--r--r-- 1 sutan101 depfg 36M Aug 12 11:45 ../ir_norice2017AD.nc
#~ -r--r--r-- 1 sutan101 depfg 36M Aug 12 11:45 ../tot_irri2017AD.nc

# mergetime, interpolate and setgrid and etc ...

cdo -L -f nc4 -setattribute,description="Fraction of rice irrigation areas. Based on the HYDE 3.2 dataset, processed by Edwin H. Sutanudjaja on 12 August 2021." \
              -setattribute,references="Klein Goldewijk et al. (2017), Earth Syst. Sci. Data, 9, 927-953" \
              -setattribute,source=${INP_FOLDER} \
              -setname,"vegetation_fraction" -setunit,1 -mulc,0.01 -setgrid,griddes_global_05min.txt -inttime,1800-01-01,00:00:00,1year -setmisstoc,0.0 -mergetime \
              ../ir_rice*.nc ir_rice_fraction_1800-2017_annual.nc 

# fixing standard_name and long_name
ncatted -O -a standard_name,"vegetation_fraction",m,c,"vegetation_fraction" ir_rice_fraction_1800-2017_annual.nc 
ncatted -O -a     long_name,"vegetation_fraction",m,c,"vegetation_fraction" ir_rice_fraction_1800-2017_annual.nc 

set +x
