
set -x

MAIN_SOURCE_FOLDER="/scratch/depfg/sutan101/land_covers_global/version_2021-02-XX/links_to_simplify/"

MAIN_OUTPUT_FOLDER="/scratch/depfg/sutan101/land_covers_global/version_2021-02-XX/merged/"

# clean output folder
mkdir -p ${MAIN_OUTPUT_FOLDER}
rm ${MAIN_OUTPUT_FOLDER}/*


FILENAME="rfrac1_all.nc"
FILENAME=$1


CLONE_FILE="/scratch/depfg/sutan101/data/pcrglobwb_input_arise/develop/global_30sec/cloneMaps/global_30sec_clone_correct_lat.nc"


# make an initial map
TMP_OUT_FILENAME="tmp_out_"${FILENAME}
rm ${TMP_OUT_FILENAME}
cdo setctomiss,1 ${CLONE_FILE} ${MAIN_OUTPUT_FOLDER}/${TMP_OUT_FILENAME}


# loop for mergegrid

#~ for i in {1..16}

for i in {1..2}

do

SOURCE_FOLDER=${MAIN_SOURCE_FOLDER}/${i}

# using directly input file 
TMP_INP_FILENAME=${SOURCE_FOLDER}/${FILENAME}

# mergegrid
TMP_PRE_FILENAME="tmp_pre_"${FILENAME}
mv ${MAIN_OUTPUT_FOLDER}/${TMP_OUT_FILENAME} ${MAIN_OUTPUT_FOLDER}/${TMP_PRE_FILENAME}
cdo -L -mergegrid ${MAIN_OUTPUT_FOLDER}/${TMP_PRE_FILENAME} ${MAIN_OUTPUT_FOLDER}/${TMP_INP_FILENAME} ${MAIN_OUTPUT_FOLDER}/${TMP_OUT_FILENAME}

done

mv ${MAIN_OUTPUT_FOLDER}/${TMP_OUT_FILENAME} ${MAIN_OUTPUT_FOLDER}/merged_${FILENAME}

#~ rm ${TMP_OUT_FILENAME} 
#~ rm ${TMP_INP_FILENAME} 
#~ rm ${TMP_PRE_FILENAME} 

set +x
