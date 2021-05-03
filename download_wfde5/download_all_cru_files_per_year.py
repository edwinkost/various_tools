#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

import cdsapi

c = cdsapi.Client()

year = str(sys.argv[1])


c.retrieve(
    'derived-near-surface-meteorological-variables',
    {
        'version': '1.1',
        'format': 'zip',
        'variable': [
            'grid_point_altitude', 'near_surface_air_temperature', 'near_surface_specific_humidity',
            'near_surface_wind_speed', 'rainfall_flux', 'snowfall_flux',
            'surface_air_pressure', 'surface_downwelling_longwave_radiation', 'surface_downwelling_shortwave_radiation',
        ],
        'reference_dataset': 'cru',
        # ~ 'year': '2018',
        'year': str(year),
        'month': [
            '01', '02', '03',
            '04', '05', '06',
            '07', '08', '09',
            '10', '11', '12',
        ],
    },
    # ~ 'download.zip'
    'wfde5_cru_' + str(year) + '.zip'
    )
