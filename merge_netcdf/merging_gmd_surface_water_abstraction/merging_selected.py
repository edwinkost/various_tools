#! /usr/bin/python

import os
import sys

main_folder = "/scratch-shared/edwinvua/pcrglobwb2_output_gmd_paper_rerun_201903XX_05min_using_consistent_pcraster/05min/non-natural/begin_from_1958/"
start_years = [1958] 
final_year = 2015

# ~ main_folder = sys.argv[1]
# ~ start_years = map(int, list(set(sys.argv[2].split(","))))
# ~ start_years.sort()
# ~ final_year  = int(sys.argv[3])

print(start_years)

outp_folder = "/scratch-shared/edwinhs/gmd_paper_output_additional/"
# ~ outp_folder = str(sys.argv[4])

#~ cmd = "rm -rf " + outp_folder
#~ print(cmd)
#~ os.system(cmd)
cmd = "mkdir -p " + outp_folder
print(cmd)
os.system(cmd)
cmd = "cp merge_netcdf.py " + outp_folder
print(cmd)
os.system(cmd)
os.chdir(outp_folder)

for i_year in range(0, len(start_years)):
    
    # - input sub folder
    inp_sub_folder = "begin_from_" + str(start_years[i_year]) 
    if i_year > 0: inp_sub_folder = "continue_from_" + str(start_years[i_year])
    
    input_folder = main_folder + "/" + inp_sub_folder + "/"
    
    sta_year = int(start_years[i_year])
    if i_year == (len(start_years)-1):
        end_year = final_year
    else:
        end_year = int(start_years[i_year+1]) - 1
    
    for year in range(sta_year, end_year + 1):
    
        #~ example: python merge_netcdf.py /projects/0/aqueduct/users/edwinsut/pcrglobwb_runs_2016_oct_nov/pcrglobwb_4_land_covers_edwin_parameter_set_watch_kinematicwave/no_correction/non-natural/begin_from_1958/ /scratch-shared/edwin/test_merging/ outAnnuaTotNC 1958-12-31 1958-12-31 desalinationAbstraction NETCDF4 True 1 Global


        #~ # list of files that will be merged
        #~ 
        #~ precipitation_monthTot_output.nc 
        #~ gwRecharge_monthTot_output.nc
        #~ totalGroundwaterAbstraction_monthTot_output.nc
        #~ totalRunoff_monthTot_output.nc
        #~ totalEvaporation_monthTot_output.nc
        
        #~ nonIrrGrossDemand_monthTot_output.nc
        #~ irrGrossDemand_monthTot_output.nc
        #~ 
        #~ domesticWaterWithdrawal_monthTot_output.nc
        #~ industryWaterWithdrawal_monthTot_output.nc
        #~ irrNonPaddyWaterWithdrawal_monthTot_output.nc
        #~ irrPaddyWaterWithdrawal_monthTot_output.nc
        #~ 
        #~ evaporation_from_irrigation_annuaTot_output.nc
        #~ precipitation_at_irrigation_annuaTot_output.nc
        #~ irrigationWaterWithdrawal_annuaTot_output.nc
        #~ 
        #~ discharge_monthAvg_output.nc
        #~ channelStorage_monthAvg_output.nc
        #~ 
        #~ temperature_annuaAvg_output.nc

        # ~ # annual average
        # ~ cmd = "python merge_netcdf.py " + \
              # ~ input_folder + " " + \
              # ~ outp_folder + " " + \
              # ~ "outAnnuaAvgNC " + \
              # ~ str(year)+"-12-31" + " " + str(year)+"-12-31" + " " + \
              # ~ "temperature NETCDF4 True 5 Global"
        # ~ print(cmd)
        # ~ os.system(cmd)

        # monthly total
        cmd = "python merge_netcdf.py " + \
              input_folder + " " + \
              outp_folder + " " + \
              "outMonthTotNC " + \
              str(year)+"-01-31" + " " + str(year)+"-12-31" + " " + \
              "surfaceWaterAbstraction NETCDF4 True 5 Global"
              # ~ "irrGrossDemand,domesticWaterWithdrawal,industryWaterWithdrawal,irrPaddyWaterWithdrawal,nonIrrGrossDemand,desalinationAbstraction,surfaceWaterAbstraction NETCDF4 True 5 Global"
              # ~ "irrGrossDemand,domesticWaterWithdrawal,industryWaterWithdrawal,irrPaddyWaterWithdrawal,gwRecharge,totalGroundwaterAbstraction,precipitation,totalRunoff,totalEvaporation,nonIrrGrossDemand NETCDF4 True 5 Global"
        print(cmd)
        os.system(cmd)

        # ~ # already available
        # ~ -rw-r--r-- 1 edwinvua edwinvua  80M Nov 25 13:16 baseflow_monthTot_output_1958-01-31_to_1958-12-31.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  11M Nov 25 13:15 fossilGroundwaterAbstraction_monthTot_output_1958-01-31_to_1958-12-31.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  81M Nov 25 13:16 gwRecharge_monthTot_output_1958-01-31_to_1958-12-31.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 9.9M Nov 25 13:14 precipitation_monthTot_output_1958-01-31_to_1958-12-31.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 8.7M Nov 25 13:11 referencePotET_monthTot_output_1958-01-31_to_1958-12-31.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  79M Nov 25 13:11 runoff_monthTot_output_1958-01-31_to_1958-12-31.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  12M Nov 25 13:21 surfaceWaterInf_monthTot_output_1958-01-31_to_1958-12-31.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  74M Nov 25 13:18 totLandSurfaceActuaET_monthTot_output_1958-01-31_to_1958-12-31.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  76M Nov 25 13:09 totalEvaporation_monthTot_output_1958-01-31_to_1958-12-31.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  38M Nov 25 13:18 totalGroundwaterAbstraction_monthTot_output_1958-01-31_to_1958-12-31.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  71M Nov 25 13:15 totalLandSurfacePotET_monthTot_output_1958-01-31_to_1958-12-31.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  73M Nov 25 13:21 totalPotentialEvaporation_monthTot_output_1958-01-31_to_1958-12-31.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  79M Nov 25 13:14 totalRunoff_monthTot_output_1958-01-31_to_1958-12-31.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  78M Nov 25 13:10 waterBodyActEvaporation_monthTot_output_1958-01-31_to_1958-12-31.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  82M Nov 25 13:18 waterBodyPotEvaporation_monthTot_output_1958-01-31_to_1958-12-31.nc

        # ~ # from subdomain runs
        # ~ 52/netcdf$ ls -lah *monthTot*
        # ~ -rw-r--r-- 1 edwinvua edwinvua 143M Nov 25 14:11 actualET_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 164M Nov 25 14:11 baseflow_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 7.4M Nov 25 14:11 desalinationAbstraction_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 115M Nov 25 14:11 directRunoff_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  31M Nov 25 14:11 domesticWaterWithdrawal_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  16M Nov 25 14:11 fossilGroundwaterAbstraction_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 162M Nov 25 14:11 gwRecharge_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  20M Nov 25 14:11 industryWaterWithdrawal_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 155M Nov 25 14:11 interflowTotal_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  19M Nov 25 14:11 irrGrossDemand_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  16M Nov 25 14:11 irrNonPaddyWaterWithdrawal_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  12M Nov 25 14:11 irrPaddyWaterWithdrawal_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  36M Nov 25 14:11 livestockWaterWithdrawal_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  56M Nov 25 14:11 nonFossilGroundwaterAbstraction_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  33M Nov 25 14:11 nonIrrGrossDemand_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 6.8M Nov 25 14:11 nonIrrReturnFlow_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  33M Nov 25 14:11 nonIrrWaterConsumption_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  17M Nov 25 14:11 precipitation_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  15M Nov 25 14:11 referencePotET_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 162M Nov 25 14:11 runoff_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 158M Nov 25 14:11 surfaceWaterAbstraction_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  14M Nov 25 14:11 surfaceWaterInf_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 143M Nov 25 14:11 totLandSurfaceActuaET_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 147M Nov 25 14:11 totalEvaporation_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  36M Nov 25 14:11 totalGrossDemand_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua  56M Nov 25 14:11 totalGroundwaterAbstraction_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 121M Nov 25 14:11 totalLandSurfacePotET_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 139M Nov 25 14:11 totalPotentialEvaporation_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 161M Nov 25 14:11 totalRunoff_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 166M Nov 25 14:11 waterBodyActEvaporation_monthTot_output.nc
        # ~ -rw-r--r-- 1 edwinvua edwinvua 165M Nov 25 14:11 waterBodyPotEvaporation_monthTot_output.nc

        # ~ # annual total
        # ~ cmd = "python merge_netcdf.py " + \
              # ~ input_folder + " " + \
              # ~ outp_folder + " " + \
              # ~ "outAnnuaTotNC " + \
              # ~ str(year)+"-12-31" + " " + str(year)+"-12-31" + " " + \
              # ~ "evaporation_from_irrigation,precipitation_at_irrigation,irrigationWaterWithdrawal NETCDF4 True 5 Global"
        # ~ print(cmd)
        # ~ os.system(cmd)

        # ~ # monthly average
        # ~ cmd = "python merge_netcdf.py " + \
              # ~ input_folder + " " + \
              # ~ outp_folder + " " + \
              # ~ "outMonthAvgNC " + \
              # ~ str(year)+"-01-31" + " " + str(year)+"-12-31" + " " + \
              # ~ "discharge,channelStorage NETCDF4 True 5 Global"
        # ~ print(cmd)
        # ~ os.system(cmd)
