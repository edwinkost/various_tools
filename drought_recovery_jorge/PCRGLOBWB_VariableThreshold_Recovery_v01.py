#!/usr/bin/env python
# coding: utf-8

# In[1]:


# This code apply the recovery fx to each pixel output from PCRGLOBW2


# In[12]:


import time
import xarray as xr
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
import matplotlib.gridspec as gridspec
import dask
from dask.diagnostics import ProgressBar
from scipy.signal import argrelextrema
from scipy import stats
import cartopy.crs as ccrs
import cartopy.feature as cfeature
import datetime
from datetime import date, timedelta
from tqdm.auto import tqdm, trange # [elapsed < remaining, it/s]
import multiprocessing as mp
from multiprocessing import Pool


# In[ ]:


# from dask.distributed import Client

# client = Client("tcp://127.0.0.1:64719")
# client


# In[3]:


# Import data


# In[11]:

# Model Output
fp = r'/eejit/home/vegab002/PCR-GLOBWB_recovery/input/WDemand/gwRecharge_dailyTot_output.nc'
gwr_wdm = xr.open_mfdataset(fp, chunks= {'time':10,'lat':10, 'lon':10})
gwr_wdm = gwr_wdm.sel(time=slice('1990-01-01', '2020-12-31'))

# In[7]:


# Fx: Recovery


# In[13]:


def normalization_CDF(data):
    """ 
    Fx normalize a dataframe based on the order of the values.
    The df should have two columns, Time as index and another with values.
    """
# ----------------------------------------------------------------------------
	#Put data in dataframe
    randomData = pd.DataFrame(data)
#     print('randomData1:', randomData)
    #Rename
    randomData.columns = ['values']
#     randomData.reset_index(inplace=True)
#     print('randomData2:', randomData)
	#Add index for backtransformation
    randomData["num"] = np.arange(len(randomData))
#     print('randomData3:', randomData)
    
	#Sort data based on the input data values
#     sortDF = randomData.sort_values(by=['values']) # The Date should stay with their value!!
#     sortDF = (randomData.assign(key=randomData.groupby('time')['values'].transform('min'))
#              .sort_values(['key','time','values'], ascending=False, ignore_index=True)
#              .drop(columns=['key']))
    sortDF = randomData.sort_values(by='values', kind='mergesort')
#     print('sortDF:', sortDF)
	#Find length of timeseries
    length = len(data)
#     print('length:',length)
	## Perform normalization on sorted data
    sortDF['normalized'] = np.arange(length)/(length-1)
#     print('sortDF:', sortDF)
	## Put data back in place based on original index
    outputDF = sortDF.sort_values(by='time') # This is not working!!
	## Return output as dataframe
    return(pd.DataFrame(outputDF['normalized']))

# 7. Find_droughts_Fixed_Threshold
def Find_droughts_Fixed_Threshold(data, FT):
    """
    Find droughts based on fixed threshold.
    If percentile is too low, uses 10%
    """
    # data = df_Qi
    # FT = 10
    
    # Dataset to DF
    df = pd.DataFrame(data)
    # Drop no values
    df = df.dropna()    
    # Find threshold
    percentile = np.percentile(df, FT)
    if (percentile <= 0.001):
        percentile = 0.01 # Check if this is possible!
    # Apply threshold (values under threshold)
    df_FT = df[df < percentile]
    # Drop no values
    df_FT = df_FT.dropna()
    
    return(df, df_FT, percentile) # Original DF, Droughts DF

def get_drought_variable_threshold(randomData, start, end):
    """"
    Fx creates a pandas DF with a variable threshold based on the provided data
    Input: 
        DF with time series (format: index-date, col-variable)
    Output:
        DF values under the threshold
        DF with deficit
    """
    # Calculation of Variable Threshold
    date = pd.date_range(start, end, freq='1d')
    var_threshold = pd.DataFrame(columns=[], index = date)
    deficit = pd.DataFrame(columns=[], index = date)
    
    #1. to dataframe
    df = pd.DataFrame(randomData)
    
    #2. add column with dates
    df['date'] = df.index
    
    #3. add a column with number of months
    df['month'] = pd.DatetimeIndex(df['date']).month
    df = df.drop(columns=['date'])
    
    #4. select each month with month column value -> groups and percentile!!
    df_dropna = df.dropna() # for calculations of avg of months
    VT_i = df.groupby('month').mean().round(2)
    
    #5. Drop date and month column from discharge data
    df = df.drop(columns=['month'])
#     print('df:', df)
    
    #6. Create DF of Variable Threshold - Normal Year
    data = {'Month':['1913/01','1913/02','1913/03','1913/04','1913/05','1913/06',
                     '1913/07','1913/08','1913/09','1913/10','1913/11','1913/12'],\
         'VT': [VT_i.iloc[0].values, VT_i.iloc[1].values, VT_i.iloc[2].values, VT_i.iloc[3].values, 
                VT_i.iloc[4].values, VT_i.iloc[5].values, VT_i.iloc[6].values, VT_i.iloc[7].values, 
                VT_i.iloc[8].values, VT_i.iloc[9].values, VT_i.iloc[10].values, VT_i.iloc[11].values]}
    
    df_months = pd.DataFrame(data, columns =['Month', 'VT'])
    df_months['time'] = pd.to_datetime(df_months['Month'])
    df_months = df_months.set_index('time')
    
    dates = pd.date_range('1913-01-01', '1913-12-31', freq='D')
    df_daily = df_months.reindex(dates, method = 'ffill')
    
    arr = df_daily['VT'].values
    df_3years = pd.DataFrame(np.tile(arr, (3)))
    arr_3years = df_3years.values
    
    #8. Create DF of Variable Threshold - Leap Year
    leap = {'Month':['1912/01','1912/02','1912/03','1912/04','1912/05','1912/06',
                     '1912/07','1912/08','1912/09','1912/10','1912/11','1912/12'],\
         'VT': [VT_i.iloc[0].values, VT_i.iloc[1].values, VT_i.iloc[2].values, VT_i.iloc[3].values, 
                VT_i.iloc[4].values, VT_i.iloc[5].values, VT_i.iloc[6].values, VT_i.iloc[7].values, 
                VT_i.iloc[8].values, VT_i.iloc[9].values, VT_i.iloc[10].values, VT_i.iloc[11].values]}
    df_leap_months = pd.DataFrame(leap, columns =['Month', 'VT'])
    df_leap_months['time'] = pd.to_datetime(df_leap_months['Month'])
    df_leap_months = df_leap_months.set_index('time')
    dates_leap = pd.date_range('1912-01-01', '1912-12-31', freq='D')#because need to fit with leap years
    df_leap_daily = df_leap_months.reindex(dates_leap, method = 'ffill')
    df_leap_daily = df_leap_daily.drop(columns = ['Month'])
    arr_leap = df_leap_daily.values
    
    # 9.Merge 'arr'(normal) with 'arr_leap'(leap year) = total 4 years
    arr_leap = np.squeeze(arr_leap)
    arr_3years = np.squeeze(arr_3years)
    allDays = np.concatenate((arr_leap, arr_3years))
    df_alldays = pd.DataFrame(np.tile(allDays, (28)))
    
    # 10. Define the Variable threshold Time series for all period
    dates_allyears = pd.date_range('1912-01-01', '2023-12-31', freq='D')#Because the years should fit in 4 years periods
    df_alldays['time'] = pd.to_datetime(dates_allyears)
    df_alldays = df_alldays.set_index('time')
    VT_Ni = df_alldays.loc[start:end]#Reduce to the working date
    VT_Ni.columns = ['VT']
    VT_Ni = VT_Ni.astype('float64')
    VT_Ni = VT_Ni.rename(columns={'VT':'normalized'})
#     print('VT_Ni:', VT_Ni)
    
    #11. Values under Variable Threshold
#     VT_Ni = VT_Ni.reset_index()
#     df = df.reset_index()
    VT_df = df[df < VT_Ni]
    VT_df = VT_df.dropna()
#     print('VT_df:', VT_df)
    
#     VT_df_dropna_i = VT_df.dropna()
    
#     #12. Missing volume
#     VT_deficit = (VT_Ni - VT_df)
    
#     #Compilation of values
#     var_threshold = var_threshold.join(VT_df)
#     deficit = deficit.join(VT_deficit)
    
    return VT_df, VT_Ni # df Under threshold, Variable Threshold


# 8. Count_droughts
def Count_droughts(data):
    """
    Fx: Count droughts
    Input: 
        Discharge with Threshold applied to the DF, 
        only values under threshold (dates missing over threshold)
    # Output: 
        Original(df), 
        Day-breaks(filt), 
        Droughts (groups)
    """    
    #data = FT_df_Qi

    # To DataFrame
    df = pd.DataFrame(data)
    # Add time
    df['Time'] = df.index
    # Get Time column
    dt = df['Time']
#     print('df:', df)
    # Define day
    day = pd.Timedelta('1d')
    # Split continue and break days as condition (True, False)
    in_block = ((dt - dt.shift(-1)).abs() == day) | (dt.diff() == day) # | : or # (Time - Time shifted 1 day before)| Time difference with previous row 
#     print('in_block:', in_block[0:30])
    # Fit breaks with DF (apply the condition)
    filt = df.loc[in_block]
#     print('filt:', filt[30:60])
    
    # Find only breaks
    breaks = filt['Time'].diff() != day # Difference with previous ROW! Not equal as 1 day
#     print('breaks1:', breaks)
    # Rename DF
    breaks = breaks.rename('Drought')
#     print('breaks2:', breaks)
    # Group the breaks
    groups = breaks.cumsum()
    # To DF
    groups = pd.DataFrame(groups)
    # Add Date to DF
    groups['Date'] = groups.index
    
    ## Count amount of consecutive days
    # Group consecutive days in a column
    s = groups.groupby('Drought').Date.diff().dt.days.ne(1).cumsum()
    # Sum droughts consecutive days
    groups_count_i = groups.groupby(['Drought', s]).size().reset_index(level=1, drop=True)
    # Select ONLY droughts with more than 10 days
    groups_count_i = groups_count_i[groups_count_i > 10] # Selection of droughts higher than 10 days
    
    # Select only droughts with >10 days long
    groups = groups.loc[groups['Drought'].isin(groups_count_i.index)]   
    # Drop extra column 'Date'
    groups = groups.drop(columns = 'Date')
    # Select drought column
    groups = groups['Drought']
    
    # Merge orginal with droughts>10days
    df = df.merge(groups, left_index = True, right_index = True)
    # Drop 'Time'
    df = df.drop(columns=['Time'])
    #df = df.dropna()
    # Count droughts over 10 days
    df = df.groupby('Drought').count()
    df = df.rename(columns={'Q':'Drought_days'})
    df = df.reset_index()
    
    return(df, filt, groups) # df, Droughts period higher than 10 days!

#9. Composite_analysis days after drought aligned
def Composite_analysis_droughtdays(data, filt, groups):
    """"
    Input:
        data: Dischage (data_Q), kNDVI, or SoilMoisture 
        filt: Day-breaks of Discharge, droughts (filt), 
        groups: Droughts >10 days
    Output:
        Each drought > 10 days (df_Q_append)
    """    
    # Add discharge
    df_Q = pd.DataFrame(data)
    df_Q = df_Q.dropna()# Drop missing
    df_Q['Time'] = pd.to_datetime(df_Q.index, errors='coerce')# Add time column
    
    # Select the start of drought
    start = filt.groupby(groups).first()
    # Use index to count 
    start = start.reset_index()
    
#     # Count month where dought starts
#     months = start['Time'].groupby([start.Time.dt.month]).agg('count')
#     months = pd.DataFrame(months)
    
    # Empty Df to append
    start_end = pd.DataFrame(columns=[])
    
    if start.empty:
      start_end.empty
      
    else:
      for v in range(1, start.index[-1]+1): # Why not zero?
          #print(v)
          
          # Select day
          start_date = start[start.index == v]
          # Define first and last day
          start_date = start_date.iloc[0]['Time']
          
          # problem if its 29 of february! CHECK THIS!
          try:
              end_date = date(start_date.year + 1, start_date.month, start_date.day) # range of time
              end_date = pd.to_datetime(end_date)
          
          except:
              end_date = date(start_date.year + 1, start_date.month, start_date.day-1) # range of time
              end_date = pd.to_datetime(end_date)
      
          start_end = start_end.append({'start_date': start_date,'end_date': end_date}, ignore_index=True)
  #         print('start_end:', start_end)
    
        # Append all the start_dates and end_dates?
    return (start_end)

# 10.Composite Analysis
def Composite_analysis_recovery(data, start_end): #DOESNT WORK WITH ONLY ONE DROUGHT, or EXPONENTIAL DATA!
    """
    Input:
        data: Discharge, kNDVI, SM (data)
        start_end: Drought start and one year after the event (start_end)
    Output:
        DF, drought dates as headers and one year after
        start of the drought, end one year after
    """
# --------------------------------------------------------------------------------------------------
    # Add discharge
    df = pd.DataFrame(data)
    df = df.dropna()# Drop missing
    df['Time'] = pd.to_datetime(df.index, errors='coerce')# Add time column
#     print('df_recovery:', df)

    df_append = pd.DataFrame(columns=[])
    df_append_avg = pd.DataFrame(columns=[])
    
#     print('len(start_end):', len(start_end))
    ## Select periods
    for x in range (0,len(start_end)):
#         print('Loop:', x)
        # Select drought start
        start_date = start_end[start_end.index == x]
        start_date = start_date.iloc[:,0].to_list()
        start_date = pd.to_datetime(start_date)
        start_date = start_date.strftime('%Y-%m-%d')
        start_date = str(start_date)[8:18]
#         print('start_date:',start_date)
        # Select drought end
        end_date = start_end[start_end.index == x]
        end_date = end_date.iloc[:,1].to_list()
        end_date = pd.to_datetime(end_date)
        end_date = end_date.strftime('%Y-%m-%d')
        end_date = str(end_date)[8:18]
#         print('end_date:', end_date)
        
        # Get DF values between two dates
        df_recov = df.loc[start_date : end_date]
#         print('df_recov: ', df_recov)
        ## Discharge Recovery
        df_recov = df_recov.drop(columns={'Time'}) #remove column with 'Time'
        df_recov = df_recov.reset_index(drop=True) # drop the date 'index'
        df_recov = df_recov.rename(columns={df_recov.columns[0]:'%s'%(start_date)}) #rename with first day of drought
#         print('df_recov:', df_recov)
#         print('df_recov dtypes:', df_recov.dtypes)
        df_recov = df_recov.astype('float64') # ERROR!! TypeError: Cannot cast DatetimeArray to dtype float64
        # Append Q (All droughts in different columns)
        df_append = df_append.append(df_recov, ignore_index = True)
        # Errase all the nans (keeping rows that dont match)
        df_append = df_append.apply(lambda x: pd.Series(x.dropna().values))
#         print('df_append',df_append)
        ## Remove nodata-rows from Q
        df_append = df_append[0:365]
        df_append = df_append.clip(lower=0) # ERROR!! TypeError: Invalid comparison between dtype=datetime64[ns] and int
        #df_append['avg'] = df_append.mean(numeric_only=True, axis=1) #Add avg column
        df_append_avg = df_append.mean(numeric_only=True, axis=1)
        df_append_avg = df_append_avg.rename('avg', inplace=True)
        #df_append_avg = df_append['avg']
        df_append_avg = pd.DataFrame(df_append_avg)
#         print('df_append_avg', df_append_avg)

    return df_append, df_append_avg

# 11. Drought Termination - from Perry et al.,(2016). (Drought termination: Concept and characterisation)
def Drought_termination(df):
    """
    This fx does time-series analysis, finding max and min peaks, and other points. First, TM is obtained.
    If TM is zero (passed the threshold but goes under 0.5 inmediately) go to the second index.
    If TM never reaches 0.5, no recovery, TM is NAN.
    
    Input: 
        Drought Composite analysis (each drought from t=0)
    Output: 
        Maximum negative anomaly at t-st (DM)
        Positive anomaly at t-et (TM)-> Peak after recovery pass 0.5
        Drought Termination Duration (DTD = tet - tst + 1) or (DTD=TM-DM)
        Drought Termination Rate (DTR) = (TM-DM)|DTD
    """
#------------------------------------------------------------------------------
    # Get DF
    df = pd.DataFrame(df)
    df_avg = df['avg']
    # Get peaks
    ilocs_min = argrelextrema(df_avg.values, np.less_equal, order = 7)[0] # index of min peaks
    ilocs_max = argrelextrema(df_avg.values, np.greater_equal, order = 7)[0] # index of max peaks
    # Get peaks values (based on:https://eddwardo.github.io/posts/2019-06-05-finding-local-extreams-in-pandas-time-series/)
    df['weekly_max'] = False
    df['weekly_min'] = False
    df.loc[df.iloc[ilocs_min].index, 'weekly_min'] = True
    df.loc[df.iloc[ilocs_max].index, 'weekly_max'] = True
#     print('df', df)
    # Conditions to get TM
    TM1 = df[(df['weekly_max'] == True)] # Consider only high peaks
#     print('TM1:', TM1)
    
    # If TM never reach 0.5, no recovery (# IndexError: # index 0 is out of bounds for axis 0 with size 0)
    try:
        # get first peaks over 0.5 index
        TM = TM1[(TM1['avg'] > 0.5)].index[0] 

        # If TM is ZERO get the second peak
        if TM == 0:
            TM = TM1[(TM1['avg'] > 0.5)].index[1]

        #(*) If TM is not zero but SMALL and there are not low peaks before.
        for i in range(1, len(ilocs_max)):
            try: # if df[(df.index < TM)] > 0 ???
                # Get the minimum value before the first high peak over 0.
                # Only use values under TM
                DM = df[(df.index < TM)]
                DM = pd.DataFrame(DM.avg[(DM['avg'] < 0.5).values]).idxmin()[0]
            except:          
                TM = TM1[(TM1['avg'] > 0.5)].index[i]
                pass

        DM = df[(df.index < TM)]
        DM = pd.DataFrame(DM.avg[(DM['avg'] < 0.5).values]).idxmin()[0]

        # Drought Termination Duration (DTD) DTD = tet - tst + 1; TM-DM
        DTD = TM - DM
        # Vegetation Drought Termination Rate ( VDTR=(TM-DM)|DTD )
        VDTR = (TM - DM)/DTD
        
    except:        
        TM = np.NaN
        DM = np.NaN
        DTD = np.NaN
        VDTR = np.NaN
        ilocs_min = np.NaN
        ilocs_max = np.NaN
        df = np.NaN
    
    return (DM, TM, DTD, VDTR, ilocs_min, ilocs_max, df)

def pre_process_recovery(ds):
    """ 
    This fx pre-process the outputs from PCR-GLOBWB2 at 5km resolution for 
    recovery calculations.
    """
    ds = ds.to_dataframe().unstack()
    ds = ds.reset_index().drop(columns=['lat'], axis=1, level=0)# ***PerformanceWarning))
    ds = ds.droplevel(level=1, axis=1).set_index('time')
    return ds

def drought_recovery(ds):
    """
    This fx calculate the recovery with a variable threshold for a given time series.
    For this purpose compile all the fx necessary and provide DT and/or DTD 
    """
# Pre-process the time series obtained from the 'times' axis of a xr.Dataset
    ds = pre_process_recovery(ds)
# ------------------------------------------------------------------------------------------------   
#     # Plot initial variable
#     ds.plot(y=ds.columns[0])
#     plt.show()
# ------------------------------------------------------------------------------------------------
    # CDF Normalization 
    df_Qnorm = normalization_CDF(ds)#df_Qi)
#     print('df_Qnorm:', df_Qnorm)

# #----------------------------------------------------------------------------------------------
    ## Determination of Discharge Drought with Fixed Threshold

#     df_Qnorm, FT_df_Qi, percentile = Find_droughts_Fixed_Threshold(df_Qnorm, 10) # Original, ONLY underthreshold, perc
# #     df_Qnorm = df_Qnorm.astype(float)
# #     FT_df_Qi = FT_df_Qi.astype(float)
# #     print('df_Qnorm:', df_Qnorm)
#     print('FT_df_Qi:', FT_df_Qi)
# #     print('percentile:', percentile)
#     # Count Droughts
#     count, filt, groups = Count_droughts(FT_df_Qi) # from Fixed threshold output

# # # ------------------------------------------------------------------------------------------
    # Plot Fixed Threshold

#     df_plot = pd.merge(df_Qnorm, FT_df_Qi, how='outer', left_index=True, right_index=True)
# #     print('df_plot:',df_plot)
    
#     # Plot variables and threshold
#     ax = df_plot.plot()
#     ax.axhline(y=percentile, color='r', linestyle='--')
#     ax.set_xlim(pd.Timestamp('1978-01-01'), pd.Timestamp('2020-12-31'))
#     plt.show()
    
#     # Plot every-year
#     start_date = date(1980, 1, 1)
#     end_date = date(2020, 12, 31)
#     delta = timedelta(days=365)
#     while start_date <= end_date:
#         #         print(start_date.strftime("%Y-%m-%d"))
#         ax = df_plot.plot()
#         ax.axhline(y=percentile, color='r', linestyle='--')
#         ax.set_xlim(start_date, start_date+delta)
#         plt.show()
#         start_date += delta
# # -------------------------------------------------------------------------------------------
    # Variable Threshold
    df_ut, var_th = get_drought_variable_threshold(df_Qnorm, '1990-01-01', '2020-12-31')
#     print('df_ut:', df_ut)
# --------------------------------------------------------------------------------------------
#     # Plot Variable Threshold

#     # Pre-process
#     df_plot = pd.merge(df_ut, var_th, how='outer', left_index=True, right_index=True)
#     df_plot = pd.merge(df_plot, df_Qnorm, how='outer', left_index=True, right_index=True)
#     df_plot = df_plot[['normalized','normalized_x','normalized_y']]
#     df_plot.columns = ['over_threshold', 'under_threshold', 'variable_threshold']
#     print('df_plot:', df_plot)
    
#     # Plot all data
#     ax = df_plot.plot()
#     ax.set_xlim(pd.Timestamp('1978-01-01'), pd.Timestamp('2020-12-31'))
#     plt.show()
#     # Plot every-year
#     start_date = date(1978, 1, 1)
#     end_date = date(2020, 12, 31)
#     delta = timedelta(days=365)
#     while start_date <= end_date:
#         ax = df_plot.plot()
#         ax.set_xlim(start_date, start_date+delta)
#         plt.show()
#         start_date += delta
# ---------------------------------------------------------------------------------------------
    # Count Droughts
    count, filt, groups = Count_droughts(df_ut) # from Variable threshold output
#     print('count:', count)
#     print('filt:', filt)
#     print('groups:', groups)

    ## Composite Analysis: 
    df_Qnorm = df_Qnorm.dropna().drop(columns=['date','month']) # ADD TO FIX VT Error!
#     print('df_Qnorm:', df_Qnorm)
    start_end = Composite_analysis_droughtdays(df_Qnorm, filt, groups) # Find Drought days
#     print('start_end:', start_end)
    Qc, Qc_avg = Composite_analysis_recovery(df_Qnorm, start_end)
#     print('Qc:', Qc)
#     print('Qc_avg:', Qc_avg)

    if start_end.empty: # if there are no ending droughts
#         print('start_end is empty: ', start_end.empty)
        TM = np.NaN
    else:
        # Drought Terminarion (TM is DT)
        DM, TM, DTD, DTR, ilocs_min, ilocs_max, df = Drought_termination(Qc_avg)
    #     print('DM:', DM)
    #     print('TM:', TM) # Drought Termination
    #     print('DTD:', DTD) # Drought Termination Duration
    #     print('DTR:', DTR)
    #     print('ilocs_min:', ilocs_min)
    #     print('ilocs_max:', ilocs_max)
    #     print('df:', df)

        return TM#.astype('float64')#, DTD


# # Loop

# In[14]:


# Run drought recovery

# ds = gwr_nwdm

def parallel_recovery(ds, clusters):
    """
    This fx calculate the recovery per-pixel and add it to a new xr.dataset
    Input:
        ds: xr.dataset
        clusters: number of latitudes to split the calculations
    """
    # ds = gwr_wdm
    
    # Create empty DataSet
    variables = ['GWR']
    # rng = pd.date_range(start = '1978-01-01', end = '2020-12-31')

    S = np.zeros((len(ds.lat.values),
                  len(ds.lon.values)), 
                 dtype = np.float64) # empty time-step


    v = (('lat', 'lon',), S) # coordinates + variable
    h = {k:v for k in variables}

    # Define empty DataSet Variables
    ds_data = xr.Dataset(data_vars=h, coords={'lat': ds['lat'].values, 'lon': ds['lon'].values})
    # print('ds_data1:', ds_data)

    for i in ds_data.lat: #generate nan values IN TIME. Selecting the same file!*
        ds_data['GWR'].loc[dict(lat=i)] = ds_data['GWR'].sel(lat=i)*np.nan
    for i in ds_data.lon:
        ds_data['GWR'].loc[dict(lon=i)] = ds_data['GWR'].sel(lon=i)*np.nan
    # print('ds_data2:', ds_data)


    for (j,k) in enumerate(clusters): # count, value

        for i in trange(k-5, k): #len(ds.lat.values)): # change for parallellization

            for v in trange(0,len(ds.lon.values)):
        #         print('lat num:', i)
                print('lon num:', v)

        #         for_loop_start_time = time.time()

                # Get lat and lon values
                lat_i = (ds.lat[i].values).astype(str)
        #         print('lat_i:', lat_i)
                lon_i = (ds.lon[v].values).astype(str)
        #         print('lon_i:', lon_i)

                # Select lat and lon
                df_i = ds.isel(lat=[i], lon=[v])
        #         print('df_i:', df_i)

                # Fx recovery
                df = drought_recovery(df_i)
    #             print('Recovery:', df)

                # Insert value to dataset
                ds_data['GWR'].loc[dict(lat=lat_i, lon=lon_i)] = df 

        #         for_loop_end_time = time.time()
        #         print("Time using the for loop: {} min".format((for_loop_end_time - for_loop_start_time)/60))

            v+1
        i+1
        ds_data.to_netcdf(r'/eejit/home/vegab002/PCR-GLOBWB_recovery/output/WDemand/GWR_T_%s.nc' % k)   
    j+1


# In[18]:

cluster = list(range(145, 517, 5)) # all latitudes
# cluster = list(range(15,517,5)) # missing 516, 517
# cluster = list(range(215,250,5)) # 
# cluster = list(range(357,370,5)) # test
# cluster = list(range(360,515,5)) #
#print(cluster)


# In[ ]:


# parallel_recovery(gwr_nwdm, cluster)
# parallel_recovery(gwr_wdm, cluster)


# In[6]:


# if __name__ == '__main__':
#    with Pool(96) as p:
#        results = p.starmap(parallel_recovery, [(gwr_wdm, c) for c in cluster])
#        print(p.map(parallel_recovery, (cluster,)))
#        print(results)

if __name__ == '__main__':

    # Model Output
    fp = r'/eejit/home/vegab002/PCR-GLOBWB_recovery/input/WDemand/gwRecharge_dailyTot_output.nc'
    gwr_wdm = xr.open_mfdataset(fp, chunks =  {'time':10,'lat':10, 'lon':10})
    gwr_wdm = gwr_wdm.sel(time=slice('1990-01-01', '2020-12-31'))

    cluster = list(range(145, 517, 5))
    
    ncores = 2
    pool = Pool(processes = ncores)
    pool.map(parallel_recovery, [(gwr_wdm, c) for c in cluster])
    
    pool.terminate()
    pool.join()

# mp.cpu_count()


# In[ ]:


# https://stackoverflow.com/questions/72278311/performancewarning-dropping-on-a-non-lexsorted-multi-index-without-a-level-para


# In[ ]:


# Parallel computing
# https://www.machinelearningplus.com/python/parallel-processing-python/
# https://blog.esciencecenter.nl/parallel-programming-in-python-7fd62c90217d
# https://www.delftstack.com/howto/python/python-pool-map-multiple-arguments/
# https://e2eml.school/multiprocessing.html
# https://superfastpython.com/multiprocessing-pool-apply_async/
# https://superfastpython.com/multiprocessing-pool-apply/
# https://stackoverflow.com/questions/8533318/multiprocessing-pool-when-to-use-apply-apply-async-or-map
# https://docs.python.org/3/library/multiprocessing.html


# In[ ]:


# https://www.earthdatascience.org/courses/use-data-open-source-python/intro-raster-data-python/raster-data-processing/classify-plot-raster-data-in-python/


# In[ ]:


# https://gto76.github.io/python-cheatsheet/


# # 1st try with APPLY_UFUNC

# In[ ]:


# https://docs.xarray.dev/en/stable/generated/xarray.apply_ufunc.html
# https://stackoverflow.com/questions/58719696/how-to-apply-a-xarray-u-function-over-netcdf-and-return-a-2d-array-multiple-new


# In[15]:


# def recovery_gufunc1(x):
#     return drought_recovery(x)#, keepdims=True)

# # def recovery_gufunc2(x):
# #     return recovery_gufunc1(x)

# def recovery_ufunc(x, dim='time'):
#     return xr.apply_ufunc(
#         recovery_gufunc1, x,
#         input_core_dims=[[dim]], # The dimension thats going to be remove (output can add a new one)
#         vectorize=True,
#         dask='parallelized',
# #         output_dtypes=[gwr_nwdm.dtype])
#         output_dtypes=[float])
# #         output_dtypes=[np.complex])


# In[1]:


# %%time

# with ProgressBar():
#     recovery = recovery_ufunc(gwr_nwdm.chunk({'time': -1})).compute()
#     print(recovery) # MemoryError: (2hr 13min 19.6s)


# In[ ]:


# recovery = xr.apply_ufunc(recovery_ufunc,
#                           gwr_nwdm.groundwater_recharge.chunk(),
#                           dask='parallelized',
#                           output_dtypes=[gwr_nwdm.groundwater_recharge.dtype],
#                           kwargs={'axis': 0}).compute()


# In[ ]:


# recovery = xr.apply_ufunc(lambda x: drought_recovery(x, axis=-1),
#                           gwr_nwdm.groundwater_recharge.chunk({'time': -1}),
#                           dask='parallelized',
#                           input_core_dims=[['time']])


# In[ ]:


# %%time

# # Export result
# recovery.to_netcdf(path=r'g:\UU\0.Data\PCR-GLOBWB\Intermediate_netcdf\recovery.nc', format='NETCDF4')


# In[ ]:


# %%time

# # plot
# recovery.groundwater_recharge.plot() #TypeError: drought_recovery() got an unexpected keyword argument 'axis'


# # 2nd try with MAP

# In[ ]:


# recovery = gwr_nwdm.map(normalization_CDF)


# # 3rd with map_blocks

# In[ ]:


# https://docs.xarray.dev/en/stable/generated/xarray.map_blocks.html

# example:
# https://stackoverflow.com/questions/72225043/applying-a-function-to-each-timestep-in-an-xarray-dataset-and-return-lazy-dask
# https://gist.github.com/jhamman/3d044f7a35b951365285478f6bc379cd
# https://ncar.github.io/esds/posts/2021/map_blocks_example/
# https://climate-cms.org/posts/2021-11-24-api.html


# # 4th try. Only one pixel

# In[11]:


# get_ipython().run_cell_magic('time', '', '# Time to load the datasets \n# one_pixel = one_pixel.to_dataframe().unstack()\n\n# Chunks \n# lat=100, lon=100, time=-1 (Wall time: 2min 51s)\n# lat=10, lon=10, time=-1 (Wall time: 2min 51s)\n# lat=1000, lon=1000, time=-1 (Wall time: 7min 4s)\n# lat=500, lon=500, time=-1 (Wall time: 7min 21s)\n# lat=100, lon=100, time=100 (Wall time: 2min 55s)\n# lat=10, lon=10, time=10 (Wall time: 3.66 s)\n# lat=100, lon=100, time=100 (Wall time: 2min 56s)\n# lat=5, lon=5, time=5 (Wall time: 3min 6s)')


# # Pixel 200, 200

# In[2]:


# %%time

# one_pixel = gwr_nwdm.groundwater_recharge.isel(lat=[200], lon=[200])
# print(one_pixel)


# In[3]:


# %%time

# # one_pixel2 = one_pixel.reset_index().drop(columns=['lat'])
# # # print(one_pixel2)
# # one_pixel2 = one_pixel2.droplevel(1, axis=1).set_index('time') # remove second column name
# # print(one_pixel2)
# # print(one_pixel2.index.dtype)

# # DM, TM, DTD, DTR, ilocs_min, ilocs_max, df = drought_recovery(one_pixel2)
# DT = drought_recovery(one_pixel)
# print('DT:', DT) # DT is a 'numpy.int64'


# # Pixel 100,100

# In[4]:


# %%time

# one_pixel100 = gwr_nwdm.groundwater_recharge.isel(lat=[100], lon=[100]).to_dataframe().unstack()
# print(one_pixel100)


# In[5]:


# %%time

# one_pixel2100 = one_pixel100.reset_index().drop(columns=['lat'])
# # print(one_pixel2)
# one_pixel2100 = one_pixel2100.droplevel(level=1, axis=1).set_index('time') # remove second column name
# # print(one_pixel2100)
# # print(one_pixel2100.index.dtype)

# DT = drought_recovery(one_pixel2100)
# print('DT:', DT) # DT is a 'numpy.int64'


# # Pixel lat3, lon74; Error: Cant reach recovery 0.5

# In[6]:


# %%time

# one_pixel = gwr_nwdm.groundwater_recharge.isel(lat=[3], lon=[74])#.to_dataframe().unstack()
# print(one_pixel)


# In[7]:


# %%time

# DT = drought_recovery(one_pixel)
# print('DT:', DT) # DT is a 'numpy.int64'


# # Pixel lat=22, lon=31: KeyError: 'avg' (line 353: Drought Termination, no 'avg' col in df input)

# In[8]:


# %%time

# one_pixel = gwr_nwdm.groundwater_recharge.isel(lat=[22], lon=[31])#.to_dataframe().unstack()
# print(one_pixel)


# In[9]:


# %%time

# DT = drought_recovery(one_pixel)
# print('DT:', DT) #


# # Pixel lat: 355+4, lon?

# In[ ]:





# # Location of pixels in study area

# In[ ]:


# # Location of pixels

# # import cartopy.crs as ccrs

# # da = gwr_nwdm.groundwater_recharge.isel(time=0)
# # ax = plt.subplot(projection=ccrs.PlateCarree())
# # da.plot.pcolormesh(x="lon", y="lat", ax=ax)
# # ax.scatter(lon, lat, transform=ccrs.PlateCarree())
# # ax.coastlines()
# # ax.gridlines(draw_labels=True)



# lat = gwr_nwdm.lat.isel(lat=[100]).values
# print('lat:', lat)
# lon = gwr_nwdm.lon.isel(lon=[100]).values
# print('lon:', lon)


# ax = plt.axes(projection=ccrs.PlateCarree())
# plt.title('South America')
# ax.set_extent([-40, -100, -60, -10], ccrs.PlateCarree())
# ax.coastlines(resolution='110m')
# ax.stock_img()

# da = gwr_nwdm.groundwater_recharge.isel(time=0)
# cmap = plt.cm.get_cmap('RdBu').copy()
# cmap.set_bad('black', 0)
# # np.ma.masked_array(z, z < -.5)
# da.plot.pcolormesh(x="lon", y="lat", ax=ax)
# plt.plot(lon, lat,  markersize=5, marker='o', color='red')
# plt.plot(lon, lat,  markersize=5, marker='o', color='orange')
# plt.show()

