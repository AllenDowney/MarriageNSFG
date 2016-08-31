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


def JitterResp(df, column, jitter=1):
    """Adds random noise to a column.

    df: DataFrame
    column: string column name
    jitter: standard deviation of noise
    """
    df[column] += np.random.normal(0, jitter, size=len(df))
        

def DigitizeResp(df):
    """Digitizes age, agemarry, and birth year.

    df: DataFrame
    """
    age_min = 15
    age_max = 45
    age_step = 1
    age_bins = np.arange(age_min, age_max, age_step)

    year_min = 40
    year_max = 99
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


def ResampleResps(resps, remove_missing=False):
    """Resamples each dataframe and then concats them.

    resps: list of DataFrame

    returns: DataFrame
    """
    # we have to resample the data from each cycles separately
    samples = [thinkstats2.ResampleRowsWeighted(resp, column='finalwgt') 
               for resp in resps]
        
    # then join the cycles into one big sample
    sample = pd.concat(samples, ignore_index=True)

    # remove married people with unknown marriage dates
    if remove_missing:
        sample['missing'] = (sample.evrmarry & sample.agemarry.isnull())
        sample = sample[~sample.missing]
    
    # TODO: fill missing values
    #DigitizeResp(sample)
    #grouped = sample.groupby('birth_index')
    #for name, group in iter(grouped):
    #    cdf = thinkstats2.Cdf(group.agemarry)
    #    print(name, cdf.Mean())
    
    JitterResp(sample, 'age', jitter=1)
    JitterResp(sample, 'agemarry', jitter=1)
    DigitizeResp(sample)

    return sample


def EstimateSurvival(resp, cutoff=None):
    """Estimates the survival curve.

    resp: DataFrame of respondents
    cutoff: where to truncate the estimated functions

    returns: pair of HazardFunction, SurvivalFunction
    """
    # TODO: fill missing data

    complete = resp[resp.evrmarry].agemarry_index
    ongoing = resp[~resp.evrmarry].age_index

    hf = survival.EstimateHazardFunction(complete, ongoing)
    if cutoff:
        hf.Truncate(cutoff)
    sf = hf.MakeSurvival()

    return hf, sf


def EstimateSurvivalByCohort(resps, iters=101, predict_flag=False):
    """Makes survival curves for resampled data.

    resps: list of DataFrames
    iters: number of resamples to plot
    predict_flag: whether to also plot predictions
    
    returns: map from group name to list of survival functions
    """
    cutoffs = {70:43, 80:33, 90:23}
    sf_map = defaultdict(list)

    # iters is the number of resampling runs to make
    for i in range(iters):
        sample = ResampleResps(resps)

        # group by decade
        grouped = sample.groupby('birth_index')

        # and estimate (hf, sf) for each group
        hf_map = OrderedDict()
        for name, group in iter(grouped):
            cutoff = cutoffs.get(name, 45)
            hf_map[name] = EstimateSurvival(group, cutoff)

        # make predictions if desired
        if predict_flag:
            MakePredictions(hf_map)       

        # extract the sf from each pair and accumulate the results
        for name, (hf, sf) in hf_map.items():
            sf_map[name].append(sf)
             
    return sf_map


def PlotSurvivalFunctions(sf_map, predict_flag=False):
    """Plot estimated survival functions.

    sf_map: map from group name to sequence of survival functions
    predict_flag: whether the lines are predicted or actual
    """
    thinkplot.PrePlot(len(sf_map))

    for name, sf_seq in sorted(sf_map.items(), reverse=True):
        if len(sf_seq) == 0:
            continue

        sf = sf_seq[0]
        if len(sf) == 0:
            continue

        ts, rows = MakeSurvivalCI(sf_seq, [10, 50, 90])
        thinkplot.FillBetween(ts, rows[0], rows[2], color='gray')

        if not predict_flag:
            thinkplot.Plot(ts, rows[1], label='19%d'%name)

    thinkplot.Config(xlabel='age (years)', ylabel='prob unmarried',
                     xlim=[14, 45], ylim=[0, 1],
                     legend=True, loc='upper right')


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

    CleanFemResp(df)
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

    CleanFemResp(df)
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

    CleanFemResp(df)
    return df


def ReadFemResp2002():
    """Reads respondent data from NSFG Cycle 6.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw', 
               'evrmarry', 'parity', 'finalwgt']
    df = ReadFemResp(usecols=usecols)
    df['evrmarry'] = (df.evrmarry == 1)
    CleanFemResp(df)
    return df


def ReadFemResp2010():
    """Reads respondent data from NSFG Cycle 7.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'parity', 'wgtq1q16']
    df = ReadFemResp('2006_2010_FemRespSetup.dct',
                       '2006_2010_FemResp.dat.gz',
                        usecols=usecols)
    df['evrmarry'] = (df.evrmarry == 1)
    df['finalwgt'] = df.wgtq1q16
    CleanFemResp(df)
    return df


def ReadFemResp2013():
    """Reads respondent data from NSFG Cycle 8.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'parity', 'wgt2011_2013']
    df = ReadFemResp('2011_2013_FemRespSetup.dct',
                        '2011_2013_FemRespData.dat.gz',
                        usecols=usecols)
    df['evrmarry'] = (df.evrmarry == 1)
    df['finalwgt'] = df.wgt2011_2013
    CleanFemResp(df)
    return df


def ReadFemResp(dct_file='2002FemResp.dct',
                dat_file='2002FemResp.dat.gz',
                **options):
    """Reads the NSFG respondent data.

    dct_file: string file name
    dat_file: string file name

    returns: DataFrame
    """
    dct = thinkstats2.ReadStataDct(dct_file, encoding='iso-8859-1')
    df = dct.ReadFixedWidth(dat_file, compression='gzip', **options)
    return df


def CleanFemResp(resp):
    """Cleans a respondent DataFrame.

    resp: DataFrame of respondents

    Adds columns: agemarry, age, decade, fives
    """
    resp.cmmarrhx.replace([9997, 9998, 9999], np.nan, inplace=True)

    resp['agemarry'] = (resp.cmmarrhx - resp.cmbirth) / 12.0
    resp['age'] = (resp.cmintvw - resp.cmbirth) / 12.0

    month0 = pd.to_datetime('1899-12-15')
    dates = [month0 + pd.DateOffset(months=cm) 
             for cm in resp.cmbirth]
    resp['year'] = (pd.DatetimeIndex(dates).year - 1900)
    resp['decade'] = resp.year // 10
    resp['fives'] = resp.year // 5


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

