#-reads PCRaster maps of monthly potential evapotranspiration from the CRU and ERA-Interim datasets
# for selected coordinates

import os, calendar
import numpy as np
import PCRaster as pcr
from PCRaster.NumPy import pcr2numpy
from PCRaster.Framework import generateNameT

#-Initialization
globalCloneMap= '/home/rens/archive/globalmaps/globalclone.map'
xMin= 1.
xMax= 1.5
yMin= 11.
yMax= 11.5
MV= -999.9
startYear= 1901
endYear= 2002
months= range(1,13)
formatStr= '%8.1f'
julianDay= [1,32,60,91,121,152,182,213,244,274,305,335]
headerStr= 'CRU TS2.1: Monthly average temperature range [degC]'
conversionFactor= 0.1
outputFileName= 'extracted_cru21_temperaturerange.txt' 
dataSetNames= ('CRU',)
dataSets= {}.fromkeys(dataSetNames)
dataSets['CRU']= {}
dataSets['CRU']['path']= '/home/rens/Projects/crudata/newlygridded/dtr'
dataSets['CRU']['fileRoot']= 'cdtr%s'
dataSets['CRU']['date']= False 

#-Start
#-read in clone and obtain the indices to be read from the map
globalClone= pcr.setclone(globalCloneMap)
xCoordinates= pcr2numpy(pcr.xcoordinate(pcr.boolean(1)),MV)[0,:]
yCoordinates= pcr2numpy(pcr.ycoordinate(pcr.boolean(1)),MV)[:,0]
validRows= np.arange(yCoordinates.size)[(yCoordinates >= yMin) & (yCoordinates <= yMax)]
validColumns= np.arange(xCoordinates.size)[(xCoordinates >= xMin) & (xCoordinates <= xMax)]
print validRows, validColumns
rowStart= validRows.min()
rowEnd= validRows.max()+1
columnStart= validColumns.min()
columnEnd= validColumns.max()+1
xMin= xCoordinates[columnStart:columnEnd].min()
xMax= xCoordinates[columnStart:columnEnd].max()
yMin= yCoordinates[rowStart:rowEnd].min()
yMax= yCoordinates[rowStart:rowEnd].max()
print 'extracting datasets of monthly data over window (col, row)  %d, %d - %d, %d with coordinates (x,y) %.2f, %.2f - %.2f, %.2f' %\
	(columnStart,rowStart,columnEnd,rowEnd,xMin,yMin,xMax,yMax),
print 'over the period %d-%d' % (startYear,endYear)
#-open output file and write header
txtFile= open(outputFileName,'w')
wStr= '# %s\n' % headerStr
wStr+= '# missing value identifier: %s\n' % (formatStr % MV)
nCnt= 0
for name in list(dataSetNames):
	nCnt+= 1
	wStr+= '# %d: %s\n' % (nCnt,name)
nCnt= 0
nStr= ''
for rowCnt in xrange(validRows.size):
	for columnCnt in xrange(validColumns.size):
		nCnt+= 1
		wStr+= '# %d: x= %.2f, y= %.2f\n' % (nCnt,xCoordinates[columnStart:columnEnd][columnCnt],yCoordinates[rowStart:rowEnd][rowCnt])
		nStr+= ',%s' % (' '*(len(formatStr % 0)-len(str(nCnt)))+str(nCnt))
wStr+= '#%7s,%8s' % ('year','month')
for dataCnt in xrange(len(dataSets.keys())):
	wStr+= nStr
wStr+= '\n'
txtFile.write(wStr)
#-iterate over years
years= range(startYear,endYear)
for year in years:
	#-echo
	print ' - processing %d' % year,
	#-initialize array
	data= np.ones((len(dataSets.keys()),len(months),validRows.size,validColumns.size))*MV
	for name,dataSet in dataSets.iteritems():
		print name,
		#-set fictive day and counters
		day= 0
		monthCnt= 0
		dataCnt= list(dataSetNames).index(name)
		for month in months:
			#-get file name
			if dataSet['date']:
				fileName= dataSet['fileRoot'] % (year,month,day)
			else:
				if 'tss'in dataSet.keys():
					fileName= generateNameT(dataSet['fileRoot'],julianDay[monthCnt])
				else:
					fileName= generateNameT(dataSet['fileRoot'] % ('%04d' % year),month)
			fileName= os.path.join(dataSet['path'],fileName)
			if os.path.isfile(fileName):
				try:
					#-read in file as array and obtain values
					field= pcr2numpy(pcr.readmap(fileName),MV)
					data[dataCnt,monthCnt,:,:]= field[rowStart:rowEnd,columnStart:columnEnd]
				except:
					print ' -%s could not be read' % fileName
			#-update monthCnt
			monthCnt+= 1
	#-print empty line and write data
	print
	monthCnt= 0
	for month in months:
		wStr= '%8d,%8d' % (year,month)
		for name in list(dataSetNames):
			dataCnt= list(dataSetNames).index(name)
			for rowCnt in xrange(validRows.size):
				for columnCnt in xrange(validColumns.size):
					if data[dataCnt,monthCnt,rowCnt,columnCnt] <> MV:
						wStr+= ','+formatStr % (conversionFactor*data[dataCnt,monthCnt,rowCnt,columnCnt])
					else:
						wStr+= ','+formatStr % (data[dataCnt,monthCnt,rowCnt,columnCnt])
		#-terminate string, write to file and update monthCnt
		wStr+= '\n'
		txtFile.write(wStr)
		monthCnt+= 1
	#-delete data
	del data
#-close file
txtFile.close()

##headerStr= 'Potential reference evapotranspiration [mm/day] as computed with the FAO guidelines (Allen et al., 1998)'
##conversionFactor= 1000.
##outputFileName= 'extracted_potevap.txt' 
##dataSetNames= ('CRU','ERA-Interim')
##dataSets= {}.fromkeys(dataSetNames)
##dataSets['CRU']= {}
##dataSets['CRU']['path']= '/home/rens/Projects/crudata/newlygridded/etp'
##dataSets['CRU']['fileRoot']= 'cetp%s'
##dataSets['CRU']['date']= False 
##dataSets['ERA-Interim']= {}
##dataSets['ERA-Interim']['path']= '/mnt/data1/PCRarchive/PotEvapotranspiration/ERA-Interim'
##dataSets['ERA-Interim']['fileRoot']= 'Global_PotEvapotranspiration_ERA-Interim_%04d-%02d-%02d_30min.map'
##dataSets['ERA-Interim']['date']= True

##headerStr= 'Crop factor for open water surface [dimensionless factor] as computed according to the FAO guidlines (Doorenbos & Pruitt, 1977)\n# monthly climatology'
##conversionFactor= 1.
##outputFileName= 'extracted_open_water_crop_factor.txt' 
##dataSetNames= ('FAO',)
##dataSets= {}.fromkeys(dataSetNames)
##dataSets['FAO']= {}
##dataSets['FAO']['path']= '/home/rens/archive/globalmaps'
##dataSets['FAO']['fileRoot']= 'kc_wat'
##dataSets['FAO']['date']= False
##dataSets['FAO']['tss']= True
