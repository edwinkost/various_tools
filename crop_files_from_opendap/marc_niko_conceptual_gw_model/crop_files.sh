

set -x

set +x

MAIN_SOURCE_DIR="https://opendap.tudelft.nl/thredds/dodsC/data2/pcrglobwb/version_2019_11_beta/"

NATURAL_DISCHARGE_FILE="/scratch-shared/edwin/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/natural/merged_1958_to_2015/"

#~ Global
#~ - Natural discharge: Qfast (1 + 2) + Qbaseflow (= discharge)
#~ - J-values
#~ - Porosities
#~ - Current pumping rates (say 2010-2015)
#~ - Dimensions water courses (depth and width)
#~ - Validation: From coupled PCR-GMOD: groundwater level decline 2010-2015 plus reduction in Flow (Qnat – Qpump)

#~ Kansas – voor zover in Missouri-Mississippi basin
#~ bounding box
#~ 37N, 40N
#~ 102W, 94.5W
#~ - J values
#~ - Porosities
#~ - Dimensions water courses (depth and width)

lat_lon_line = "-d latitude,37.0,40.0 -d longitude,-102.0,-94.0"
latitutde_longitude_line = "-d latitude,37.0,40.0 -d longitude,-102.0,-94.0"

# ncea example
ncea -O -d latitude,-16.0,0.0 -d longitude,28.0,41.0 https://opendap.tudelft.nl/thredds/dodsC/data2/pcrglobwb/version_2019_11_beta/example_output/global_05min_gmd_paper_output/totalGroundwaterAbstraction_monthTot_output_1958-01-31_to_2015-12-31_zip.nc test.nc

