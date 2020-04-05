
set -x

# domestic
OUTPUT_DIR=
mkdir -p {OUTPUT_DIR}
cd  
# - merging 
SOURCE_FILE=""
OUTPUT_WITHDRAWAL_FILE=""
cdo -L -mergetime 
# - calculate return flow
RETURN_FLOW_FRACTION_FILE=
OUTPUT_RETURN_FLOW_FILE=
cdo -L mul ${RETURN_FLOW_FRACTION_FILE} ${OUTPUT_WITHDRAWAL_FILE}
ncview 
