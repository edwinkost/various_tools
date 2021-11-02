import os, sys

#-processing of climate anomalies
# multiplicative anomalies are used for precip and reference potential evapotranspiration, additional one for temperature
# read in the reference climate and the generated climate forcing of the model; using this, compute the anomaly

def main():
	
	#-INITIALIZATION
	#-climate variables
	climateVariables= {'temperature': 'sub',\
		'precipitation': 'div',\
		'referencePotET': 'div'}
	#-GCM names and file roots
	gcmNames= ['2p6', '4p5', '6p0'] 
	gcmFileRoot= {\
		'precipitation':  '/projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/pr_bced_1960-1999_hadgem2-es_%s_2006-2099.nc',\
		'temperature':    '/projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/tas_bced_1960-1999_hadgem2-es_%s_2006-2099.nc',\
		'referencePotET': '/projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/epot_bced_1960_1999_hadgem2-es_%s_2006-2099.nc'}
	
	#-forcing and reference climate
	forcingClimateFiles= {\
		'precipitation':  '/projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_precipitation_2011_to_2100.nc',\
		'temperature':    '/projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_temperature_2011_to_2100.nc',\
		'referencePotET': '/projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_referencePotET_2011_to_2100.nc'}
	referenceClimateFiles= {\
		'precipitation':  '/projects/0/dfguu/data/hydroworld/forcing/ERA20C/CRU-TS3.23_ERA20C_daily_precipitation_1901_to_2010.nc',\
		'temperature':    '/projects/0/dfguu/data/hydroworld/forcing/ERA20C/CRU-TS3.23_ERA20C_daily_temperature_1901_to_2010.nc',\
		'referencePotET': '/projects/0/dfguu/data/hydroworld/forcing/ERA20C/CRU-TS3.23_ERA20C_daily_referencePotET_1901_to_2010.nc'}

	#-START	
	for gcmName in gcmNames:
		for climateVariable, anoType in climateVariables.iteritems():
			#-echo to screen
			print ('\n * processing %s' % climateVariable).upper()
			
			#-reverse
			if anoType == 'sub':
				reverseAnoType= 'add'
			elif anoType == 'div':
				reverseAnoType= 'mul'
			
			#-file for current variable
			processTxtFile= open('process_%s_%s.sh' % (climateVariable, gcmName), 'w')

			#-get average from reference and forcing
			forcingFileName= forcingClimateFiles[climateVariable]
			gcmForcingFileName= os.path.splitext(forcingFileName)[0]
			gcmForcingFileName+= '_rcp%s.nc' % gcmName
			print ' - converting %s to %s' % (forcingFileName, gcmForcingFileName)
			commandStr= 'cdo ymonmean -seldate,1961-01-01,1990-12-31 %s %s_reference.nc \n' % (referenceClimateFiles[climateVariable], climateVariable)
			processTxtFile.write(commandStr)
			commandStr= 'cdo ymonmean %s %s_forcing.nc \n' %  (forcingFileName, climateVariable)
			processTxtFile.write(commandStr)
			commandStr= 'cdo %s %s_reference.nc %s_forcing.nc %s_%s.nc \n' % \
				(anoType, climateVariable, climateVariable, climateVariable, anoType)
			processTxtFile.write(commandStr)
			#-remove large values for division
			if anoType == 'div':
				commandStr= 'cdo mul -lec,100 %s_div.nc %s_div.nc temp.nc\n' % (climateVariable, climateVariable)
				processTxtFile.write(commandStr)
				commandStr= 'cdo add -mulc,100 -gtc,100 %s_div.nc temp.nc temp2.nc\n'  % climateVariable
				processTxtFile.write(commandStr)
				commandStr= 'cdo setmisstoc,0 temp2.nc %s_div.nc\n' % climateVariable
				processTxtFile.write(commandStr)
				commandStr= 'rm temp.nc\n'
				processTxtFile.write(commandStr)			
				commandStr= 'rm temp2.nc\n'
				processTxtFile.write(commandStr)
			#-process data from GCM
			gcmFileName= gcmFileRoot[climateVariable] % gcmName
			if climateVariable == 'referencePotET': 
				gcmHistoricalFileName= gcmFileName.replace(gcmName, 'hist')
			else:
				gcmHistoricalFileName= gcmFileName.replace(gcmName, 'historical')
			gcmHistoricalFileName= 	gcmHistoricalFileName.replace('2006-2099', '1951-2005')
			#-historical reference
			commandStr= 'cdo ymonmean -seldate,1961-01-01,1990-12-31 %s %s_gcm_reference.nc \n' %\
				(gcmHistoricalFileName, climateVariable)
			processTxtFile.write(commandStr)
			#-timeseries
			#-extract monthly values
			#-values should be averaged over the months because of historical period which is averaged
			#~ if anoType == 'div':
				#~ commandStr= 'cdo monsum'
			#~ else:
				#~ commandStr= 'cdo monmean'
			commandStr= 'cdo monmean'
			commandStr+= ' %s temp.nc\n' % gcmFileName
			processTxtFile.write(commandStr)
			commandStr= 'cdo seldate,2090-01-01,2099-12-31 temp.nc temp2.nc\n'
			processTxtFile.write(commandStr)
			commandStr= 'cdo shifttime,+10years temp2.nc temp3.nc\n'
			processTxtFile.write(commandStr)
			commandStr= 'cdo mergetime temp.nc temp3.nc %s_gcm_tss.nc\n' % climateVariable
			processTxtFile.write(commandStr)
			commandStr= 'rm temp.nc\nrm temp2.nc\nrm temp3.nc\n'
			processTxtFile.write(commandStr)
			#-iterate over all months, select and take running average
			removeStr= ''
			mergeStr= ''
			for month in xrange(1,13):
				print '   processing %d' % month
				commandStr= 'cdo selmon,%d %s_gcm_tss.nc temp%02d.nc\n' % (month, climateVariable, month)
				processTxtFile.write(commandStr)
				commandStr= 'cdo runmean,11 temp%02d.nc temp_run_%02d.nc\n' % (month, month)
				processTxtFile.write(commandStr)
				commandStr= 'cdo seldate,2011-01-01,2100-12-31 temp_run_%02d.nc temp_run2_%02d.nc\n' % (month, month)
				processTxtFile.write(commandStr)
				removeStr+= ' temp%02d.nc temp_run_%02d.nc temp_run2_%02d.nc' % (month, month, month)
				mergeStr+= ' temp_run2_%02d.nc' % month
			#-remove str
			commandStr= 'cdo mergetime %s %s_run_tss.nc\n' % (mergeStr, climateVariable)
			processTxtFile.write(commandStr)
			commandStr= 'rm %s\n' % removeStr
			processTxtFile.write(commandStr)
			#-get anomaly
			commandStr= 'cdo ymon%s %s_run_tss.nc %s_gcm_reference.nc %s_gcm_ano.nc\n' %\
				(anoType, climateVariable, climateVariable, climateVariable)
			processTxtFile.write(commandStr)
			#-patch ratio	
			if anoType == 'div':
				commandStr= 'cdo mul -lec,100 %s_gcm_ano.nc %s_gcm_ano.nc temp.nc\n' % (climateVariable, climateVariable)
				processTxtFile.write(commandStr)
				commandStr= 'cdo add -mulc,100 -gtc,100 %s_gcm_ano.nc temp.nc temp2.nc\n'  % climateVariable
				processTxtFile.write(commandStr)
				commandStr= 'cdo setmisstoc,0 temp2.nc %s_gcm_ano.nc\n' % climateVariable
				processTxtFile.write(commandStr)
				commandStr= 'rm temp.nc\n'
				processTxtFile.write(commandStr)			
				commandStr= 'rm temp2.nc\n'
				processTxtFile.write(commandStr)
			#-correct for ref climate
			commandStr= 'cdo ymon%s %s_gcm_ano.nc %s_%s.nc %s_ano.nc\n' %\
				(reverseAnoType, climateVariable, climateVariable, anoType, climateVariable)
			processTxtFile.write(commandStr)			
			#-apply anomaly
			print '   applying anomaly'
			commandStr= 'cdo mon%s %s %s_ano.nc %s\n' %\
				(reverseAnoType, forcingFileName, climateVariable, gcmForcingFileName)
			processTxtFile.write(commandStr)
			#-create global anomaly
			commandStr= 'cdo gridweights %s_gcm_ano.nc temp_cellweights.nc\n' % (climateVariable)
			processTxtFile.write(commandStr)			
			commandStr= 'cdo fldmean -mul temp_cellweights.nc %s_gcm_ano.nc %s_gcm_global_ano.nc\n' % (climateVariable, climateVariable) 
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
