
baseflow_monthTot_output_2099-01-31_to_2099-12-31.nc
channelStorage_monthAvg_output_2099-01-31_to_2099-12-31.nc
channelStorage_monthMax_output_2099-01-31_to_2099-12-31.nc
discharge_monthAvg_output_2099-01-31_to_2099-12-31.nc
discharge_monthMax_output_2099-01-31_to_2099-12-31.nc
dynamicFracWat_monthMax_output_2099-01-31_to_2099-12-31.nc
floodDepth_monthMax_output_2099-01-31_to_2099-12-31.nc
floodVolume_monthMax_output_2099-01-31_to_2099-12-31.nc
gwRecharge_monthTot_output_2099-01-31_to_2099-12-31.nc
runoff_monthTot_output_2099-01-31_to_2099-12-31.nc
storGroundwater_monthAvg_output_2099-01-31_to_2099-12-31.nc
storUppTotal_monthAvg_output_2099-01-31_to_2099-12-31.nc
storLowTotal_monthAvg_output_2099-01-31_to_2099-12-31.nc
totLandSurfaceActuaET_monthTot_output_2099-01-31_to_2099-12-31.nc
totalEvaporation_monthTot_output_2099-01-31_to_2099-12-31.nc
totalLandSurfacePotET_monthTot_output_2099-01-31_to_2099-12-31.nc
totalPotentialEvaporation_monthTot_output_2099-01-31_to_2099-12-31.nc
totalRunoff_monthMax_output_2099-01-31_to_2099-12-31.nc
totalRunoff_monthTot_output_2099-01-31_to_2099-12-31.nc
totalWaterStorageThickness_monthAvg_output_2099-01-31_to_2099-12-31.nc
waterBodyActEvaporation_monthTot_output_2099-01-31_to_2099-12-31.nc
waterBodyPotEvaporation_monthTot_output_2099-01-31_to_2099-12-31.nc

totLandSurfaceActuaET
totalEvaporation
totalLandSurfacePotET
totalPotentialEvaporation
totalRunoff
totalWaterStorageThickness
waterBodyActEvaporation
waterBodyPotEvaporation





7za e \
'-ir!*baseflow*' \
'-ir!*channelStorage*' \
'-ir!*discharge*' \ 
'-ir!*dynamicFracWat*' \ 
'-ir!*flood*' \
'-ir!*gwRecharge*' \
'-ir!*runoff*' \
'-ir!*storGroundwater*' \
'-ir!*storUpp*' \
'-ir!*storLow*' \
'-ir!*totLandSurfaceActuaET*' \
'-ir!*totalEvaporation*' \
'-ir!*totalLandSurfacePotET*' \
'-ir!*totalPotentialEvaporation*' \
'-ir!*totalRunoff*' \
'-ir!*totalWaterStorageThickness*' \
'-ir!*aterBodyActEvaporation*' \
'-ir!*waterBodyPotEvaporation*' \
../NorESM1-M_rcp85_Nat_KW_*_netcdf.tar 

7za e '-ir!*baseflow*' '-ir!*channelStorage*' '-ir!*discharge*' '-ir!*dynamicFracWat*' '-ir!*flood*' '-ir!*gwRecharge*' '-ir!*runoff*' '-ir!*storGroundwater*' '-ir!*storUpp*' '-ir!*storLow*' '-ir!*totLandSurfaceActuaET*' '-ir!*totalEvaporation*' '-ir!*totalLandSurfacePotET*' '-ir!*totalPotentialEvaporation*' '-ir!*totalRunoff*' '-ir!*totalWaterStorageThickness*' '-ir!*aterBodyActEvaporation*' '-ir!*waterBodyPotEvaporation*' ../NorESM1-M_rcp85_Nat_KW_*_netcdf.tar .

