set -x

rm *.map

cp /projects/0/dfguu/data/hydroworld/PCRGLOBWB20/input5min/routing/cellsize05min.correct.map .

pcrcalc --clone cellsize05min.correct.map vertical_size.map = "5.*1852."
pcrcalc horizontal_size.map = "cellsize05min.correct.map / vertical_size.map"

pcrcalc --clone cellsize05min.correct.map x_ids.map = "clump(ordinal(xcoordinate( boolean(1.0)  ) * 60.))"
pcrcalc --clone cellsize05min.correct.map y_ids.map = "clump(ordinal(ycoordinate( boolean(1.0)  ) * 60.))"

pcrcalc horizontal_size_mean.map = "areaaverage(horizontal_size.map, y_ids.map)"
pcrcalc horizontal_size_max.map = "areamaximum(horizontal_size.map, y_ids.map)"
pcrcalc horizontal_size_min.map = "areaminimum(horizontal_size.map, y_ids.map)"
pcrcalc diff_max_min_horizontal_size.map = horizontal_size_max.map - horizontal_size_min.map 

aguila *.map 

set +x
