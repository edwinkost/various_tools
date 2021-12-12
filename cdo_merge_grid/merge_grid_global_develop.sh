
set -x

MAIN_SOURCE_FOLDER="/scratch/depfg/sutan101/land_covers_global/version_2021-02-XX/links_to_simplify/"

MAIN_OUTPUT_FOLDER="/scratch/depfg/sutan101/land_covers_global/version_2021-02-XX/merged/"

# clean output folder
mkdir -p ${MAIN_OUTPUT_FOLDER}
rm ${MAIN_OUTPUT_FOLDER}


FILENAME="rfrac1_all.nc"
FILENAME=$1


GRIDDES_FILE="/scratch/depfg/sutan101/data/pcrglobwb_input_arise/develop/global_30sec/cloneMaps/griddes_global_30sec_clone_correct_lat.nc.txt"


# cdo remapcon to the first file

SOURCE_FOLDER=${MAIN_SOURCE_FOLDER}/1

TMP_OUT_FILENAME="tmp_out_"${FILENAME}
rm ${TMP_OUT_FILENAME}
cdo remapcon,${GRIDDES_FILE} ${SOURCE_FOLDER}/${FILENAME} ${MAIN_OUTPUT_FOLDER}/${TMP_OUT_FILENAME}


# remapcon and mergegrid to the files 2 to 16

#~ for i in {2..16}

for i in {2..3}

do

SOURCE_FOLDER=${MAIN_SOURCE_FOLDER}/${i}

# remapcon 

TMP_INP_FILENAME="tmp_inp_"${FILENAME}
rm ${TMP_INP_FILENAME}
cdo remapcon,${GRIDDES_FILE} SOURCE_FOLDER/${FILENAME} ${MAIN_OUTPUT_FOLDER}/${TMP_INP_FILENAME}


# mergegrid
TMP_PRE_FILENAME="tmp_pre_"${FILENAME}
mv ${MAIN_OUTPUT_FOLDER}/${TMP_OUT_FILENAME} ${MAIN_OUTPUT_FOLDER}/${TMP_PRE_FILENAME}
cdo -L -mergegrid ${MAIN_OUTPUT_FOLDER}/${TMP_PRE_FILENAME} ${MAIN_OUTPUT_FOLDER}/${TMP_INP_FILENAME} ${MAIN_OUTPUT_FOLDER}/${TMP_OUT_FILENAME}

done

mv ${MAIN_OUTPUT_FOLDER}/${TMP_OUT_FILENAME} ${MAIN_OUTPUT_FOLDER}/merged_${FILENAME}

rm ${TMP_OUT_FILENAME} 
rm ${TMP_INP_FILENAME} 
rm ${TMP_PRE_FILENAME} 

set +x
