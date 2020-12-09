set -x

OUTPUT_FOLDER=""
cd ${OUTPUT_FOLDER}

rm *.map
rm *.nc


mapattr -s -R 21600 -C 43200 -B -P yb2t -x -180 -y 90 -l 0.0083333333333333333333333333333333333333333333333333333333333333333333333333333333333333333 clone_global_30sec.map

gdal_translate -of NETCDF clone_global_30sec.map clone_global_30sec.nc
cdo invertlat clone_global_30sec.nc clone_global_30sec_correct_lat.nc

cdo griddes clone_global_30sec_correct_lat.nc

cdo gridarea clone_global_30sec_correct_lat.nc cdo_gridarea_30sec.nc

gdal_translate -of PCRaster cdo_gridarea_30sec.nc cdo_gridarea_30sec.map

mapattr -c clone_global_30sec.map *.map
mapattr -p *.map

# 1 arcmin ~ 1852 m
pcrcalc --clone clone_global_30sec.map vertical_size.map = "0.5*1852."

pcrcalc horizontal_size.map = "cdo_gridarea_30sec.map / vertical_size.map"

pcrcalc --clone cdo_gridarea_30sec.map x_ids.map = "clump(ordinal(xcoordinate( boolean(1.0)  ) * 60. * 60.))"
pcrcalc --clone cdo_gridarea_30sec.map y_ids.map = "clump(ordinal(ycoordinate( boolean(1.0)  ) * 60. * 60.))"

pcrcalc horizontal_size_avg.map = "areaaverage(horizontal_size.map, y_ids.map)" &
pcrcalc horizontal_size_max.map = "areamaximum(horizontal_size.map, y_ids.map)" &
pcrcalc horizontal_size_min.map = "areaminimum(horizontal_size.map, y_ids.map)" &
wait

pcrcalc diff_max_min_horizontal_size.map = horizontal_size_max.map - horizontal_size_min.map 

aguila *.map 

set +x
