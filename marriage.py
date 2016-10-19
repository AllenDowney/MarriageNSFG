"""This file contains code for use with "Think Stats",
by Allen B. Downey, available from greenteapress.com

Copyright 2014 Allen B. Downey
License: GNU GPLv3 http://www.gnu.org/licenses/gpl.html
"""

from __future__ import print_function, division

import bisect

import numpy as np
import pandas as pd

import gzip
import matplotlib.pyplot as plt

from collections import defaultdict
from collections import OrderedDict
from collections import Counter

import thinkstats2
import thinkplot

import survival


def ResampleResps(resps, remove_missing=False, jitter=0):
    """Resamples each dataframe and then concats them.

    resps: list of DataFrame

    returns: DataFrame
    """
    # we have to resample the data from each cycle separately
    samples = [ResampleRowsWeighted(resp) for resp in resps]

    # then join the cycles into one big sample
    sample = pd.concat(samples, ignore_index=True)

    # remove married people with unknown marriage dates
    if remove_missing:
        sample = sample[~sample.missing]
    
    # jittering the ages reflects the idea that the resampled people
    # are not identical to the actual respondents
    if jitter:
        Jitter(sample, 'age', jitter=jitter)
        Jitter(sample, 'agemarry', jitter=jitter)
        DigitizeResp(resp)

    return sample


def ResampleRowsWeighted(df, column='finalwgt'):
    """Resamples the rows in df in accordance with a weight column.

    df: DataFrame

    returns: DataFrame
    """
    weights = df['finalwgt']
    weights /= sum(weights)
    indices = np.random.choice(df.index, len(df), replace=True, p=weights)
    return df.loc[indices]


def Jitter(df, column, jitter=1):
    """Adds random noise to a column.

    df: DataFrame
    column: string column name
    jitter: standard deviation of noise
    """
    df[column] += np.random.uniform(-jitter, jitter, size=len(df))
        

def EstimateSurvival(resp, cutoff=None):
    """Estimates the survival curve.

    resp: DataFrame of respondents
    cutoff: where to truncate the estimated functions

    returns: pair of HazardFunction, SurvivalFunction
    """
    complete = resp[resp.evrmarry].agemarry_index
    ongoing = resp[~resp.evrmarry].age_index

    hf = survival.EstimateHazardFunction(complete, ongoing)
    if cutoff:
        hf.Truncate(cutoff)
    sf = hf.MakeSurvival()

    return hf, sf


def EstimateSurvivalByCohort(resps, iters=101,
                             cutoffs=None, predict_flag=False):
    """Makes survival curves for resampled data.

    resps: list of DataFrames
    iters: number of resamples to plot
    predict_flag: whether to also plot predictions
    cutoffs: map from cohort to the first unreliable age_index

    returns: map from group name to list of survival functions
    """
    if cutoffs == None:
        cutoffs = {}

    sf_map = defaultdict(list)

    # iters is the number of resampling runs to make
    for i in range(iters):
        sample = ResampleResps(resps)

        # group by decade
        grouped = sample.groupby('birth_index')

        # and estimate (hf, sf) for each group
        hf_map = OrderedDict()
        for name, group in iter(grouped):
            cutoff = cutoffs.get(name, 100)
            FillMissingAgemarry(group)
            hf_map[name] = EstimateSurvival(group, cutoff)

        # make predictions if desired
        if predict_flag:
            MakePredictions(hf_map)       

        # extract the sf from each pair and accumulate the results
        for name, (hf, sf) in hf_map.items():
            sf_map[name].append(sf)
             
    return sf_map


def FillMissingAgemarry(resp):
    """Fills missing values of age when married.

    resp: DataFrame
    """
    null = resp[resp.missing]
    if len(null) == 0:
        return

    valid = resp.agemarry_index.dropna()
    fill = valid.sample(len(null), replace=True)
    fill.index = null.index
    
    resp.agemarry_index.fillna(fill, inplace=True)


def PlotSurvivalFunctions(sf_map, predict_flag=False):
    """Plot estimated survival functions.

    sf_map: map from group name to sequence of survival functions
    predict_flag: whether the lines are predicted or actual
    """
    thinkplot.PrePlot(num=len(sf_map))

    for name, sf_seq in sorted(sf_map.items(), reverse=True):
        if len(sf_seq) == 0:
            continue

        sf = sf_seq[0]
        if len(sf) == 0:
            continue

        ts, rows = MakeSurvivalCI(sf_seq, [10, 50, 90])
        thinkplot.FillBetween(ts, rows[0], rows[2], color='gray', alpha=0.4)

        if not predict_flag:
            thinkplot.Plot(ts, rows[1], label='19%d'%name)

    thinkplot.Config(xlabel='Age (years)', ylabel='Fraction never married',
                     xlim=[14, 45], ylim=[0, 1],
                     legend=True, loc='upper right', frameon=False)


def MakePredictions(hf_map):
    """Extends a set of hazard functions and recomputes survival functions.

    For each group in hf_map, we extend hf and recompute sf.

    hf_map: map from group name to (HazardFunction, SurvivalFunction)
    """
    names = hf_map.keys()
    names.sort()
    hfs = [hf_map[name][0] for name in names]

    # extend each hazard function using data from the previous cohort,
    # and update the survival function
    for i, name in enumerate(names):
        hf, sf = hf_map[name]
        if i > 0:
            hf.Extend(hfs[i-1])
        sf = hf.MakeSurvival()
        hf_map[name] = hf, sf


def MakeSurvivalCI(sf_seq, percents):
    """Makes confidence intervals from a list of survival functions.

    sf_seq: list of SurvivalFunction
    percents: list of percentiles to select, like [5, 95]

    returns: (ts, rows) where ts is a sequence of times and
             rows contains one row of values for each percent
    """
    # find the union of all ts where the sfs are evaluated
    ts = set()
    for sf in sf_seq:
        ts |= set(sf.ts)
    
    ts = list(ts)
    ts.sort()
    
    # evaluate each sf at all times
    ss_seq = [sf.Probs(ts) for sf in sf_seq if len(sf) > 0]
    
    # return the requested percentiles from each column
    rows = thinkstats2.PercentileRows(ss_seq, percents)
    return ts, rows


def ReadFemResp1982():
    """Reads respondent data from NSFG Cycle 3.

    returns: DataFrame 
    """
    dat_file = '1982NSFGData.dat.gz'
    names = ['finalwgt', 'ageint', 'mar2p', 'cmmarrhx', 'fmarital', 
             'cmintvw', 'cmbirth']
    colspecs = [(976-1, 982),
                (1001-1, 1002),
                (1268-1, 1271),
                (1037-1, 1040),
                (1041-1, 1041),
                (841-1, 844),
                (12-1, 15),
                ]

    df = pd.read_fwf(dat_file,
                         colspecs=colspecs, 
                         names=names,
                         header=None,
                         nrows=7969,
                         compression='gzip')

    # CM values above 9000 indicate month unknown
    df.loc[df.cmintvw>9000, 'cmintvw'] -= 9000
    df.loc[df.cmbirth>9000, 'cmbirth'] -= 9000

    df['evrmarry'] = (df.fmarital != 6)
    df['cycle'] = 3

    CleanResp(df)
    return df


def ReadFemResp1988():
    """Reads respondent data from NSFG Cycle 4.
    Read as if were a standard ascii file 
    returns: DataFrame 
    """
    filename = '1988FemRespDataLines.dat.gz'
    names = ['finalwgt', 'ageint', 'currentcm', 
             'firstcm', 'cmintvw', 'cmbirth']
    colspecs = [(2568-1, 2574),
                (36-1, 37),
                (1521-1, 1525),
                (1538-1, 1542),
                (12-1, 16),
                (26-1, 30),
                ]

    df = pd.read_fwf(filename,
                     colspecs=colspecs, 
                     names=names,
                     header=None,
                     compression='gzip')

    # clean date of current/only marriage
    df.currentcm.replace([0], np.nan, inplace=True)

    # clean date of first (but not current) marriage
    df.firstcm.replace([0], np.nan, inplace=True)

    # combine current and first marriage
    df['cmmarrhx'] = df.firstcm
    df.cmmarrhx.fillna(df.currentcm, inplace=True)

    # replace NOT ASCERTAINED with NaN
    df.cmmarrhx.replace([99999], np.nan, inplace=True)

    # replace MONTH UNKNOWN with approximate date
    df.loc[df.cmmarrhx>90000, 'cmmarrhx'] -= 90000

    # define evrmarry if either currentcm or firstcm is non-zero
    df['evrmarry'] = ~df.cmmarrhx.isnull()
    df['cycle'] = 4

    CleanResp(df)
    return df


def ReadFemResp1995():
    """Reads respondent data from NSFG Cycle 5.

    returns: DataFrame
    """
    dat_file = '1995FemRespData.dat.gz'
    names = ['cmintvw', 'timesmar', 'cmmarrhx', 'cmbirth', 'finalwgt']
    colspecs = [(12360-1, 12363),
                (4637-1, 4638),
                (11759-1, 11762),
                (14-1, 16),
                (12350-1, 12359)]
    df = pd.read_fwf(dat_file, 
                         compression='gzip', 
                         colspecs=colspecs, 
                         names=names)

    df.timesmar.replace([98, 99], np.nan, inplace=True)
    df['evrmarry'] = (df.timesmar > 0)
    df['cycle'] = 5

    CleanResp(df)
    return df


def ReadFemResp2002():
    """Reads respondent data from NSFG Cycle 6.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw', 
               'evrmarry', 'parity', 'finalwgt']
    df = ReadResp('2002FemResp.dct', '2002FemResp.dat.gz', usecols=usecols)
    df['evrmarry'] = (df.evrmarry == 1)
    df['cycle'] = 6
    CleanResp(df)
    return df


def ReadFemResp2010():
    """Reads respondent data from NSFG Cycle 7.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'parity', 'wgtq1q16']
    df = ReadResp('2006_2010_FemRespSetup.dct',
                  '2006_2010_FemResp.dat.gz',
                  usecols=usecols)
    df['evrmarry'] = (df.evrmarry == 1)
    df['finalwgt'] = df.wgtq1q16
    df['cycle'] = 7
    CleanResp(df)
    return df


def ReadFemResp2013():
    """Reads respondent data from NSFG Cycle 8.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'parity', 'wgt2011_2013']
    df = ReadResp('2011_2013_FemRespSetup.dct',
                  '2011_2013_FemRespData.dat.gz',
                  usecols=usecols)
    df['evrmarry'] = (df.evrmarry == 1)
    df['finalwgt'] = df.wgt2011_2013
    df['cycle'] = 8
    CleanResp(df)
    return df


def ReadFemResp2015():
    """Reads respondent data from NSFG Cycle 9.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'parity', 'wgt2013_2015']
    df = ReadResp('2013_2015_FemRespSetup.dct',
                  '2013_2015_FemRespData.dat.gz',
                  usecols=usecols)
    df['evrmarry'] = (df.evrmarry == 1)
    df['finalwgt'] = df.wgt2013_2015
    df['cycle'] = 9
    CleanResp(df)
    return df


def ReadResp(dct_file, dat_file, **options):
    """Reads the NSFG respondent data.

    dct_file: string file name
    dat_file: string file name

    returns: DataFrame
    """
    dct = thinkstats2.ReadStataDct(dct_file, encoding='iso-8859-1')
    df = dct.ReadFixedWidth(dat_file, compression='gzip', **options)
    return df


def CleanResp(resp):
    """Cleans a respondent DataFrame.

    resp: DataFrame of respondents

    Adds columns: agemarry, age, decade, fives
    """
    resp.cmmarrhx.replace([9997, 9998, 9999], np.nan, inplace=True)

    resp['agemarry'] = (resp.cmmarrhx - resp.cmbirth) / 12.0
    resp['age'] = (resp.cmintvw - resp.cmbirth) / 12.0

    # if married, we need agemarry; if not married, we need age
    resp['missing'] = np.where(resp.evrmarry,
                               resp.agemarry.isnull(),
                               resp.age.isnull())

    month0 = pd.to_datetime('1899-12-15')
    dates = [month0 + pd.DateOffset(months=cm) 
             for cm in resp.cmbirth]
    resp['year'] = (pd.DatetimeIndex(dates).year - 1900)
    #resp['decade'] = resp.year // 10
    #resp['fives'] = resp.year // 5
    DigitizeResp(resp)


def DigitizeResp(df):
    """Computes indices for age, agemarry, and birth year.

    Groups each of these variables into bins and then assigns
    an index to each bin.

    For example, anyone between 30 and 30.99 year old is
    assigned age_index 30.  Anyone born in the 80s is given 
    the year_index 80.

    This function allows me to run the analysis with different
    levels of granularity.

    df: DataFrame
    """
    age_min = 10
    age_max = 55
    age_step = 1
    age_bins = np.arange(age_min, age_max, age_step)

    year_min = 0
    year_max = 120
    year_step = 10
    year_bins = np.arange(year_min, year_max, year_step)

    df['age_index'] = np.digitize(df.age, age_bins) * age_step
    df.age_index += age_min - age_step
    df.loc[df.age.isnull(), 'age_index'] = np.nan
    
    df['agemarry_index'] = np.digitize(df.agemarry, age_bins) * age_step
    df.agemarry_index += age_min - age_step
    df.loc[df.agemarry.isnull(), 'agemarry_index'] = np.nan

    df['birth_index'] = np.digitize(df.year, year_bins) * year_step
    df.birth_index += year_min - year_step


def ReadCanadaCycle5():
    """

    """
    #age at first marriage: CC232
    #age of respondent at interview: C3
    #final weight: C1
    #marital status: C5
    #Respondent every married: CC227
    pass


def ReadCanadaCycle6():
    """

    """
    #age at first marriage: CC232
    #age of respondent at interview: C3
    #final weight: C1
    #marital status: C5
    #Respondent every married: CC227
    pass


def ReadMaleResp2002():
    """Reads respondent data from NSFG Cycle 6.

    returns: DataFrame
    """
    usecols = ['caseid', 'mardat01', 'cmdivw', 'cmbirth', 'cmintvw', 
               'evrmarry', 'finalwgt']

    df = ReadResp('2002Male.dct', '2002Male.dat.gz', usecols=usecols)

    df['evrmarry'] = (df.evrmarry == 1)
    df['cmmarrhx'] = df.mardat01
    CleanResp(df)
    return df


def ReadMaleResp2010():
    """Reads respondent data from NSFG Cycle 7.

    returns: DataFrame
    """
    usecols = ['caseid', 'mardat01', 'cmdivw', 'cmbirth', 'cmintvw', 
               'evrmarry', 'wgtq1q16']

    df = ReadResp('2006_2010_MaleSetup.dct', 
                  '2006_2010_Male.dat.gz', 
                  usecols=usecols)

    df['evrmarry'] = (df.evrmarry == 1)
    df['cmmarrhx'] = df.mardat01
    df['finalwgt'] = df.wgtq1q16
    CleanResp(df)
    return df


def ReadMaleResp2013():
    """Reads respondent data from NSFG Cycle 8.

    returns: DataFrame
    """
    usecols = ['caseid', 'mardat01', 'cmdivw', 'cmbirth', 'cmintvw', 
               'evrmarry', 'wgt2011_2013']

    df = ReadResp('2011_2013_MaleSetup.dct', 
                  '2011_2013_MaleData.dat.gz', 
                  usecols=usecols)

    df['evrmarry'] = (df.evrmarry == 1)
    df['cmmarrhx'] = df.mardat01
    df['finalwgt'] = df.wgt2011_2013
    CleanResp(df)
    return df


def ReadMaleResp2015():
    """Reads respondent data from NSFG Cycle 9.

    returns: DataFrame
    """
    usecols = ['caseid', 'mardat01', 'cmdivw', 'cmbirth', 'cmintvw', 
               'evrmarry', 'wgt2013_2015']

    df = ReadResp('2013_2015_MaleSetup.dct', 
                  '2013_2015_MaleData.dat.gz', 
                  usecols=usecols)

    df['evrmarry'] = (df.evrmarry == 1)
    df['cmmarrhx'] = df.mardat01
    df['finalwgt'] = df.wgt2013_2015
    CleanResp(df)
    return df


def Validate1982(df):
    assert(len(df) == 7969)
    assert(len(df[df.evrmarry]) == 4651)
    assert(df.agemarry.value_counts().max() == 71)


def Validate1988(df):
    assert(len(df) == 8450)
    assert(len(df[df.evrmarry]) == 5264)
    assert(df.agemarry.value_counts().max() == 73)


def Validate1995(df):
    assert(len(df) == 10847)
    assert(len(df[df.evrmarry]) == 6841)
    assert(df.agemarry.value_counts().max() == 79)


def Validate2002(df):
    assert(len(df) == 7643)
    assert(sum(df.evrmarry) == 4126)
    assert(df.agemarry.value_counts().max() == 45)


def Validate2010(df):
    assert(len(df) == 12279)
    assert(sum(df.evrmarry) == 5534)
    assert(df.agemarry.value_counts().max() == 64)


def Validate2013(df):
    assert(len(df) == 5601)
    assert(sum(df.evrmarry) == 2452)
    assert(df.agemarry.value_counts().max() == 33)


def Validate2015(df):
    assert(len(df) == 5699)
    assert(sum(df.evrmarry) == 2401)
    assert(df.agemarry.value_counts().max() == 25)


def main():
    print('Cycle 8')
    resp8 = ReadFemResp2013()
    Validate2013(resp8)

    print('Cycle 7')
    resp7 = ReadFemResp2010()
    Validate2010(resp7)

    print('Cycle 6')
    resp6 = ReadFemResp2002()
    Validate2002(resp6)

    print('Cycle 5')
    resp5 = ReadFemResp1995()
    Validate1995(resp5)

    print('Cycle 4')
    resp4 = ReadFemResp1988()
    Validate1988(resp4)

    print('Cycle 3')
    resp3 = ReadFemResp1982()
    Validate1982(resp3)


if __name__ == '__main__':
    main()

