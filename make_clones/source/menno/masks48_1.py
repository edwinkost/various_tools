import arcpy, os, time, datetime, shutil, string, subprocess, glob

# set variables
inputDir              = r"D:/masks/areas48"
workSpacePath         = r"D:/masks/scratch"
arcpy.env.workspace   = workSpacePath
arcpy.env.XYTolerance = '0.01'
arcpy.env.overwriteOutput = True

#++++++++++++++++++++++++++++++++++++
shutil.rmtree(workSpacePath)
os.mkdir(workSpacePath)

#- combine mask files into a single shapefile
maskFiles = glob.glob(inputDir + '//*.shp')
maskID = 0
for maskFile in maskFiles[0:]:
    print maskFile
    maskID += 1
    dbfFile = maskFile[:-4] + '.dbf'
    arcpy.DeleteField_management(dbfFile, 'MASKID')
    arcpy.AddField_management(dbfFile, "MASKID", "FLOAT", '5', '0')
    arcpy.CalculateField_management(dbfFile, "MASKID", str(maskID), 'Python')

arcpy.Merge_management(maskFiles, 'masks.shp')
arcpy.Dissolve_management('masks.shp', 'maskDissolved.shp', ["MASKID"], "", "MULTI_PART")

os.chdir(workSpacePath)
co = 'gdal_rasterize -at -a MASKID -ot Float32 -tr 0.08333333333 0.08333333333333 -te -180 -90 180 90 masks.shp temp.tif'
print co
subprocess.call(co, shell = True)
co = 'gdal_translate -of PCRaster -ot Float32 temp.tif temp.map'
print co
subprocess.call(co, shell = True)
co = 'pcrcalc mask48.map = if(temp.map gt 0, nominal(temp.map))'
subprocess.call(co, shell = True)
print co
