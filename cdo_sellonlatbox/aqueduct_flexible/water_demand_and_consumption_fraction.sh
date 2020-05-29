
set -x 

OUT_FOLDER="/scratch-shared/edwinhs/pcr-globwb-aqueduct/maritsa/ret/"

LONLATBOX="22.0,30.0,40.0,45.0"
LONLATBOX=$2

cdo -L expr,"dom_ret_flow_frac = ( (domesticGrossDemand > 0.0) ? 1-(domesticNettoDemand/domesticGrossDemand) : 0.0)" domestic_water_demand_gmd_paper.nc domestic_return_flow_fraction_gmd_paper.nc 
ncview domestic_water_demand_gmd_paper.nc domestic_return_flow_fraction_gmd_paper.nc


set +x 
