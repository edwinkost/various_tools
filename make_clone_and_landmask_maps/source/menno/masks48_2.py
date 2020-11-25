import pcraster as pcr
import numpy as np
import os, glob, string, subprocess, time, datetime
from math import floor, ceil

########################## PCRaster IO ##########################################

def col2map(arr, cloneMapName, x=0, y=1,v=2, output = 'var'):
    ''' creates a PCRaster map based on cloneMap
        x,y,v (value) are the indices of the columns in arr '''
    if output == 'var':
        g = np.hstack((arr[:,x:x+1],arr[:,y:y+1],arr[:,v:v+1]))
        np.savetxt('temp.txt', g, delimiter=',')
        cmd = 'col2map --clone %s temp.txt temp.map'%cloneMapName
        subprocess.call(cmd, shell=True)
        outMap = pcr.readmap('temp.map')
        os.remove('temp.txt')
        os.remove('temp.map')
        return outMap
    
    elif output == 'map':
        g = np.hstack((arr[:,x:x+1],arr[:,y:y+1],arr[:,v:v+1]))
        np.savetxt('temp.txt', g, delimiter=',')
        cmd = 'col2map --clone %s temp.txt temp.map'%cloneMapName
        subprocess.call(cmd, shell=True)
        return 'temp.map'

def map2col(inputMap):
    ''' reads in the input map and returns the resulting array '''
    pcr.report(inputMap,'temp.map')
    command= 'map2col temp.map temp.txt'
    subprocess.call(command)
    a= np.loadtxt('temp.txt')
    a= np.delete(a, np.s_[0:2], axis=1)
    try:
        os.remove('temp.txt')
        os.remove('temp.map')
    except:
        pass
    return a

def maps2cols(listOfInputMaps):
    ''' reads in the input maps and returns map values as an array '''
    nrMaps = len(listOfInputMaps)
    command= 'map2col  temp.txt'
    for ii in range(nrMaps):
        outFile = 'temp%s.map' % (str(ii))
##        print outFile, listOfInputMaps[ii]
        pcr.report(listOfInputMaps[ii], outFile)
        command = insert(command, outFile, -9)
    subprocess.call(command, shell=True)
    a= np.loadtxt('temp.txt')
    a= np.delete(a, np.s_[0:2], axis=1)
    try:
        os.remove("temp.txt")
        for f in glob.glob("temp*.map"):
            os.remove(f)
    except:
        pass
    return a

def maps2colsXY(listOfInputMaps):
    ''' reads in the input maps and returns [x,y,mapValues] as an array '''
    nrMaps = len(listOfInputMaps)
    command= 'map2col  temp.txt'
    for ii in range(nrMaps):
        outFile = 'temp%s.map' % (str(ii))
        pcr.report(listOfInputMaps[ii], outFile)
        command = insert(command, outFile, -9)
    subprocess.call(command, shell=True)
    a= np.loadtxt('temp.txt')
    try:
        os.remove("temp.txt")
        for f in glob.glob("temp*.map"):
            os.remove(f)
    except:
        pass
    return a

################# PCR recipes ##########################################

def resampleMax(pcrMap, cloneMap):
    ''' resample map and return pcr map field, use maximum value '''
    pcr.report(pcrMap, 'temp.map')
    cmd = 'resample --clone %s -m temp.map resampled.map' % (cloneMap)
    subprocess.call(cmd, shell=True)
    try:
        os.remove('temp.map')
    except:
        pass
    return pcr.readmap('resampled.map')
  
def getMapAttr(fileName):
    ''' list the map attributes in a dictionary, keys are mapattr output codes '''
    d={}
    cmd = 'mapattr -p %s' % fileName
    raw = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True).communicate()[0]
    for row in raw.split('\n')[:-1]:
        
        items = row.split()
        k,v = items[0], items[1]
        try:
            vScalar = float(v)
            d[k] = vScalar
        except ValueError:
            d[k] = v
    return d

def makeGlobalMap(mapName, cellSize = 0.1, dataType = 'S', output='map'):
    xUL, yUL = -180,  90
    xLR, yLR =  180, -90
    nrRows   = (yUL-yLR)/cellSize
    nrCols   = (xLR-xUL)/cellSize
    cmd  = 'mapattr -s -P yb2t --large -%s -R %i -C %i -x %s -y %s -l %s %s' % (dataType, nrRows, nrCols, xUL, yUL, cellSize, mapName)
    try:
        os.remove(mapName)
    except:
        pass
    subprocess.call(cmd, shell=True)
    if output == 'var':
        return pcr.readmap(mapName)
    if output == 'map':
        return mapName

def fillBoundingBox(inMap, fillValue, xmin, xmax, ymin, ymax):
    #- create dictionary with map attributes and extract 
    pcr.report(inMap, 'temp.map')
    mapAttr = getMapAttr('temp.map')
    nrRows  = mapAttr['rows']
    nrCols  = mapAttr['columns']
    cellSize= mapAttr['cell_length']
    mapXmin = mapAttr['xUL']
    mapXmax = mapXmin + nrCols*cellSize - cellSize
    mapYmax = mapAttr['yUL']
    mapYmin = mapYmax - nrRows*cellSize + cellSize
    
    #- determine array indices of bounding box
    X = np.linspace(mapXmin,mapXmax,num=nrCols,endpoint=True)
    Y = np.linspace(mapYmin,mapYmax,num=nrRows,endpoint=True)
    indexXmin = np.searchsorted(X, xmin)
    indexXmax = np.searchsorted(X, xmax)
    indexYmin = 1+ len(Y) - np.searchsorted(Y, ymin, side='right')
    indexYmax = 1+ len(Y) - np.searchsorted(Y, ymax, side='right')
    #- fill bounding box with new value
    mapArray = pcr.pcr2numpy(inMap, -9999)
    mapArray[indexYmax:indexYmin, indexXmin:indexXmax] = fillValue
    return numpy2pcr(pcr.Scalar, mapArray, -9999)

def fillMVBoundingBox(inMap, fillValue, xmin, xmax, ymin, ymax):
    ''' fill missing values in BB with fillValue '''
    #- create dictionary with map attributes and extract 
    pcr.report(inMap, 'temp.map')
    mapAttr = getMapAttr('temp.map')
    nrRows  = mapAttr['rows']
    nrCols  = mapAttr['columns']
    cellSize= mapAttr['cell_length']
    mapXmin = mapAttr['xUL']
    mapXmax = mapXmin + nrCols*cellSize - cellSize
    mapYmax = mapAttr['yUL']
    mapYmin = mapYmax - nrRows*cellSize + cellSize
    
    #- determine array indices of bounding box
    X = np.linspace(mapXmin,mapXmax,num=nrCols,endpoint=True)
    Y = np.linspace(mapYmin,mapYmax,num=nrRows,endpoint=True)
    indexXmin = np.searchsorted(X, xmin)
    indexXmax = np.searchsorted(X, xmax)
    indexYmin = 1+ len(Y) - np.searchsorted(Y, ymin, side='right')
    indexYmax = 1+ len(Y) - np.searchsorted(Y, ymax, side='right')
    #- fill bounding box with new value
    mapArray = pcr.pcr2numpy(inMap, -9999)
    box = mapArray[indexYmax:indexYmin, indexXmin:indexXmax]
    box[box == -9999] = fillValue
    mapArray[indexYmax:indexYmin, indexXmin:indexXmax] = box
    return pcr.numpy2pcr(pcr.Scalar, mapArray, -9999)
    
def selectCatchments(ldd, pitsMap, pitsDict, continentList, cloneMap):
    catchments = pcr.ifthen(pcr.boolean(pcr.readmap(cloneMap)) == 0, pcr.scalar(1))    
    for continent in pitsDict.iterkeys():
        continentNr   = pitsDict[continent][0]
        pitsContinent = pitsDict[continent][1:]
        print 'updating catchments for ', continent.upper()
        for pitNr in pitsContinent:
            pitMap = pcr.ifthen(pitsMap == pitNr, pcr.scalar(continentNr))
            catchment = pcr.catchment(ldd, pcr.nominal(pitMap))
            catchment = pcr.ifthen(pcr.boolean(catchment) == 1, catchment)
            catchments = pcr.cover(catchments, pcr.scalar(catchment))
    return catchments

def extentsContinents(continentList):
    ''' create dictionary with continent extents in lat lon based on 6 min masks '''
    #- create dictionary with map attributes and extract 
    extentsDict = {}
    for continent in continentList:
        maskName = mask6minDir + r'/%smask.map'%continent
        mapAttr = getMapAttr(maskName)
        nrRows  = mapAttr['rows']
        nrCols  = mapAttr['columns']
        cellSize= mapAttr['cell_length']
        mapXmin = np.floor(mapAttr['xUL'])
        mapXmax = np.ceil(mapXmin + nrCols*cellSize - cellSize)
        mapYmax = np.ceil(mapAttr['yUL'])
        mapYmin = np.floor(mapYmax - nrRows*cellSize + cellSize)
        extentsDict[continent] = [mapXmin, mapXmax, mapYmin, mapYmax]
    return extentsDict

def selectCatchments(ldd, pitsMap, pitsDict, continentList, cloneMap):
    catchments = pcr.ifthen(pcr.boolean(pcr.readmap(cloneMap)) == 0, pcr.scalar(1))    
    for continent in pitsDict.iterkeys():
        continentNr   = pitsDict[continent][0]
        pitsContinent = pitsDict[continent][1:]
        print 'updating catchments for ', continent
        for pitNr in pitsContinent:
            pitMap = pcr.ifthen(pitsMap == pitNr, pcr.scalar(continentNr))
            catchment = pcr.catchment(ldd, pcr.nominal(pitMap))
            catchment = pcr.ifthen(pcr.boolean(catchment) == 1, catchment)
            catchments = pcr.cover(catchments, pcr.scalar(catchment))
    return catchments

def localMasks(mask, ldd, extentsDict):
    ''' use gdal to clip mask to continent extents '''
    continentNr = {'camerica':1, 'samerica':2, 'namerica':3, 'europe':4, 'oceania':5, 'asia':6, 'africa':7}
    for continent in continentNr.iterkeys():
        nr = continentNr[continent]
        xmin, xmax, ymin, ymax = extentsDict[continent]
        #- cut out ldd
        lddCont  = pcr.ifthen(mask == nr, ldd)
        pcr.report(pcr.scalar(lddCont),  'lddtemp.map')
        cmd = 'gdal_translate -ot Float32 -of PCRaster -projwin %0.1f %0.1f %0.1f %0.1f lddtemp.map temp.ldd' %(xmin,ymax,xmax,ymin)
        os.system(cmd)
        cmd = "pcrcalc %s%s_ldd.map = lddrepair(ldd(temp.ldd))%s" %("'",continent[0:2],"'")
        os.system(cmd)
        #- cut out mask
        maskCont = pcr.ifthen(mask == nr, mask)
        pcr.report(maskCont, 'masktemp.map')
        cmd = 'gdal_translate -ot Float32 -of PCRaster -projwin %0.1f %0.1f %0.1f %0.1f masktemp.map masktemp2.map' %(xmin,ymax,xmax,ymin)
        os.system(cmd)
        cmd = "pcrcalc %s%s_mask.map = boolean(masktemp2.map)%s" %("'",continent[0:2],"'")
        os.system(cmd)
        print cmd + '\n'   

def boundingBox(pcrmap):
    ''' derive the bounding box for a map, return xmin,ymin,xmax,ymax '''
    bb = []
    xcoor = pcr.xcoordinate(pcrmap)
    ycoor = pcr.ycoordinate(pcrmap)
    xmin  = pcr.cellvalue(pcr.mapminimum(xcoor),1,1)[0]
    xmax  = pcr.cellvalue(pcr.mapmaximum(xcoor),1,1)[0]
    ymin  = pcr.cellvalue(pcr.mapminimum(ycoor),1,1)[0]
    ymax  = pcr.cellvalue(pcr.mapmaximum(ycoor),1,1)[0]
    return [floor(xmin),floor(ymin),ceil(xmax),ceil(ymax)]


################################### initial ###################################
startTime        = time.time()
scratchDir       = '/home/straa005/masks/scratch'
cellSizeMinutes  = 5  # minutes; will be converted to decimal degrees
os.chdir(scratchDir)
cloneMap         = makeGlobalMap('clone%smin.map'%cellSizeMinutes, cellSize=cellSizeMinutes/60., dataType='S', output='map')
ldd              = pcr.readmap('/data/hydroworld/PCRGLOBWB20/input5min/routing/lddsound_05min.map')
mask48           = pcr.readmap('/home/straa005/masks/areas48/mask48.map')
areas            = range(1,47,1)

pitsDict = {13 : [13,3153],
            28 : [28,3515]}

lddOld = pcr.readmap('/home/straa005/LDD/lddOutput/ldd_HydroSHEDS_Hydro1k_5min.map')

lddDiff = pcr.scalar(ldd) - pcr.scalar(lddOld)
pcr.report(pcr.boolean(lddDiff), 'lddDiff.map')


p
############################### main ###################################
ldd = pcr.nominal(ldd)
ldd = fillMVBoundingBox(ldd, 1, 57, 76, 26, 47)
ldd = fillMVBoundingBox(ldd, 1, 58, 62, 51, 60)
ldd = fillMVBoundingBox(ldd, 1, -108, -101, 31, 40)
ldd = pcr.lddrepair(pcr.ldd(ldd))
pits = pcr.pit(ldd)

pcr.setglobaloption('unitcell')

continentMasks = pcr.cover(mask48, pcr.windowmajority(mask48,5))

#- adjust area masks with 5 min ldd
continentMasksNew = pcr.ifthen(pcr.boolean(pcr.readmap(cloneMap)) == 0, pcr.scalar(1))
for i in areas[0:]:
    print 'area mask = ', i
    mask = pcr.ifthen(continentMasks == i, pcr.boolean(1))
    pitsContinent = pcr.pcrand(mask, pcr.boolean(pits))
    pitsContinent = pcr.nominal(pcr.uniqueid(pcr.ifthen(pitsContinent == 1, pcr.boolean(1))))
    catchments    = pcr.catchment(ldd, pitsContinent)
    newMask       = pcr.ifthen(pcr.boolean(catchments) == 1, pcr.scalar(i))
    continentMasksNew = pcr.cover(continentMasksNew, newMask)
updateCatchments = selectCatchments(ldd, pits, pitsDict, areas, cloneMap)
outMask = pcr.cover(updateCatchments, continentMasksNew)
pcr.report(pcr.nominal(outMask), 'mask5min.map')
pcr.report(ldd, 'ldd5min.map')

#- create clone, ldd, and mask map for each area.
outMask  = pcr.readmap('mask5min.map')
ldd      = pcr.readmap('ldd5min.map')
ldd      = pcr.lddrepair(pcr.ldd(pcr.ifthen(pcr.boolean(outMask) == 1, pcr.scalar(ldd))))

clone    = pcr.cover(pcr.boolean(outMask), pcr.boolean(1))
pcr.report(clone, 'globalClone5min.map')
pcr.setglobaloption('unittrue')
for nr in areas[0:]:
    mask = outMask == nr
    xmin,ymin,xmax,ymax = boundingBox(mask)
    lddMask = pcr.ifthen(outMask == nr, ldd) 

    mask = pcr.ifthen(mask == 1, mask)
    pcr.report(mask, 'masktemp.map')
    cmd = 'gdal_translate -of PCRaster -ot Byte -projwin %s %s %s %s masktemp.map mask_M%02d.map' % (xmin,ymax,xmax,ymin, nr)
    print cmd
    subprocess.call(cmd, shell=True)

    pcr.report(lddMask, 'lddtemp.map')
    cmd = 'gdal_translate -of PCRaster -ot Float32 -projwin %s %s %s %s lddtemp.map lddMaskTemp.map' % (xmin,ymax,xmax,ymin)
    print cmd
    subprocess.call(cmd, shell=True)
    cmd = """pcrcalc 'ldd_M%02d.map = ldd(lddMaskTemp.map)' """ % nr
    subprocess.call(cmd, shell=True)

    cmd = 'gdal_translate -of PCRaster -ot Byte -projwin %s %s %s %s globalClone5min.map clone_M%02d.map' % (xmin,ymax,xmax,ymin, nr)
    print cmd
    subprocess.call(cmd, shell=True)

subprocess.call('cp ldd_M*.map ../output/'  , shell = True)
subprocess.call('cp mask_M*.map ../output/' , shell = True)
subprocess.call('cp clone_M*.map ../output/', shell = True)
                     
secs = int(time.time() - startTime)
print "All in all, it took %s hh:mm:ss\n" % (str(datetime.timedelta(seconds=secs)))



