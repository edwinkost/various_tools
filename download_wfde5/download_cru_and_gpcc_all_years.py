#!/usr/bin/env python
# -*- coding: utf-8 -*-

import cdsapi

c = cdsapi.Client()

c.retrieve(
    'derived-near-surface-meteorological-variables',
    {
        'version': '1.1',
        'format': 'tgz',
        'reference_dataset': 'cru_and_gpcc',
        'variable': [
            'rainfall_flux', 'snowfall_flux',
        ],
        'year': [
            '1979', '1980', '1981',
            '1982', '1983', '1984',
            '1985', '1986', '1987',
            '1988', '1989', '1990',
            '1991', '1992', '1993',
            '1994', '1995', '1996',
            '1997', '1998', '1999',
            '2000', '2001', '2002',
            '2003', '2004', '2005',
            '2006', '2007', '2008',
            '2009', '2010', '2011',
            '2012', '2013', '2014',
            '2015', '2016', '2017',
            '2018',
        ],
        'month': [
            '01', '02', '03',
            '04', '05', '06',
            '07', '08', '09',
            '10', '11', '12',
        ],
    },
    'download_wfde5_cru_and_gpcc.tar.gz')
