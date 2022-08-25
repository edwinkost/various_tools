#cru_10min_climate.py reads in CRU 10 minute global climatology maps and
#returns relevant timeseries of daily precipitation, temperature, shortwave radiation
#relative humidity, min, max and average temperature, and wind speed
import os, sys, gzip, datetime
import numpy as np
from convert2NetCDF import *
import PCRaster as pcr
from PCRaster.NumPy import numpy2pcr

def position2Coords(posArray,posOffSet,resolution):
	return posOffSet+posArray*resolution
	
def coords2Position(posArray,posOffSet,resolution):
	return np.round(np.abs(posArray-posOffSet)/resolution)

def getAnomaly(field,sampleWindow,MV):
	#-returns anomaly for specified window length
	anomaly= field.copy()
	nrRows= field.shape[0]
	nrCols= field.shape[1]
	rowCnt= 0
	while rowCnt < nrRows:
		colCnt= 0
		rowCntNew= np.minimum(nrRows,rowCnt+sampleWindow)
		while colCnt < nrCols:
			colCntNew= np.minimum(nrCols,colCnt+sampleWindow)
			if np.any(field[rowCnt:rowCntNew,colCnt:colCntNew] <> MV):
				field[rowCnt:rowCntNew,colCnt:colCntNew][field[rowCnt:rowCntNew,colCnt:colCntNew] <> MV]-=\
					np.average(field[rowCnt:rowCntNew,colCnt:colCntNew][field[rowCnt:rowCntNew,colCnt:colCntNew] <> MV])
			colCnt= colCntNew
		rowCnt= rowCntNew 
	return  field

def getCorrelation(x,y,MV,intercept= True):
	mask= (x <> MV) & (y <> MV) 
	y= y[mask]
	x= x[mask]
	b0= MV; b= MV; RSQ= MV; correl= MV
	N= x.size
	if N > 0:
		if intercept:
			A = np.vstack([x, np.ones(len(x))]).T
		else:
			A = np.vstack([x, np.zeros(len(x))]).T
		b, b0= np.linalg.lstsq(A, y)[0]
		SSE= ((y-(b0+b*x))**2).sum()
		SSM= ((b0+b*x)**2).sum()
		if SSM+SSE == 0:
			RSQ= MV
		else:
			RSQ= SSM/(SSM+SSE)
		if np.all(x == 0): x+= 1.e-6
		if np.all(y == 0): y+= 1.e-6
		DSQ= ((N*(x**2).sum()-x.sum()**2)*(N*(y**2).sum()-y.sum()**2))
		if DSQ <= 0:
			correl= MV
		else:
			correl= (N*(x*y).sum()-x.sum()*y.sum())*DSQ**-0.5
		if N > 1:
			sb= ((SSE/(N-1))**0.5)*((x**2).sum())**-0.5
		else:
			sb= MV
	return N, b0, b, RSQ, correl

#-initialization
MV= -999.9
dataFileName= '/home/rens/netData/GlobalDataSets/CRU_CLIM2.0/grid_10min_elv.dat.gz'
netCDFAttributes= {}
netCDFAttributes['title']= 'CRU downscaling'
netCDFAttributes['institution']= 'Dept. Physical Geography, Utrecht University'
netCDFAttributes['description']= 'Elevation anomalies'
variableAttributes= {}
nrMonths= 12
dummyYear= 1961
#-number of rows and columns
sampleResolution= 10./60.
aggregateResolution= 0.5
sampleWindow= int(aggregateResolution//sampleResolution)
xMin= -180.
xMax= 180.
yMin= -90.
yMax= 90.
nrRows= (yMax-yMin)//sampleResolution
nrCols= (xMax-xMin)//sampleResolution
latitudes= position2Coords(-(np.arange(nrRows,dtype= float)+0.5),yMax,sampleResolution)
longitudes= position2Coords(np.arange(nrCols,dtype= float)+0.5,xMin,sampleResolution)

#-read in data file
dataArray= np.loadtxt(dataFileName)
print ' - processing %s with %d, %d entries' % (os.path.split(dataFileName)[1],dataArray.shape[0],dataArray.shape[1])

#-set positions for first and second columns containing latitue, longitiude
dataArray[:,0]= coords2Position(dataArray[:,0],latitudes[0],sampleResolution)
dataArray[:,1]= coords2Position(dataArray[:,1],longitudes[0],sampleResolution)
sampleWindow= coords2Position(aggregateResolution,0,sampleResolution)

colCnt= 2
field= np.ones((nrRows,nrCols))*MV
for rowCnt in xrange(dataArray.shape[0]):
	field[dataArray[rowCnt,0],dataArray[rowCnt,1]]= dataArray[rowCnt,colCnt]

elevation= field.copy()
elevation[field <> MV]= 1000.*field[field <> MV]

ncFile= 'elevation.nc'
createNetCDF(ncFile,longitudes,latitudes,False,netCDFAttributes)
data2NetCDF(ncFile,'elevation',variableAttributes,elevation)

#-create anomalies of elevation and create range at aggregated resolution
elevation_ano= getAnomaly(elevation,sampleWindow,MV)
elevation_range= np.ones((nrRows/sampleWindow,nrCols/sampleWindow))*MV
#-iterate over rows and columns
rowCnt= 0
while rowCnt < nrRows:
	colCnt= 0
	rowCntNew= np.minimum(nrRows,rowCnt+sampleWindow)
	while colCnt < nrCols:
		colCntNew= np.minimum(nrCols,colCnt+sampleWindow)
		mask= elevation[rowCnt:rowCntNew,colCnt:colCntNew] <> MV
		if np.any(mask):
			#-insert into array
			iCnt= rowCnt/sampleWindow
			jCnt= colCnt/sampleWindow
			elevation_range[iCnt,jCnt]= np.max(elevation[rowCnt:rowCntNew,colCnt:colCntNew][mask])-\
				np.min(elevation[rowCnt:rowCntNew,colCnt:colCntNew][mask])
		colCnt= colCntNew
	rowCnt= rowCntNew 

#-read in data file
variable= 'precipitation'
varCode= 'pre'
variable= 'temperature'
varCode= 'tmp'
dataFileName= '/home/rens/netData/GlobalDataSets/CRU_CLIM2.0/grid_10min_%s.dat.gz' % varCode

#-read in data file
dataArray= np.loadtxt(dataFileName)
print ' - processing %s with %d, %d entries' % (os.path.split(dataFileName)[1],dataArray.shape[0],dataArray.shape[1])

#-set positions for first and second columns containing latitue, longitiude
dataArray[:,0]= coords2Position(dataArray[:,0],latitudes[0],sampleResolution)
dataArray[:,1]= coords2Position(dataArray[:,1],longitudes[0],sampleResolution)

#-read in field over the months and assign to reduced arrays
correlation= {}
keys= ['nobs','slope','correl']
for key in keys:
	correlation[key]=  np.ones((nrMonths,nrRows/sampleWindow,nrCols/sampleWindow))*MV

for monthCnt in xrange(nrMonths):
	field= np.ones((nrRows,nrCols))*MV
	for rowCnt in xrange(dataArray.shape[0]):
		field[dataArray[rowCnt,0],dataArray[rowCnt,1]]= dataArray[rowCnt,monthCnt+2]
	field= getAnomaly(field,sampleWindow,MV)
	rowCnt= 0
	while rowCnt < nrRows:
		colCnt= 0
		rowCntNew= np.minimum(nrRows,rowCnt+sampleWindow)
		while colCnt < nrCols:
			colCntNew= np.minimum(nrCols,colCnt+sampleWindow)
			mask= (field[rowCnt:rowCntNew,colCnt:colCntNew] <> MV) & \
				(elevation_ano[rowCnt:rowCntNew,colCnt:colCntNew] <> MV)
			N= np.sum(mask)
			if N >= 1:
				if N == 1:
					b= 0.0
					correl= MV
				else:
					#-get values from correlation of anomalies with intercept to zero
					N,b0,b,RSQ,correl= getCorrelation(elevation_ano[rowCnt:rowCntNew,colCnt:colCntNew][mask],\
						field[rowCnt:rowCntNew,colCnt:colCntNew][mask],MV,False)
				#-insert into array
				iCnt= rowCnt/sampleWindow
				jCnt= colCnt/sampleWindow
				correlation['nobs'][monthCnt,iCnt,jCnt]= N
				correlation['slope'][monthCnt,iCnt,jCnt]= b
				correlation['correl'][monthCnt,iCnt,jCnt]= correl
			colCnt= colCntNew
		rowCnt= rowCntNew 

#-write monthly variables at reduced resolution
nrRows/= sampleWindow
nrCols/= sampleWindow
latitudes= position2Coords(-(np.arange(nrRows,dtype= float)+0.5),yMax,aggregateResolution)
longitudes= position2Coords(np.arange(nrCols,dtype= float)+0.5,xMin,aggregateResolution)

ncFile= 'elevation_range.nc'
createNetCDF(ncFile,longitudes,latitudes,False,netCDFAttributes)
data2NetCDF(ncFile,'elevation_range',variableAttributes,elevation_range)

for key in correlation.keys():
	ncFile= '%s_%s.nc' % (variable,key)
	createNetCDF(ncFile,longitudes,latitudes,True,netCDFAttributes)
	for monthCnt in xrange(nrMonths):
		dummyDate= datetime.datetime(dummyYear,monthCnt+1,1,0)
		data2NetCDF(ncFile,variable,variableAttributes,correlation[key][monthCnt,:,:],monthCnt,dummyDate)
print 'all done'