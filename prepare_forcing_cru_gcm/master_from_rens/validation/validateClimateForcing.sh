#~ cdo timmean -yearavg -seldate,1961-01-01,1990-12-31 /projects/0/dfguu/data/hydroworld/forcing/ERA20C/CRU-TS3.23_ERA20C_daily_temperature_1901_to_2010.nc CRU-TS3.23_ERA20C_temperature_1961_to_1990.nc
#~ cdo timmean -yearavg -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_temperature_2011_to_2100.nc CRU-TS3.23_ERA20C_temperature_2041_to_2060.nc
#~ cdo timmean -yearavg -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_temperature_2011_to_2100_rcp4p5.nc CRU-TS3.23_ERA20C_temperature_2041_to_2060_rcp4p5.nc
#~ 
#~ cdo timmean -yearsum -seldate,1961-01-01,1990-12-31 /projects/0/dfguu/data/hydroworld/forcing/ERA20C/CRU-TS3.23_ERA20C_daily_precipitation_1901_to_2010.nc CRU-TS3.23_ERA20C_precipitation_1961_to_1990.nc
#~ cdo timmean -yearsum -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_precipitation_2011_to_2100.nc CRU-TS3.23_ERA20C_precipitation_2041_to_2060.nc
#~ cdo timmean -yearsum -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_precipitation_2011_to_2100_rcp4p5.nc CRU-TS3.23_ERA20C_precipitation_2041_to_2060_rcp4p5.nc
#~ 
#~ cdo timmean -yearsum -seldate,1961-01-01,1990-12-31 /projects/0/dfguu/data/hydroworld/forcing/ERA20C/CRU-TS3.23_ERA20C_daily_referencePotET_1901_to_2010.nc CRU-TS3.23_ERA20C_referencePotET_1961_to_1990.nc
#~ cdo timmean -yearsum -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_referencePotET_2011_to_2100.nc CRU-TS3.23_ERA20C_referencePotET_2041_to_2060.nc
#~ cdo timmean -yearsum -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_referencePotET_2011_to_2100_rcp4p5.nc CRU-TS3.23_ERA20C_referencePotET_2041_to_2060_rcp4p5.nc
#~ 
#~ cdo timmean -yearavg -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_temperature_2011_to_2100_rcp2p6.nc CRU-TS3.23_ERA20C_temperature_2041_to_2060_rcp2p6.nc
#~ cdo timmean -yearsum -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_precipitation_2011_to_2100_rcp2p6.nc CRU-TS3.23_ERA20C_precipitation_2041_to_2060_rcp2p6.nc
#~ cdo timmean -yearsum -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_referencePotET_2011_to_2100_rcp2p6.nc CRU-TS3.23_ERA20C_referencePotET_2041_to_2060_rcp2p6.nc
#~ cdo timmean -yearavg -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_temperature_2011_to_2100_rcp6p0.nc CRU-TS3.23_ERA20C_temperature_2041_to_2060_rcp6p0.nc
#~ cdo timmean -yearsum -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_precipitation_2011_to_2100_rcp6p0.nc CRU-TS3.23_ERA20C_precipitation_2041_to_2060_rcp6p0.nc
#~ cdo timmean -yearsum -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/users/rens/data/GLO/forcing/CRU-TS3.23_ERA20C_GLO_daily_referencePotET_2011_to_2100_rcp6p0.nc CRU-TS3.23_ERA20C_referencePotET_2041_to_2060_rcp6p0.nc
#~ 
#~ cdo timmean -yearavg -seldate,1961-01-01,1990-12-31 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/tas_bced_1960-1999_hadgem2-es_historical_1951-2005.nc hadgem2-es_historical_temperature_1961_to_1990.nc
#~ cdo timmean -yearsum -seldate,1961-01-01,1990-12-31 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/pr_bced_1960-1999_hadgem2-es_historical_1951-2005.nc hadgem2-es_historical_precipitation_1961_to_1990.nc
cdo timmean -yearsum -seldate,1961-01-01,1990-12-31 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/epot_bced_1960_1999_hadgem2-es_hist_1951-2005.nc hadgem2-es_historical_referencePotET_1961_to_1990.nc

#~ cdo timmean -yearavg -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/tas_bced_1960-1999_hadgem2-es_2p6_2006-2099.nc hadgem2-es_2p6_temperature_2041_to_2060.nc
#~ cdo timmean -yearsum -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/pr_bced_1960-1999_hadgem2-es_2p6_2006-2099.nc hadgem2-es_2p6_precipitation_2041_to_2060.nc
cdo timmean -yearsum -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/epot_bced_1960-1999_hadgem2-es_2p6_2006-2099.nc hadgem2-es_2p6_referencePotET_2041_to_2060.nc

#~ cdo timmean -yearavg -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/tas_bced_1960-1999_hadgem2-es_4p5_2006-2099.nc hadgem2-es_4p5_temperature_2041_to_2060.nc
#~ cdo timmean -yearsum -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/pr_bced_1960-1999_hadgem2-es_4p5_2006-2099.nc hadgem2-es_4p5_precipitation_2041_to_2060.nc
cdo timmean -yearsum -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/epot_bced_1960_1999_hadgem2-es_4p5_2006-2099.nc hadgem2-es_4p5_referencePotET_2041_to_2060.nc

#~ cdo timmean -yearavg -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/tas_bced_1960-1999_hadgem2-es_6p0_2006-2099.nc hadgem2-es_6p0_temperature_2041_to_2060.nc
#~ cdo timmean -yearsum -seldate,2041-01-01,2060-12-31 /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/pr_bced_1960-1999_hadgem2-es_6p0_2006-2099.nc hadgem2-es_6p0_precipitation_2041_to_2060.nc
cdo timmean -yearsum -seldate,2041-01-01,2060-12-31  /projects/0/dfguu/data/hydroworld/forcing/CMIP5/ISI-MIP-INPUT/HadGEM2-ES/epot_bced_1960_1999_hadgem2-es_6p0_2006-2099.nc hadgem2-es_6p0_referencePotET_2041_to_2060.nc
