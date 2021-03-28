
set -x

rm *.tif
rm *.map

# ldd 5 min from gmd paper run
cp /scratch/depfg/sutan101/data/pcrglobwb2_input_release/version_2019_11_beta_extended/pcrglobwb2_input/global_05min/routing/ldd_and_cell_area/lddsound_05min.map lddsound_05min_gmd_paper.map

# ulysses landmask
cp /scratch/depfg/sutan101/data/pcrglobwb_input_ulysses/develop/global_06min/cloneMaps/global_land_mask/version_2020-08-11/land_mask_only.map land_mask_ulysses_06min.map
pcrcalc land_mask_ulysses_06min.map = "if(land_mask_ulysses_06min.map, land_mask_ulysses_06min.map)"

gdalwarp -te -180 -90 180 90 -tr 0.0833333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333 0.0833333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333 land_mask_ulysses_06min.map land_mask_ulysses_05min.tif

gdal_translate -of PCRaster land_mask_ulysses_05min.tif land_mask_ulysses_05min.map
mapattr -c lddsound_05min_gmd_paper.map land_mask_ulysses_05min.map

pcrcalc updated_landmask_05min.map = "cover(land_mask_ulysses_05min.map, defined(lddsound_05min_gmd_paper.map))"
pcrcalc updated_landmask_05min.map = "if(updated_landmask_05min.map, updated_landmask_05min.map)"

pcrcalc updated_ldd_05min.map = "lddrepair(lddrepair(ldd(cover(lddsound_05min_gmd_paper.map, ldd(5)))))"
pcrcalc updated_ldd_05min.map = "if(updated_landmask_05min.map, updated_ldd_05min.map)"
pcrcalc updated_ldd_05min.map = "lddrepair(lddrepair(ldd(updated_ldd_05min.map)))"

pcrcalc updated_landmask_05min.map = "defined(updated_landmask_05min.map)"
pcrcalc updated_landmask_05min.map = "if(updated_landmask_05min.map, updated_landmask_05min.map)"

mv updated_ldd_05min.map       global_ldd_05min_version_20210325.map
mv updated_landmask_05min.map global_mask_05min_version_20210325.map

aguila global_ldd_05min_version_20210325.map global_mask_05min_version_20210325.map

rm *.xml

set +x
