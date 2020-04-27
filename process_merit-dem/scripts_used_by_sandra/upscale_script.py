#! /usr/bin/python

# make sure the following modules are loaded 
#~ $ module load eb
#~ $ module load GDAL
#~ $ . /home/edwin/bin-special/pcraster-4.1.0-beta-20151027_x86-64_gcc-4/bashrc_special_pcraster_modflow

import os
import sys
import gdal
import pcraster as pcr

import virtualOS as vos

# give your tile code as the system argument
tile_code = "dem_tif_n60w180"
tile_code = sys.argv[1]


input_folder  = "/projects/0/dfguu/users/sandrahw/download/" + tile_code
output_folder = "/projects/0/dfguu/users/sandrahw/MERIT_upscaled_30sec/" + tile_code

# make and set the directory to the output folder
cmd = "mkdir -p " + output_folder
print(cmd); os.system(cmd)
os.chdir(output_folder)
# - cleaning the output folder
cmd = "rm -r " + output_folder + "/*"
print(cmd); os.system(cmd)

# merge all tif files
input_tif_files = input_folder + "/*"
output_file = output_folder + "/" + tile_code + ".tif"
cmd = "python /hpc/eb/RedHatEnterpriseServer7/GDAL/2.2.3-foss-2017b-Python-2.7.14/bin/gdal_merge.py -o " + output_file + " " + input_tif_files 
print(cmd); os.system(cmd)
#
# - then convert it to a pcraster file:
input_tif_file = output_file
output_file = output_folder + "/" + tile_code + ".map"
cmd = "gdal_translate -of PCRaster " + input_tif_file + " " + output_file
print(cmd); os.system(cmd)
# - this is an original input pcraster map at 3 arc sec resolution


# prepare the clone map at 30 arc sec resolution (e.g. $ mapattr -s -R 1800 -C 3600 -B -P yb2t -x -180 -y 75 -l 0.008333333333333333333333333333333333333333333333333333 dem_tif_n60w180.30sec.clo.map)
num_of_rows_30sec = str(vos.getMapAttributesALL(output_file)["rows"] / 10.)
num_of_cols_30sec = str(vos.getMapAttributesALL(output_file)["cols"] / 10.)
x_coordinate = str(vos.getMapAttributesALL(output_file)["xUL"])
y_coordinate = str(vos.getMapAttributesALL(output_file)["yUL"])
cellsize_30sec = "0.00833333333333333333333333333333333333333333333333333333333333333333333333333333"
output_file = output_folder + "/" + tile_code + ".30sec.clo.map"
cmd = "mapattr -s -R " + num_of_rows_30sec + " -C " + num_of_cols_30sec + " -B -P yb2t -x " + x_coordinate + " -y " + y_coordinate + " -l " + cellsize_30sec + " " + output_file
print(cmd); os.system(cmd)


# give the ids for every 30 arc sec cell (e.g. pcrcalc dem_tif_n60w180_30sec.ids.map  = "nominal(uniqueid(dem_tif_n60w180_30sec.clo.map))")
input_file = output_file
output_file = output_folder + "/" + tile_code + ".30sec.ids.map"
pcr.setclone(input_file)
print("Making the clone map at 30 arcsec resolution.")
unique_ids_30sec = pcr.nominal(pcr.uniqueid(input_file))
pcr.report(unique_ids_30sec, output_file)
# - Note that this map has 30 arc sec resolution.


# resample the ids map to 3 arc sec resolution (e.g. gdalwarp -tr 0.00083333333333333333333333333333333333333 0.00083333333333333333333333333333333333333 dem_tif_n60w180_30sec.ids.map dem_tif_n60w180_30sec.ids.3sec.tif
input_file = output_file
output_file = output_folder + "/" + tile_code + ".30sec.ids.3sec.tif"
cellsize_3sec = "0.000833333333333333333333333333333333333333333333333333333333333333333333333333333"
cmd = "gdalwarp -tr " + cellsize_3sec + " " + cellsize_3sec  + " " +  input_file + " " + output_file
print(cmd); os.system(cmd)
# - This still a tif file. 

# convert the tif file to PCRaster map
input_file = output_file
output_file = output_folder + "/" + tile_code + ".30sec.ids.3sec.map"
cmd = 'gdal_translate -of PCRaster ' + input_file + " " + output_file
print(cmd); os.system(cmd)

# make sure that the clone of input DEM is consistent with the aforementioned clone:
ids_3sec = output_file
dem_3sec = output_folder + "/" + tile_code + ".map"
cmd = "mapattr -c " + ids_3sec + " " + dem_3sec
print(cmd); os.system(cmd)
# - check
cmd = "mapattr -p " + ids_3sec + " " + dem_3sec
print(cmd); os.system(cmd)

 
# do the upscaling/averaging from 3 arc second DEM to 30 arc second values:
pcr.setclone(ids_3sec)
msg = "Upscaling in progress for the tile " + tile_code
print(msg)
dem_30sec = pcr.areaaverage(dem_3sec, ids_3sec)
output_file = output_folder + "/" + tile_code + ".30sec.3sec.map"
pcr.report(dem_30sec, output_file)
# - The cell size will be still 3 arc second.


# then resample (using gdalwarp) to 30 arc second file:
input_file = output_file
output_file = output_folder + "/" + tile_code + ".30sec.tif"
cmd = "gdalwarp -tr " + cellsize_30sec + " " + cellsize_30sec + " " + input_file + " " + output_file 
print(cmd); os.system(cmd)
# - this is still a tif file

# convert it to pcraster
input_file = output_file
output_file = output_folder + "/" + tile_code + ".30sec.map"
cmd = "gdal_translate -of PCRaster " + input_file + " " + output_file
print(cmd); os.system(cmd)


#~ # check (this should be deactivated while running all parallel scripts)
#~ dem_3sec_file  = dem_3sec
#~ dem_30sec_file = output_file
#~ cmd = "aguila " + dem_3sec_file + " " + dem_30sec_file
#~ print(cmd); os.system(cmd)
