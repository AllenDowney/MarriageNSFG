"""This file contains code for use with "Think Stats",
by Allen B. Downey, available from greenteapress.com

Copyright 2014 Allen B. Downey
License: GNU GPLv3 http://www.gnu.org/licenses/gpl.html
"""

from __future__ import print_function, division

import bisect

import numpy as np
import pandas as pd
import scipy.stats

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
    sample = pd.concat(samples, ignore_index=True, sort=False)

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
    weights = df['finalwgt'].copy()
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
    complete = resp.loc[resp.complete, 'complete_var'].dropna()
    ongoing = resp.loc[~resp.complete, 'ongoing_var'].dropna()

    hf = survival.EstimateHazardFunction(complete, ongoing)
    if cutoff:
        hf.Truncate(cutoff)
    sf = hf.MakeSurvival()

    return hf, sf


def PropensityMatch(target, group, colname='agemarry'):
    """Choose a random subset of `group` to matches propensity with `target`.

    target: DataFrame
    group: DataFrame
    colname: string name of column with propensity scores

    returns: DataFrame with sample of rows from `group`
    """
    rv = scipy.stats.norm(scale=1)
    values = group[colname].fillna(100)

    def ChooseIndex(value):
        weights = rv.pdf(values-value)
        weights /= sum(weights)
        return np.random.choice(group.index, 1, p=weights)[0]

    indices = [ChooseIndex(value) for value in target[colname]]
    return group.loc[indices]


def EstimateSurvivalByCohort(resps, iters=101,
                             cutoffs=None, predict_flag=False,
                             prop_match=None, error_rate=0):
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
        if prop_match:
            last = grouped.get_group(prop_match)

        # and estimate (hf, sf) for each group
        hf_map = OrderedDict()
        for name, group in iter(grouped):
            if prop_match:
                group = PropensityMatch(last, group)

            if error_rate:
                AddErrors(group, 'complete_missing', error_rate)
                AddErrors(group, 'ongoing_missing', error_rate)

            # the amount of missing data is small; I think it is better
            # to drop it than to fill with random data
            #FillMissingColumn(group, 'complete_var', 'complete_missing')
            #FillMissingColumn(group, 'ongoing_var', 'ongoing_missing')
            cutoff = cutoffs.get(name, 100)
            hf_map[name] = EstimateSurvival(group, cutoff)

        # make predictions if desired
        if predict_flag:
            MakePredictions(hf_map)

        # extract the sf from each pair and accumulate the results
        for name, (hf, sf) in hf_map.items():
            sf_map[name].append(sf)

    return sf_map


def AddErrors(group, colname, error_rate):
    """

    NOTE: This will not work if there are actual missing values!
    """
    group[colname] = np.random.random(len(group)) < error_rate


def FillMissingColumn(group, colname, missing_colname):
    """Fills missing values of the given column.

    group: DataFrame
    colname: string
    """
    null = group[group[missing_colname]]
    if len(null) == 0:
        return

    # print(len(null), len(group))

    valid = group[colname].dropna()
    fill = valid.sample(len(null), replace=True)
    fill.index = null.index

    group[colname].fillna(fill, inplace=True)


def PlotSurvivalFunctions(sf_map, predict_flag=False, colormap=None):
    """Plot estimated survival functions.

    sf_map: map from group name to sequence of survival functions
    predict_flag: whether the lines are predicted or actual
    colormap: map from group name to color
    """
    for name, sf_seq in sorted(sf_map.items(), reverse=True):
        if len(sf_seq) == 0:
            continue

        sf = sf_seq[0]
        if len(sf) == 0:
            continue

        ts, rows = MakeSurvivalCI(sf_seq, [10, 50, 90])
        plt.fill_between(ts, rows[0], rows[2], lw=0, color='gray', alpha=0.2)

        if not predict_flag:
            if colormap:
                color = colormap[name]
                plt.plot(ts, rows[1], label='19%ds'%name,
                               color=color, alpha=0.8)
            else:
                plt.plot(ts, rows[1], label='19%ds'%name, alpha=0.8)


def MakePredictions(hf_map):
    """Extends a set of hazard functions and recomputes survival functions.

    For each group in hf_map, we extend hf and recompute sf.

    hf_map: map from group name to (HazardFunction, SurvivalFunction)
    """
    names = list(hf_map.keys())
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


def MakeSurvivalCI(sf_seq, percents, flip=False):
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
    if flip:
        ys = 1-sf.Probs(ts)
    else:
        ys = sf.Probs(ts)
    ss_seq = [100*ys for sf in sf_seq if len(sf) > 0]

    # return the requested percentiles from each column
    rows = thinkstats2.PercentileRows(ss_seq, percents)
    return ts, rows


def ReadFemResp1982():
    """Reads respondent data from NSFG Cycle 3.

    returns: DataFrame
    """
    dat_file = '1982NSFGData.dat.gz'
    names = ['finalwgt', 'ageint', 'mar2p', 'cmmarrhx', 'fmarital',
             'cmintvw', 'cmbirth', 'f18m1', 'cmdivorcx', 'cmstphsbx', 'fmarno']
    colspecs = [(976-1, 982),
                (1001-1, 1002),
                (1268-1, 1271),
                (1037-1, 1040),
                (1041-1, 1041),
                (841-1, 844),
                (12-1, 15),
                (606-1, 606),
                (619-1, 622),
                (625-1, 628),
                (1142-1, 1143),
                ]

    df = pd.read_fwf(dat_file,
                         colspecs=colspecs,
                         names=names,
                         header=None,
                         nrows=7969,
                         compression='gzip')

    df.cmintvw.replace([9797, 9898, 9999], np.nan, inplace=True)
    df.cmbirth.replace([9797, 9898, 9999], np.nan, inplace=True)
    df.cmmarrhx.replace([9797, 9898, 9999], np.nan, inplace=True)
    df.cmdivorcx.replace([9797, 9898, 9999], np.nan, inplace=True)
    df.cmstphsbx.replace([9797, 9898, 9999], np.nan, inplace=True)
    df.f18m1.replace([7, 8, 9], np.nan, inplace=True)

    # CM values above 9000 indicate month unknown
    df.loc[df.cmintvw>9000, 'cmintvw'] -= 9000
    df.loc[df.cmbirth>9000, 'cmbirth'] -= 9000
    df.loc[df.cmmarrhx>9000, 'cmmarrhx'] -= 9000
    df.loc[df.cmdivorcx>9000, 'cmdivorcx'] -= 9000
    df.loc[df.cmstphsbx>9000, 'cmstphsbx'] -= 9000

    df['evrmarry'] = (df.fmarno > 0)

    df['divorced'] = (df.f18m1 == 4)
    df['separated'] = (df.f18m1 == 5)
    df['widowed'] = (df.f18m1 == 3)
    df['stillma'] = (df.fmarno==1) & (df.fmarital==1)

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
             'firstcm', 'cmintvw', 'cmbirth',
             'f23m1', 'cmdivorcx', 'cmstphsbx', 'fmarno']

    colspecs = [(2568-1, 2574),
                (36-1, 37),
                (1521-1, 1525),
                (1538-1, 1542),
                (12-1, 16),
                (26-1, 30),
                (1554-1, 1554),
                (1565-1, 1569),
                (1570-1, 1574),
                (2441-1, 2442),
                ]

    df = pd.read_fwf(filename,
                     colspecs=colspecs,
                     names=names,
                     header=None,
                     compression='gzip')

    df.cmintvw.replace([0, 99999], np.nan, inplace=True)
    df.cmbirth.replace([0, 99999], np.nan, inplace=True)
    df.firstcm.replace([0, 99999], np.nan, inplace=True)
    df.currentcm.replace([0, 99999], np.nan, inplace=True)
    df.cmdivorcx.replace([0, 99999], np.nan, inplace=True)
    df.cmstphsbx.replace([0, 99999], np.nan, inplace=True)

    # CM values above 9000 indicate month unknown
    df.loc[df.cmintvw>90000, 'cmintvw'] -= 90000
    df.loc[df.cmbirth>90000, 'cmbirth'] -= 90000
    df.loc[df.firstcm>90000, 'firstcm'] -= 90000
    df.loc[df.currentcm>90000, 'currentcm'] -= 90000
    df.loc[df.cmdivorcx>90000, 'cmdivorcx'] -= 90000
    df.loc[df.cmstphsbx>90000, 'cmstphsbx'] -= 90000

    # combine current and first marriage
    df['cmmarrhx'] = df.firstcm
    df.cmmarrhx.fillna(df.currentcm, inplace=True)

    # define evrmarry if either currentcm or firstcm is non-zero
    df['evrmarry'] = (df.fmarno > 0)

    df['divorced'] = (df.f23m1==2)
    df['separated'] = (df.f23m1==3)
    df['widowed'] = (df.f23m1==1)
    df['stillma'] = (df.fmarno==1) & (df.f23m1.isnull())

    df['cycle'] = 4

    CleanResp(df)
    return df


def ReadFemResp1995():
    """Reads respondent data from NSFG Cycle 5.

    returns: DataFrame
    """
    dat_file = '1995FemRespData.dat.gz'
    names = ['cmintvw', 'timesmar', 'cmmarrhx', 'cmbirth', 'finalwgt',
             'marend01', 'cmdivorcx', 'cmstphsbx', 'marstat']

    colspecs = [(12360-1, 12363),
                (4637-1, 4638),
                (11759-1, 11762),
                (14-1, 16),
                (12350-1, 12359),
                (4713-1, 4713),
                (4718-1, 4721),
                (4722-1, 4725),
                (17-1, 17)]

    df = pd.read_fwf(dat_file,
                         compression='gzip',
                         colspecs=colspecs,
                         names=names)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)
    df.cmbirth.replace(invalid, np.nan, inplace=True)
    df.cmmarrhx.replace(invalid, np.nan, inplace=True)
    df.cmdivorcx.replace(invalid, np.nan, inplace=True)
    df.cmstphsbx.replace(invalid, np.nan, inplace=True)
    df.timesmar.replace([98, 99], np.nan, inplace=True)

    df['evrmarry'] = (df.timesmar > 0)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.timesmar==1) & (df.marend01.isnull())

    df['cycle'] = 5

    CleanResp(df)
    return df


def ReadFemResp2002():
    """Reads respondent data from NSFG Cycle 6.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'parity', 'finalwgt',
               'mardat01', 'marend01', 'mardis01', 'rmarital',
               'fmarno', 'mar1diss']

    df = ReadResp('2002FemResp.dct', '2002FemResp.dat.gz', usecols=usecols)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)
    df.cmbirth.replace(invalid, np.nan, inplace=True)
    df.cmmarrhx.replace(invalid, np.nan, inplace=True)

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['cycle'] = 6
    CleanResp(df)
    return df


def ReadFemResp2010():
    """Reads respondent data from NSFG Cycle 7.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'parity', 'wgtq1q16',
               'mardat01', 'marend01', 'mardis01', 'rmarital',
               'fmarno', 'mar1diss']

    df = ReadResp('2006_2010_FemRespSetup.dct',
                  '2006_2010_FemResp.dat.gz',
                  usecols=usecols)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)
    df.cmbirth.replace(invalid, np.nan, inplace=True)
    df.cmmarrhx.replace(invalid, np.nan, inplace=True)

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgtq1q16
    df['cycle'] = 7
    CleanResp(df)
    return df


def ReadFemResp2013():
    """Reads respondent data from NSFG Cycle 8.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'parity', 'wgt2011_2013',
               'mardat01', 'marend01', 'mardis01', 'rmarital',
               'fmarno', 'mar1diss']

    df = ReadResp('2011_2013_FemRespSetup.dct',
                  '2011_2013_FemRespData.dat.gz',
                  usecols=usecols)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)
    df.cmbirth.replace(invalid, np.nan, inplace=True)
    df.cmmarrhx.replace(invalid, np.nan, inplace=True)

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2011_2013
    df['cycle'] = 8
    CleanResp(df)
    return df


def ReadFemResp2015():
    """Reads respondent data from NSFG Cycle 9.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'parity', 'wgt2013_2015',
               'mardat01', 'marend01', 'mardis01', 'rmarital',
               'fmarno', 'mar1diss']

    df = ReadResp('2013_2015_FemRespSetup.dct',
                  '2013_2015_FemRespData.dat.gz',
                  usecols=usecols)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)
    df.cmbirth.replace(invalid, np.nan, inplace=True)
    df.cmmarrhx.replace(invalid, np.nan, inplace=True)

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2013_2015
    df['cycle'] = 9
    CleanResp(df)
    return df


def ReadFemResp2017():
    """Reads respondent data from NSFG Cycle 10.

    returns: DataFrame
    """
    # removed 'cmmarrhx', 'cmdivorcx', 'cmbirth',
    usecols = ['caseid', 'cmintvw', 'ager',
               'evrmarry', 'parity', 'wgt2015_2017',
               'mardat01', 'marend01', 'mardis01', 'rmarital',
               'fmarno', 'mar1diss']

    df = ReadResp('2015_2017_FemRespSetup.dct',
                  '2015_2017_FemRespData.dat.gz',
                  usecols=usecols)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)
    #df.cmbirth.replace(invalid, np.nan, inplace=True)
    #df.cmmarrhx.replace(invalid, np.nan, inplace=True)

    # since cmbirth and cmmarrhx are no longer included,
    # we have to compute them based on other variables;
    # the result can be off by up to 12 months
    df['cmbirth'] = df.cmintvw - df.ager*12
    df['cmmarrhx'] = (df.mardat01-1900) * 12

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2015_2017
    df['cycle'] = 10

    # Instead of calling CleanResp, we have to customize
    #CleanResp(df)

    df['agemarry'] = (df.cmmarrhx - df.cmbirth) / 12.0
    df['age'] = (df.cmintvw - df.cmbirth) / 12.0

    # if married, we need agemarry; if not married, we need age
    df['missing'] = np.where(df.evrmarry,
                             df.agemarry.isnull(),
                             df.age.isnull())

    month0 = pd.to_datetime('1899-12-15')
    dates = [month0 + pd.DateOffset(months=cm)
             for cm in df.cmbirth]
    df['year'] = (pd.DatetimeIndex(dates).year - 1900)

    DigitizeResp(df)

    return df


def ReadFemResp2019():
    """Reads respondent data from NSFG Cycle 11.

    returns: DataFrame
    """
    # removed 'cmmarrhx', 'cmdivorcx', 'cmbirth',
    usecols = ['caseid', 'cmintvw', 'ager',
               'evrmarry', 'parity', 'wgt2017_2019',
               'mardat01', 'marend01', 'mardis01', 'rmarital',
               'fmarno', 'mar1diss']

    df = ReadResp('2017_2019_FemRespSetup.dct',
                  '2017_2019_FemRespData.dat.gz',
                  usecols=usecols)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)

    # since cmbirth and cmmarrhx are no longer included,
    # we have to compute them based on other variables;
    # the result can be off by up to 12 months
    df['cmbirth'] = df.cmintvw - df.ager*12
    df['cmmarrhx'] = (df.mardat01-1900) * 12

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2017_2019
    df['cycle'] = 11

    df['agemarry'] = (df.cmmarrhx - df.cmbirth) / 12.0
    df['age'] = (df.cmintvw - df.cmbirth) / 12.0

    # if married, we need agemarry; if not married, we need age
    df['missing'] = np.where(df.evrmarry,
                             df.agemarry.isnull(),
                             df.age.isnull())

    month0 = pd.to_datetime('1899-12-15')
    dates = [month0 + pd.DateOffset(months=cm)
             for cm in df.cmbirth]
    df['year'] = (pd.DatetimeIndex(dates).year - 1900)

    DigitizeResp(df)

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
               'evrmarry', 'finalwgt', 'fmarit', 'timesmar', 'marrend4',
               #'marrend', 'marrend2', 'marrend3', marrend5', 'marrend6',
               ]

    df = ReadResp('2002Male.dct', '2002Male.dat.gz', usecols=usecols)

    #df.marrend.replace([8,9], np.nan, inplace=True)
    #df.marrend2.replace([8,9], np.nan, inplace=True)
    #df.marrend3.replace([8,9], np.nan, inplace=True)
    df.marrend4.replace([8,9], np.nan, inplace=True)
    #df.marrend5.replace([8,9], np.nan, inplace=True)
    #df.marrend6.replace([8,9], np.nan, inplace=True)
    df.timesmar.replace([98,99], np.nan, inplace=True)

    # the way marriage ends are recorded is really confusing,
    # but it looks like marrend4 is the end of the first marriage.
    df['marend01'] = df.marrend4

    df['cmmarrhx'] = df.mardat01

    df['evrmarry'] = (df.timesmar > 0)
    df['divorced'] = (df.marend01==2) | (df.marend01==3)
    df['separated'] = (df.marend01==4)
    df['widowed'] = (df.marend01==1)
    df['stillma'] = (df.timesmar== 1) & (df.fmarit==1)

    df['cycle'] = 6
    CleanResp(df)

    return df


def ReadMaleResp2010():
    """Reads respondent data from NSFG Cycle 7.

    returns: DataFrame
    """
    usecols = ['caseid', 'mardat01', 'cmdivw', 'cmbirth', 'cmintvw',
               'evrmarry', 'wgtq1q16',
               'marend01', 'rmarital', 'fmarno', 'mar1diss']

    df = ReadResp('2006_2010_MaleSetup.dct',
                  '2006_2010_Male.dat.gz',
                  usecols=usecols)

    df['cmmarrhx'] = df.mardat01

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgtq1q16
    df['cycle'] = 7

    CleanResp(df)
    return df


def ReadMaleResp2013():
    """Reads respondent data from NSFG Cycle 8.

    returns: DataFrame
    """
    usecols = ['caseid', 'mardat01', 'cmdivw', 'cmbirth', 'cmintvw',
               'evrmarry', 'wgt2011_2013',
               'marend01', 'rmarital', 'fmarno', 'mar1diss']

    df = ReadResp('2011_2013_MaleSetup.dct',
                  '2011_2013_MaleData.dat.gz',
                  usecols=usecols)

    df['cmmarrhx'] = df.mardat01

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2011_2013
    df['cycle'] = 8

    CleanResp(df)
    return df


def ReadMaleResp2015():
    """Reads respondent data from NSFG Cycle 9.

    returns: DataFrame
    """
    usecols = ['caseid', 'mardat01', 'cmdivw', 'cmbirth', 'cmintvw',
               'evrmarry', 'wgt2013_2015',
               'marend01', 'rmarital', 'fmarno', 'mar1diss']

    df = ReadResp('2013_2015_MaleSetup.dct',
                  '2013_2015_MaleData.dat.gz',
                  usecols=usecols)

    df['cmmarrhx'] = df.mardat01

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2013_2015
    df['cycle'] = 9
    CleanResp(df)
    return df


def ReadMaleResp2017():
    """Reads respondent data from NSFG Cycle 10.

    returns: DataFrame
    """
    usecols = ['caseid', 'mardat01', 'cmintvw', 'ager',
               'evrmarry', 'wgt2015_2017',
               'marend01', 'rmarital', 'fmarno', 'mar1diss']

    df = ReadResp('2015_2017_MaleSetup.dct',
                      '2015_2017_MaleData.dat.gz',
                      usecols=usecols)

    # since cmbirth and cmmarrhx are no longer included,
    # we have to compute them based on other variables;
    # the result can be off by up to 12 months
    df['cmbirth'] = df.cmintvw - df.ager*12
    df['cmmarrhx'] = (df.mardat01-1900) * 12

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2015_2017
    df['cycle'] = 10

    # Instead of calling CleanResp, we have to customize
    #CleanResp(df)

    df['agemarry'] = (df.cmmarrhx - df.cmbirth) / 12.0
    df['age'] = (df.cmintvw - df.cmbirth) / 12.0

    # if married, we need agemarry; if not married, we need age
    df['missing'] = np.where(df.evrmarry,
                                 df.agemarry.isnull(),
                                 df.age.isnull())

    month0 = pd.to_datetime('1899-12-15')
    dates = [month0 + pd.DateOffset(months=cm)
                 for cm in df.cmbirth]
    df['year'] = (pd.DatetimeIndex(dates).year - 1900)

    DigitizeResp(df)
    return df


def ReadMaleResp2019():
    """Reads respondent data from NSFG Cycle 11.

    returns: DataFrame
    """
    usecols = ['caseid', 'mardat01', 'cmintvw', 'ager',
               'evrmarry', 'wgt2017_2019',
               'marend01', 'rmarital', 'fmarno', 'mar1diss']

    df = ReadResp('2017_2019_MaleSetup.dct',
                      '2017_2019_MaleData.dat.gz',
                      usecols=usecols)

    # since cmbirth and cmmarrhx are no longer included,
    # we have to compute them based on other variables;
    # the result can be off by up to 12 months
    df['cmbirth'] = df.cmintvw - df.ager*12
    df['cmmarrhx'] = (df.mardat01-1900) * 12

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2017_2019
    df['cycle'] = 11

    # Instead of calling CleanResp, we have to customize
    #CleanResp(df)

    df['agemarry'] = (df.cmmarrhx - df.cmbirth) / 12.0
    df['age'] = (df.cmintvw - df.cmbirth) / 12.0

    # if married, we need agemarry; if not married, we need age
    df['missing'] = np.where(df.evrmarry,
                                 df.agemarry.isnull(),
                                 df.age.isnull())

    month0 = pd.to_datetime('1899-12-15')
    dates = [month0 + pd.DateOffset(months=cm)
                 for cm in df.cmbirth]
    df['year'] = (pd.DatetimeIndex(dates).year - 1900)

    DigitizeResp(df)
    return df


def Validate1982(df):
    assert(len(df) == 7969)
    assert(len(df[df.evrmarry]) == 4651)
    assert(df.agemarry.value_counts().max() == 71)


def Validate1988(df):
    assert(len(df) == 8450)
    assert(len(df[df.evrmarry]) == 5290)
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

def Validate2017(df):
    assert(len(df) == 5554)
    assert(sum(df.evrmarry) == 2582)
    assert(df.agemarry.value_counts().max() == 29)

def Validate2019(df):
    assert(len(df) == 6141)
    assert(sum(df.evrmarry) == 2722)
    assert(df.agemarry.value_counts().max() == 29)

def main():
    print('Cycle 10')
    resp10 = ReadFemResp2017()
    Validate2017(resp10)

    print('Cycle 9')
    resp9 = ReadFemResp2015()
    Validate2015(resp9)

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
