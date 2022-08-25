#-extracts data from CRU TS21 output and creates netCDF files from it and creates monthly and annual totals

import os, datetime, calendar, tarfile, zipfile, zlib, sys
import numpy as np
import netCDF4 as nc
import PCRaster as pcr
from PCRaster.Framework import generateNameT
from PCRaster.NumPy import pcr2numpy, numpy2pcr
from pcrBasicFunctions import createOutputDirs

def extractDailyData(arcPath,arcFile,varPath,varList,leapYear):
	#-extracts daily data from tar file
	nDays= 365
	if leapYear: nDays= nDays+1
	arcList= []
	for var in varList:
		for day in range(1,nDays+1):
			arcList.append(generateNameT(var,day))
	archive= tarfile.open(os.path.join(arcPath,arcFile),'r:gz')
	for tarInfo in archive:
			if tarInfo.name in arcList:
				archive.extract(tarInfo,varPath)
	archive.close()

def getCoordinates(cloneMap,MV= -9999):
	#-returns coordinates for a clone map
	xMap= pcr.xcoordinate(cloneMap)
	yMap= pcr.ycoordinate(cloneMap)
	return pcr2numpy(xMap,MV)[1,:],pcr2numpy(yMap,MV)[:,1]

def createNetCDF(ncFile,longitudes,latitudes,attributes= {}):
	#-creates a netCDF file, including its projection attributes.
	#-open nc dataset
	rootgrp= nc.Dataset(ncFile,'w',format= 'NETCDF3_CLASSIC')
	#-create dimensions - time is unlimited, others are fixed
	rootgrp.createDimension('time',0)
	rootgrp.createDimension('latitude',len(latitudes))
	rootgrp.createDimension('longitude',len(longitudes))
	#-create variables
	date_time= rootgrp.createVariable('time','f8',('time',))
	date_time.standard_name= 'time'
	date_time.long_name= 'Hours since 1901-01-01 00:00:00.0'
	date_time.units= 'Hours since 1901-01-01 00:00:00.0'
	date_time.calendar= 'gregorian'
	lat= rootgrp.createVariable('latitude','f4',('latitude'))
	lat.standard_name= 'Latitude'
	lat.long_name= 'Latitude cell centres'
	lon= rootgrp.createVariable('longitude','f4',('longitude'))
	lon.standard_name= 'Longitude'
	lon.long_name= 'Longitude cell centres'
	#-assing latitudes and longitudes to variables
	lat[:]= latitudes
	lon[:]= longitudes  
	#-set attributes
	for attribute,value in attributes.iteritems():
		setattr(rootgrp,attribute,value) 
	#-write to file
	rootgrp.sync()
	rootgrp.close()

def data2NetCDF(ncFile,variableName,variableAttributes,variableArray,timeStamp,posCnt,MV= -999.9,compress= True):
	#-default variable format and structure
	varFormat= 'f4'
	varStructure= ('time','latitude','longitude')  
	#-open file to append information
	rootgrp= nc.Dataset(ncFile,'a')
	#-check if variable is already mapped, if not create
	try:
		mappedVariables= rootgrp.variables
	except:
		mappedVariables= {}
	if variableName not in mappedVariables:
		mappedVariables[variableName]= rootgrp.createVariable(variableName,varFormat,varStructure,fill_value= MV,zlib=compress)
		mappedVariables[variableName].standard_name= variableName
		for attribute,value in variableAttributes.iteritems():
			if attribute == 'long_name' and len(value) == 0:
				value= variableName
			if attribute != 'filename' and attribute != 'interval':
				setattr(mappedVariables[variableName],attribute,value) 
	#-initialize time and posCnt
	# then write timeStamp and variable
	date_time= rootgrp.variables['time']
	date_time[posCnt]= nc.date2num(timeStamp,\
			date_time.units,date_time.calendar)
	rootgrp.variables[variableName][posCnt,:,:]= variableArray
	#-update file and close 
	rootgrp.sync()
	rootgrp.close()

def timeseries2NetCDF(ncFile,variableName,variableAttributes,resultsDir,pcrVariableName,startDay,startDate,endDate,
		posCnt,MV= -999.9,compress= True):
	#-default variable format and structure
	varFormat= 'f4'
	varStructure= ('time','latitude','longitude')  
	#-open file to append information
	rootgrp= nc.Dataset(ncFile,'a')
	#-check if variable is already mapped, if not create
	try:
		mappedVariables= rootgrp.variables
	except:
		mappedVariables= {}
	if variableName not in mappedVariables:
		mappedVariables[variableName]= rootgrp.createVariable(variableName,varFormat,varStructure,fill_value= MV,zlib=compress)
		mappedVariables[variableName].standard_name= variableName
		for attribute,value in variableAttributes.iteritems():
			if attribute == 'long_name' and len(value) == 0:
				value= variableName
			if attribute != 'filename' and attribute != 'interval':
				setattr(mappedVariables[variableName],attribute,value) 
	#-initialize time and posCnt
	# then write timeStamp and variable
	date_time= rootgrp.variables['time']
	day= startDay
	for dayCnt in xrange(startDate.toordinal(),endDate.toordinal()):
		sourceFileName= os.path.join(resultsDir,generateNameT(pcrVariableName,day))
		if os.path.isfile(sourceFileName):
			try:
				date_time[posCnt]= nc.date2num(datetime.datetime.fromordinal(dayCnt),\
						date_time.units,date_time.calendar)
				rootgrp.variables[variableName][posCnt,:,:]= \
					pcr2numpy(pcr.readmap(sourceFileName),MV)
				posCnt+= 1
			except:
				pass
		day+= 1
	#-update file and close 
	rootgrp.sync()
	rootgrp.close()
	return posCnt

#-initialization
#-defining day numbers to calculate length of months
julianDay= [1,32,60,91,121,152,182,213,244,274,305,335,366]
addDay= [0,0,1,1,1,1,1,1,1,1,1,1,1]
nrDays= 365
years= range(1901,1902)
#-map information: nr of rows and columns, MV identifier
MV= -999.9
#-daily and monthly variables
processDaily= False
processMonthly= True
dailyVariables= ['eact','esact','espot','etpot','ewat','intstor','q1s','q1x','q2x','q3x','qc','qloc',\
	'snowcov','snowliq','stor1x','qw','stor2x','stor3x','t1act','t1pot','t2act','t2pot','wh','wlf','wld','wlq']
dailyNames= ['total_actual_evapotranspiration','actual_soil_evaporation','potential_soil_evaporation',\
	'total_potential_evapotranspiration','open_water_evaporation','interception','direct_runoff_snow','direct_runoff',\
	'interflow','base_flow','discharge','specific_runoff','snow_water_equivalent_solid','snow_water_equivalent_liquid',\
	'soil_moisture_storage_soil1','runoff_water_surface','soil_moisture_storage_soil2','soil_moisture_storage_groundwater',\
	'actual_transpiration_soil1','potential_transpiration_soil1','actual_transpiration_soil2','potential_transpiration_soil2','waterheight_channel',\
	'wetland_fractional_area_(bogs_and_peatlands)','wetland_ponded_water_depth','wetland_runoff']
dailyUnits= ['m_per_day','m_per_day','m_per_day','m_per_day','m_per_day','m','m_per_day','m_per_day','m_per_day','m_per_day',\
	'm3_per_second','m_per_day','m','m','m','m_per_day','m','m','m_per_day','m_per_day','m_per_day','m_per_day','m','m2_per_m2_land_surface','m','m_per_day']
monthlyVariables= ['eactmon','esactmon','etpmon','ewatmon','precmon','q1mon','q2mon','q3mon','qwmon','r3mon','tactmon','wlfmon','wldmon','wlqmon']
monthlyNames= ['total_actual_evapotranspiration','actual_soil_evaporation','total_potential_evapotranspiration','open_water_evaporation',\
	'total _precipitation','direct_runoff','interflow','base_flow','runoff_water_surface','net_groundwater_recharge','actual_transpiration_soil',\
	'wetland_fractional_area_(bogs_and_peatlands)','wetland_ponded_water_depth','wetland_runoff']
monthlyUnits= ['m_per_month','m_per_month','m_per_month','m_per_month',\
	'm_per_month','m_per_month','m_per_month','m_per_month','m_per_month','m_per_month','m_per_month',\
	'm2_per_m2_land_surface','m','m_per_day']
#-create combined dictionary of variable long names and units
variables= dailyVariables+monthlyVariables
variableLongNames= dict([(dailyVariables[iCnt],dailyNames[iCnt])\
	for iCnt in xrange(len(dailyVariables))])
variableUnits= dict([(dailyVariables[iCnt],\
	dailyUnits[iCnt])  for iCnt in xrange(len(dailyVariables))])
for iCnt in xrange(len(monthlyVariables)):
	variableLongNames[monthlyVariables[iCnt]]= monthlyNames[iCnt]
	variableUnits[monthlyVariables[iCnt]]= monthlyUnits[iCnt]
	#-archives with forcing
forcingDataSet= 'CRU21'
#-file locations
mapsDir= 'maps'
dataDir= '/home/rens/netData/%s' % forcingDataSet
resultsDir= '/home/rens/Projects/PBL/PCR-GLOBWB/results'
#netCDFDir= '/home/rens/netData/%s' % forcingDataSet
netCDFDir= '/home/rens/netData/netCDF'
#-netCDF and variable attributes
archiveFileRoots= ['pcrglobwb_CRU21_%04d_30min.tar.gz']
ncFileRoot= 'pcrglobwb_CRU21_30min_%s.nc'
netCDFAttributes= {}
netCDFAttributes['title']= 'PCR-GLOBWB simulation results'
netCDFAttributes['institution']= 'Dept. Physical Geography, Utrecht University'
netCDFAttributes['description']= 'Daily data on simulated hydrology including natural discharge'
netCDFAttributes['source']= 'Results are part of a simulation with PCR-GLOBWB, version 1.1\
forced with CRU TS 2.1 and ECMWF ERA-40 data over the period the period %d-%d,\
netCDF created using netCDF4-python' % (years[0],years[-1])
netCDFAttributes['references']= 'For documentation, see Van Beek et al. (WRR, 2011, doi:10.1029/2010WR009791)'
netCDFAttributes['disclaimer']= 'Great care was exerted to prepare these data.\
Notwithstanding, use of the model and/or its outcome is the sole responsibility of the user.'
netCDFAttributes['history']= 'Created on %s' % (datetime.datetime.now()) 
variableAttributes= {}
for variable in variables:
	variableAttributes[variable]= {}
	variableAttributes[variable]['standard_name']= variable
	variableAttributes[variable]['long_name']= variableLongNames[variable].capitalize()
	variableAttributes[variable]['units']= variableUnits[variable]
#-start
print 'Retrieving daily data from archives for period %d-%d' % (years[0],years[-1])
print 'procesing possible variables:',
for variable in variables:
	print variable,
print
#-get spatial attributes for netCDF files
pcr.setclone(os.path.join(mapsDir,'globalclone.map'))
cloneMask= pcr2numpy(pcr.readmap(os.path.join(mapsDir,'globalclone.map')),MV) != 0
nrRows,nrCols= cloneMask.shape
nrCells= np.ones((cloneMask.shape))[cloneMask].size
pcr.setglobaloption('unittrue')
longitudes,latitudes= getCoordinates(pcr.boolean(1))
coordinates= np.zeros((nrCells,2))
pcr.setglobaloption('unitcell')
mapArray= pcr2numpy(pcr.ycoordinate(pcr.boolean(1))+0.5,MV)
coordinates[:,0]= mapArray[cloneMask]
mapArray= pcr2numpy(pcr.xcoordinate(pcr.boolean(1))+0.5,MV)
coordinates[:,1]= mapArray[cloneMask]
#-open output netCDF file
ncFiles= {}.fromkeys(variables)
for variable in variables:
	ncFiles[variable]= os.path.join(netCDFDir,ncFileRoot % variable)
	createNetCDF(ncFiles[variable],longitudes,latitudes,netCDFAttributes)
#-stepping through years
posCnt= {}.fromkeys(variables,0)
for year in years:
	print '\textracting data for %d:' % year,
	for archiveFileRoot in archiveFileRoots:
		extractDailyData(dataDir,archiveFileRoot % year,\
			resultsDir,variables,calendar.isleap(year))
	#-process daily values and add to arrays
	print 'processing data'
	for variable in variables:
		if (variable in dailyVariables and processDaily) or  (variable in monthlyVariables and processMonthly) :
			print 'processing  variable %s' % variable
			#-process daily values
			startDay= 1
			startDate= datetime.datetime(year,1,1,0)
			endDate= datetime.datetime(year+1,1,1,0)
			posCnt[variable]= timeseries2NetCDF(ncFiles[variable],variable,variableAttributes[variable],resultsDir,variable,\
				startDay,startDate,endDate,posCnt[variable],MV,False)
	createOutputDirs(['results'])
#-get yearly values
for fileName in os.listdir(netCDFDir):
	if os.path.splitext(fileName)[1] == '.nc':
		fileNameIn= fileName.replace('.nc','')
		fileNameOut= (ncFileRoot % '').replace('.nc','')
		variable= fileNameIn.replace(fileNameOut,'')
		if (variable in dailyVariables and processDaily) or  (variable in monthlyVariables and processMonthly) :
			print 'obtaining annual average for variable %s' % variable
			fileNameIn= os.path.join(netCDFDir,fileName)
			fileNameOut= fileNameIn.replace('.nc','_y.nc')
			command= 'cdo yearavg %s %s'% (fileNameIn,fileNameOut)
			os.system(command)
#-all done
print 'all done!'