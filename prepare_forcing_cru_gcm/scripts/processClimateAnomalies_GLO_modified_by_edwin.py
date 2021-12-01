import os, sys

#-processing of climate anomalies
# multiplicative anomalies are used for precip and reference potential evapotranspiration, additional one for temperature
# read in the reference climate and the generated climate forcing of the model; using this, compute the anomaly

def main():
	
	#-INITIALIZATION

	# climate variables
	climateVariables= {'temperature': 'sub',\
		               'precipitation': 'div',\
		               'referencePotET': 'div'}

	# GCM and rcp names
	gcmNames = ["GFDL-ESM2M",
                "HadGEM2-ES",
                "IPSL-CM5A-LR",
                "MIROC-ESM-CHEM",
                "NorESM1-M"
                ]
	rcpNames = ['2p6', '4p5', '6p0', '8p5'] 


	# GCM file names:
    # - examples: 
	#~ -rwxr-xr-- 1 hydrowld dfguu 34G Oct  7  2016 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/GFDL-ESM2M/epot_bced_1960_1999_gfdl-esm2m_2p6_2006-2099.nc
	#~ -rwxr-xr-- 1 hydrowld dfguu 34G Oct  6  2016 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/epot_bced_1960_1999_hadgem2-es_2p6_2006-2099.nc
	#~ -rwxr-xr-- 1 hydrowld dfguu 34G Oct  6  2016 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/IPSL-CM5A-LR/epot_bced_1960_1999_ipsl-cm5a-lr_2p6_2006-2099.nc
	#~ -rwxr-xr-- 1 hydrowld dfguu 34G Oct  6  2016 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/MIROC-ESM-CHEM/epot_bced_1960_1999_miroc-esm-chem_2p6_2006-2099.nc
	#~ -rwxr-xr-- 1 hydrowld dfguu 34G Oct  6  2016 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/NorESM1-M/epot_bced_1960_1999_noresm1-m_2p6_2006-2099.nc

	gcmFileRoot= {\
		'precipitation':  '/projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/%s/pr_bced_1960-1999_%s_%s_2006-2099.nc',\
		'temperature':    '/projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/%s/tas_bced_1960-1999_%s_%s_2006-2099.nc',\
		'referencePotET': '/projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/%s/epot_bced_1960_1999_%s_%s_2006-2099.nc'}
	
	# reference climate
	referenceClimateFiles = {\
		'precipitation':  '/projects/0/dfguu/data/hydroworld/forcing/ERA20C/CRU-TS3.23_ERA20C_daily_precipitation_1901_to_2010.nc',\
		'temperature':    '/projects/0/dfguu/data/hydroworld/forcing/ERA20C/CRU-TS3.23_ERA20C_daily_temperature_1901_to_2010.nc',\
		'referencePotET': '/projects/0/dfguu/data/hydroworld/forcing/ERA20C/CRU-TS3.23_ERA20C_daily_referencePotET_1901_to_2010.nc'}
	
	# forcing climate (BACKGROUND)  
	forcingClimateFiles = {\
		'precipitation':  '/projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_precipitation_2011_to_2100.nc',\
		'temperature':    '/projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_temperature_2011_to_2100.nc',\
		'referencePotET': '/projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_referencePotET_2011_to_2100.nc'}
    #
    # TODO, make the backgound files within the script, see e.g. the following history from the precipitation file. 
	#~ CDI: Climate Data Interface version 1.6.0 (http://code.zmaw.de/projects/cdi)
	#~ Conventions: CF-1.4
	#~ history: Mon Jan 02 10:51:39 2017: cdo seldate,2011-01-01,2100-12-31 temp_precipitation.nc CRU-TS3.23_ERA20C_GLO_daily_precipitation_2011_to_2100.nc
	#~ Mon Jan 02 10:48:12 2017: cdo -O mergetime temp_precipitation_0.nc temp_precipitation_1.nc temp_precipitation_2.nc temp_precipitation_3.nc temp_precipitation.nc
	#~ Mon Jan 02 10:46:27 2017: cdo shifttime,+100years temp_precipitation.nc temp_precipitation_3.nc
	#~ Mon Jan 02 10:45:36 2017: cdo seldate,1986-01-01,2010-12-31 /projects/0/dfguu/data/hydroworld/forcing/ERA20C/CRU-TS3.23_ERA20C_daily_precipitation_1901_to_2010.nc temp_precipitation.nc


	print ('\n Cleaning previous sh files. \n')
	cmd = 'rm -rf *.sh' 
	os.system(cmd) 


	# START
	for gcmName in gcmNames:

		print ('\n * processing %s' % gcmName)

		for rcpName in rcpNames:

			print ('\n * processing %s' % rcpName)

			for climateVariable, anoType in climateVariables.iteritems():

				print ('\n * processing %s' % climateVariable).upper()
				
				# reverse (anomaly type)
				if anoType == 'sub':
					reverseAnoType= 'add'
				elif anoType == 'div':
					reverseAnoType= 'mul'
				
				# the script file for the current variable, gcm and rcp
				processTxtFile= open('process_%s_%s_%s.sh' % (climateVariable, gcmName, rcpName), 'w')
	
				commandStr= 'set -x \n'
				processTxtFile.write(commandStr)

       		    # preparing output directory
				output_folder = "/scratch-shared/edwinhs/forcing_ISI-MIP_CRU-TS3.23_ERA20C/" + "rcp" + rcpName + "/" + gcmName + "/" + climateVariable + "/"
				# - remove all existing files if exists
				commandStr= 'rm -rf ' + output_folder + "/* \n"
				processTxtFile.write(commandStr)
				# - making the output folder
				commandStr= 'mkdir -p %s \n' % output_folder
				processTxtFile.write(commandStr)

				# go to the output folder
				commandStr= 'cd %s \n' % output_folder
				processTxtFile.write(commandStr)

				# get average from reference and forcing
				forcingFileName = forcingClimateFiles[climateVariable]
				gcmForcingFileName  = os.path.basename(forcingFileName)
				gcmForcingFileName  = os.path.splitext(gcmForcingFileName)[0]
				gcmForcingFileName  = output_folder + "/" + gcmForcingFileName				
				gcmForcingFileName += '_%s_rcp%s.nc' % (gcmName, rcpName)
				
				print ' - converting %s to %s' % (forcingFileName, gcmForcingFileName)
				commandStr= 'cdo -L -f nc4 -ymonmean -seldate,1961-01-01,1990-12-31 %s %s_reference.nc \n' % (referenceClimateFiles[climateVariable], climateVariable)
				processTxtFile.write(commandStr)
				commandStr= 'cdo -L -f nc4 -ymonmean %s %s_forcing.nc \n' %  (forcingFileName, climateVariable)
				processTxtFile.write(commandStr)
				commandStr= 'cdo -L -f nc4 -%s %s_reference.nc %s_forcing.nc %s_%s.nc \n' % \
					(anoType, climateVariable, climateVariable, climateVariable, anoType)
				processTxtFile.write(commandStr)

				# remove large values for division
				if anoType == 'div':
					commandStr= 'cdo -L -f nc4 -mul -lec,100 %s_div.nc %s_div.nc temp.nc\n' % (climateVariable, climateVariable)
					processTxtFile.write(commandStr)
					commandStr= 'cdo -L -f nc4 -add -mulc,100 -gtc,100 %s_div.nc temp.nc temp2.nc\n'  % climateVariable
					processTxtFile.write(commandStr)
					commandStr= 'cdo -L -f nc4 -setmisstoc,0 temp2.nc %s_div.nc\n' % climateVariable
					processTxtFile.write(commandStr)
					commandStr= 'rm temp.nc\n'
					processTxtFile.write(commandStr)			
					commandStr= 'rm temp2.nc\n'
					processTxtFile.write(commandStr)


				# process data from GCM
				gcmFileName= gcmFileRoot[climateVariable] % (gcmName, gcmName.lower(), rcpName)
				if climateVariable == 'referencePotET': 
					gcmHistoricalFileName= gcmFileName.replace(rcpName, 'hist')
				else:
					gcmHistoricalFileName= gcmFileName.replace(rcpName, 'historical')
				gcmHistoricalFileName= 	gcmHistoricalFileName.replace('2006-2099', '1951-2005')

				# historical reference
				commandStr= 'cdo -L -f nc4 -ymonmean -seldate,1961-01-01,1990-12-31 %s %s_gcm_reference.nc \n' %\
					(gcmHistoricalFileName, climateVariable)
				processTxtFile.write(commandStr)
				
				#-timeseries
				#-extract monthly values
				
				#-values should be averaged over the months because of historical period which is averaged
				#~ if anoType == 'div':
					#~ commandStr= 'cdo monsum'
				#~ else:
					#~ commandStr= 'cdo monmean'
				commandStr= 'cdo -L -f nc4 -monmean'
				commandStr+= ' %s temp.nc\n' % gcmFileName
				processTxtFile.write(commandStr)
				
				commandStr= 'cdo -L -f nc4 -seldate,2090-01-01,2099-12-31 temp.nc temp2.nc\n'
				processTxtFile.write(commandStr)
				commandStr= 'cdo -L -f nc4 -shifttime,+10years temp2.nc temp3.nc\n'
				processTxtFile.write(commandStr)
				commandStr= 'cdo -L -f nc4 -mergetime temp.nc temp3.nc %s_gcm_tss.nc\n' % climateVariable
				processTxtFile.write(commandStr)
				commandStr= 'rm temp.nc\nrm temp2.nc\nrm temp3.nc\n'
				processTxtFile.write(commandStr)
				
				# iterate over all months, select and take running average
				removeStr= ''
				mergeStr= ''
				for month in xrange(1,13):
					print '   processing %d' % month
					commandStr= 'cdo -L -f nc4 -selmon,%d %s_gcm_tss.nc temp%02d.nc\n' % (month, climateVariable, month)
					processTxtFile.write(commandStr)
					commandStr= 'cdo -L -f nc4 -runmean,11 temp%02d.nc temp_run_%02d.nc\n' % (month, month)
					processTxtFile.write(commandStr)
					commandStr= 'cdo -L -f nc4 -seldate,2011-01-01,2100-12-31 temp_run_%02d.nc temp_run2_%02d.nc\n' % (month, month)
					processTxtFile.write(commandStr)
					removeStr+= ' temp%02d.nc temp_run_%02d.nc temp_run2_%02d.nc' % (month, month, month)
					mergeStr+= ' temp_run2_%02d.nc' % month
				
				# remove str
				commandStr= 'cdo -L -f nc4 -mergetime %s %s_run_tss.nc\n' % (mergeStr, climateVariable)
				processTxtFile.write(commandStr)
				commandStr= 'rm %s\n' % removeStr
				processTxtFile.write(commandStr)
				
				# get anomaly
				commandStr= 'cdo -L -f nc4 -ymon%s %s_run_tss.nc %s_gcm_reference.nc %s_gcm_ano.nc\n' %\
					(anoType, climateVariable, climateVariable, climateVariable)
				processTxtFile.write(commandStr)
				#-patch ratio	
				if anoType == 'div':
					commandStr= 'cdo -L -f nc4 -mul -lec,100 %s_gcm_ano.nc %s_gcm_ano.nc temp.nc\n' % (climateVariable, climateVariable)
					processTxtFile.write(commandStr)
					commandStr= 'cdo -L -f nc4 -add -mulc,100 -gtc,100 %s_gcm_ano.nc temp.nc temp2.nc\n'  % climateVariable
					processTxtFile.write(commandStr)
					commandStr= 'cdo -L -f nc4 -setmisstoc,0 temp2.nc %s_gcm_ano.nc\n' % climateVariable
					processTxtFile.write(commandStr)
					commandStr= 'rm temp.nc\n'
					processTxtFile.write(commandStr)			
					commandStr= 'rm temp2.nc\n'
					processTxtFile.write(commandStr)
				#-correct for ref climate
				commandStr= 'cdo -L -f nc4 -ymon%s %s_gcm_ano.nc %s_%s.nc %s_ano.nc\n' %\
					(reverseAnoType, climateVariable, climateVariable, anoType, climateVariable)
				processTxtFile.write(commandStr)			
				#-apply anomaly
				print '   applying anomaly'
				commandStr= 'cdo -L -f nc4 -mon%s %s %s_ano.nc %s\n' %\
					(reverseAnoType, forcingFileName, climateVariable, gcmForcingFileName)
				processTxtFile.write(commandStr)
				#-create global anomaly
				commandStr= 'cdo -L -f nc4 -gridweights %s_gcm_ano.nc temp_cellweights.nc\n' % (climateVariable)
				processTxtFile.write(commandStr)			
				commandStr= 'cdo -L -f nc4 -fldmean -mul temp_cellweights.nc %s_gcm_ano.nc %s_gcm_global_ano.nc\n' % (climateVariable, climateVariable) 
				processTxtFile.write(commandStr)			
				#-remove intermediate files
				commandStr= 'rm -f temp_cellweights.nc %s_ano.nc %s_gcm_ano.nc %s_gcm_tss.nc %s_run_tss.nc %s_forcing.nc %s_gcm_reference.nc %s_reference.nc %s_sub.nc\n' %\
					(climateVariable,climateVariable,climateVariable,climateVariable,climateVariable,climateVariable,climateVariable,climateVariable)
				processTxtFile.write(commandStr)			
				#-close file
				processTxtFile.close()


if __name__ == "__main__":
	main()
	print 'done!'
