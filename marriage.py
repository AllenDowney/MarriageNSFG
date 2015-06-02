"""This file contains code for use with "Think Stats",
by Allen B. Downey, available from greenteapress.com

Copyright 2014 Allen B. Downey
License: GNU GPLv3 http://www.gnu.org/licenses/gpl.html
"""

from __future__ import print_function, division

import numpy as np
import pandas

import nsfg
import thinkstats2
import thinkplot
import gzip
import matplotlib.pyplot as plt


FORMATS = ['pdf', 'eps', 'png']


class SurvivalFunction(object):
    """Represents a survival function."""

    def __init__(self, cdf, label=''):
        self.cdf = cdf
        self.label = label or cdf.label

    @property
    def ts(self):
        return self.cdf.xs

    @property
    def ss(self):
        return 1 - self.cdf.ps

    def __getitem__(self, t):
        return self.Prob(t)

    def Prob(self, t):
        """Returns S(t), the probability that corresponds to value t.

        t: time

        returns: float probability
        """
        return 1 - self.cdf.Prob(t)

    def Probs(self, xs):
        """Gets probabilities for a sequence of values."""
        return [self.Prob(x) for x in xs]

    def Mean(self):
        """Mean survival time."""
        return self.cdf.Mean()

    def Items(self):
        """Sorted list of (t, s) pairs."""
        return zip(self.ts, self.ss)

    def Render(self):
        """Generates a sequence of points suitable for plotting.

        returns: tuple of (sorted times, survival function)
        """
        return self.ts, self.ss

    def MakeHazard(self, label=''):
        """Computes the hazard function.

        sf: survival function

        returns: Pmf that maps times to hazard rates
        """
        ss = self.ss
        lams = {}
        for i, t in enumerate(self.ts[:-1]):
            hazard = (ss[i] - ss[i+1]) / ss[i]
            lams[t] = hazard

        return HazardFunction(lams, label=label)

    def MakePmf(self, filler=None):
        """Makes a PMF of lifetimes.

        filler: value to replace missing values

        returns: Pmf
        """
        pmf = thinkstats2.Pmf()
        for val, prob in self.cdf.Items():
            pmf.Set(val, prob)

        cutoff = self.cdf.ps[-1]
        if filler is not None:
            pmf[filler] = 1-cutoff

        return pmf

    def RemainingLifetime(self, filler=None, func=thinkstats2.Pmf.Mean):
        """Computes remaining lifetime as a function of age.

        func: function from conditional Pmf to expected liftime

        returns: Series that maps from age to remaining lifetime
        """
        pmf = self.MakePmf(filler=filler)
        d = {}
        for t in sorted(pmf.Values())[:-1]:
            pmf[t] = 0
            pmf.Normalize()
            d[t] = func(pmf) - t
            #print(t, d[t])

        return pandas.Series(d)


class HazardFunction(object):
    """Represents a hazard function."""

    def __init__(self, d, label=''):
        """Initialize the hazard function.

        d: dictionary (or anything that can initialize a series)
        label: string
        """
        self.series = pandas.Series(d)
        self.label = label

    def __getitem__(self, t):
        return self.series[t]

    def Render(self):
        """Generates a sequence of points suitable for plotting.

        returns: tuple of (sorted times, hazard function)
        """
        return self.series.index, self.series.values

    def MakeSurvival(self, label=''):
        """Makes the survival function.

        returns: SurvivalFunction
        """
        ts = self.series.index
        ss = (1 - self.series).cumprod()
        cdf = thinkstats2.Cdf(ts, 1-ss)
        sf = SurvivalFunction(cdf, label=label)
        return sf

    def Extend(self, other):
        """Extends this hazard function by copying the tail from another.

        other: HazardFunction
        """
        last = self.series.index[-1]
        more = other.series[other.series.index > last]
        self.series = pandas.concat([self.series, more])


def PlotSurvival(complete):
    """Plots survival and hazard curves.

    complete: list of complete lifetimes
    """
    thinkplot.PrePlot(3, rows=2)

    cdf = thinkstats2.Cdf(complete, label='cdf')
    sf = SurvivalFunction(cdf, label='survival')
    print(cdf[13])
    print(sf[13])

    thinkplot.Plot(sf)
    thinkplot.Cdf(cdf, alpha=0.2)
    thinkplot.Config()

    thinkplot.SubPlot(2)
    hf = sf.MakeHazard(label='hazard')
    print(hf[39])
    thinkplot.Plot(hf)
    thinkplot.Config(ylim=[0, 0.75])


def PlotHazard(complete, ongoing):
    """Plots the hazard function and survival function.

    complete: list of complete lifetimes
    ongoing: list of ongoing lifetimes
    """
    # plot S(t) based on only complete pregnancies
    cdf = thinkstats2.Cdf(complete)
    sf = SurvivalFunction(cdf)
    thinkplot.Plot(sf, label='old S(t)', alpha=0.1)

    thinkplot.PrePlot(2)

    # plot the hazard function
    hf = EstimateHazardFunction(complete, ongoing)
    thinkplot.Plot(hf, label='lams(t)', alpha=0.5)

    # plot the survival function
    sf = hf.MakeSurvival()

    thinkplot.Plot(sf, label='S(t)')
    thinkplot.Show(xlabel='t (weeks)')


def EstimateHazardFunction(complete, ongoing, label='', shift=1e-7):
    """Estimates the hazard function by Kaplan-Meier.

    http://en.wikipedia.org/wiki/Kaplan%E2%80%93Meier_estimator

    complete: list of complete lifetimes
    ongoing: list of ongoing lifetimes
    label: string
    shift: presumed additional survival of ongoing
    """
    # pmf and sf of complete lifetimes
    n = len(complete)
    hist_complete = thinkstats2.Hist(complete)
    sf_complete = SurvivalFunction(thinkstats2.Cdf(complete))

    # sf for ongoing lifetimes
    # The shift is a regrettable hack needed to deal with simultaneity.
    # If a case is complete at some t and another case is ongoing
    # at t, we presume that the ongoing case exceeds t+shift.
    m = len(ongoing)
    cdf = thinkstats2.Cdf(ongoing).Shift(shift)
    sf_ongoing = SurvivalFunction(cdf)

    lams = {}
    for t, ended in sorted(hist_complete.Items()):
        at_risk = ended + n * sf_complete[t] + m * sf_ongoing[t]
        lams[t] = ended / at_risk
        #print(t, ended, n * sf_complete[t], m * sf_ongoing[t], at_risk)

    return HazardFunction(lams, label=label)


def CleanData(resp):
    """Cleans a respondent DataFrame.

    resp: DataFrame of respondents

    Adds columns: agemarry, age, decade, fives
    """
    resp.cmmarrhx.replace([9997, 9998, 9999], np.nan, inplace=True)

    resp['agemarry'] = (resp.cmmarrhx - resp.cmbirth) / 12.0
    resp['age'] = (resp.cmintvw - resp.cmbirth) / 12.0

    month0 = pandas.to_datetime('1899-12-15')
    dates = [month0 + pandas.DateOffset(months=cm) 
             for cm in resp.cmbirth]
    resp['decade'] = (pandas.DatetimeIndex(dates).year - 1900) // 10
    resp['fives'] = (pandas.DatetimeIndex(dates).year - 1900) // 5


def AddLabelsByDecade(groups, **options):
    """Draws fake points in order to add labels to the legend.

    groups: GroupBy object
    """
    thinkplot.PrePlot(len(groups))
    for name, _ in groups:
        label = '%d0s' % name
        thinkplot.Plot([15], [1], label=label, **options)


def EstimateSurvivalByDecade(groups, **options):
    """Groups respondents by decade and plots survival curves.

    groups: GroupBy object
    """
    thinkplot.PrePlot(len(groups))
    for _, group in groups:
        _, sf = EstimateSurvival(group)
        thinkplot.Plot(sf, **options)


def PlotPredictionsByDecade(groups, **options):
    """Groups respondents by decade and plots survival curves.

    groups: GroupBy object
    """
    hfs = []
    for _, group in groups:
        hf, sf = EstimateSurvival(group)
        hfs.append(hf)

    thinkplot.PrePlot(len(hfs))
    for i, hf in enumerate(hfs):
        if i > 0:
            hf.Extend(hfs[i-1])
        sf = hf.MakeSurvival()
        thinkplot.Plot(sf, **options)


def ResampleSurvival(resp, iters=101):
    """Resamples respondents and estimates the survival function.

    resp: DataFrame of respondents
    iters: number of resamples
    """ 
    _, sf = EstimateSurvival(resp)
    thinkplot.Plot(sf)

    low, high = resp.agemarry.min(), resp.agemarry.max()
    ts = np.arange(low, high, 1/12.0)

    ss_seq = []
    for _ in range(iters):
        sample = thinkstats2.ResampleRowsWeighted(resp)
        _, sf = EstimateSurvival(sample)
        ss_seq.append(sf.Probs(ts))

    low, high = thinkstats2.PercentileRows(ss_seq, [5, 95])
    thinkplot.FillBetween(ts, low, high, color='gray', label='90% CI')
    thinkplot.Save(root='survival3',
                   xlabel='age (years)',
                   ylabel='prob unmarried',
                   xlim=[12, 46],
                   ylim=[0, 1],
                   formats=FORMATS)


def EstimateSurvival(resp):
    """Estimates the survival curve.

    resp: DataFrame of respondents

    returns: pair of HazardFunction, SurvivalFunction
    """
    complete = resp[resp.evrmarry == 1].agemarry
    ongoing = resp[resp.evrmarry == 0].age

    hf = EstimateHazardFunction(complete, ongoing)
    sf = hf.MakeSurvival()

    return hf, sf


def PlotMarriageData(resp):
    """Plots hazard and survival functions.

    resp: DataFrame of respondents
    """
    hf, sf = EstimateSurvival(resp)

    thinkplot.PrePlot(rows=2)
    thinkplot.Plot(hf)
    thinkplot.Config(legend=False)

    thinkplot.SubPlot(2)
    thinkplot.Plot(sf)
    thinkplot.Save(root='survival2',
                   xlabel='age (years)',
                   ylabel='prob unmarried',
                   ylim=[0, 1],
                   legend=False,
                   formats=FORMATS)
    return sf


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
    CleanData(df)
    return df


def ReadFemResp2002():
    """Reads respondent data from NSFG Cycle 6.

    returns: DataFrame
    """
    usecols = ['cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw', 
               'evrmarry', 'finalwgt']
    resp = ReadFemResp(usecols=usecols)
    CleanData(resp)
    return resp


def ReadFemResp2010():
    """Reads respondent data from NSFG Cycle 7.

    returns: DataFrame
    """
    usecols = ['cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'wgtq1q16']
    resp = ReadFemResp('2006_2010_FemRespSetup.dct',
                       '2006_2010_FemResp.dat.gz',
                        usecols=usecols)
    resp['finalwgt'] = resp.wgtq1q16
    CleanData(resp)
    return resp


def ReadFemResp2013():
    """Reads respondent data from NSFG Cycle 8.

    returns: DataFrame
    """
    usecols = ['cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'wgt2011_2013']
    resp = ReadFemResp('2011_2013_FemRespSetup.dct',
                        '2011_2013_FemRespData.dat.gz',
                        usecols=usecols)
    resp['finalwgt'] = resp.wgt2011_2013
    CleanData(resp)
    return resp


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
    df = pandas.read_fwf(dat_file, 
                         compression='gzip', 
                         colspecs=colspecs, 
                         names=names)

    df.timesmar.replace([98, 99], np.nan, inplace=True)
    df['evrmarry'] = (df.timesmar > 0)

    CleanData(df)
    return df


def ReadFemResp1982():
    """Reads respondent data from NSFG Cycle 4.

    returns: DataFrame 
    """
    dat_file = '1982NSFGData.dat.gz'
    names = ['finalwgt', 'ageint', 'mar2p', 'cmmarrhx', 'cmintvw', 'cmbirth']
    colspecs = [(976-1, 982),
                (1001-1, 1002),
                (1268-1, 1271),
                (1037-1, 1040),
                (841-1, 844),
                (12-1, 15),
                ]

    df = pandas.read_fwf(dat_file,
                         colspecs=colspecs, 
                         names=names,
                         header=None,
                         nrows=7969,
                         compression='gzip')

    # values above 9000 indicate month of marriage unknown; ideally
    # I should jitter them
    df.loc[df.cmbirth>9000, 'cmbirth'] -= 9000
    df['evrmarry'] = ~df.cmmarrhx.isnull()

    CleanData(df)
    return df


def ReadFemResp1988():
    """Reads respondent data from NSFG Cycle 4.
    Read as if were a standard ascii file 
    returns: DataFrame 
    """
    filename = '1988FemRespDataLines.dat.gz'
    names = ['finalwgt', 'ageint', 'currentcm', 'firstcm', 'cmintvw', 'cmbirth']
    colspecs = [(2568-1, 2574),
                (36-1, 37),
                (1521-1, 1525),
                (1538-1, 1542),
                (12-1, 16),
                (26-1, 30),
                ]

    df = pandas.read_fwf(filename,
                         colspecs=colspecs, 
                         names=names,
                         header=None,
                         compression='gzip')

    # clean date of current/only marriage
    df.currentcm.replace([0, 99999], np.nan, inplace=True)
    df.loc[df.currentcm>90000, 'currentcm'] -= 90000

    # clean date of first (but not current) marriage
    df.firstcm.replace([0, 99999], np.nan, inplace=True)
    df.loc[df.firstcm>90000, 'firstcm'] -= 90000

    # combine current and first marriage
    df['cmmarrhx'] = df.currentcm
    df.cmmarrhx.fillna(df.firstcm)

    # TODO: the following is not quite correct, because 0 indicates
    # unmarried, but 99999 indicates married but date of marriage not
    # ascertained
    df['evrmarry'] = ~df.cmmarrhx.isnull()

    CleanData(df)
    return df


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


def PlotResampledByDecade(resps, iters=11, predict_flag=False, omit=None, weighted=True):
    """Plots survival curves for resampled data.

    resps: list of DataFrames
    iters: number of resamples to plot
    predict_flag: whether to also plot predictions
    """
    for i in range(iters):
        if weighted:
            samples = [thinkstats2.ResampleRowsWeighted(resp) 
                       for resp in resps]
        else:
            samples = [thinkstats2.ResampleRows(resp) for resp in resps]
        sample = pandas.concat(samples, ignore_index=True)
        groups = sample.groupby('decade')

        if omit:
            groups = [(name, group) for name, group in groups 
                      if name not in omit]

        # TODO: refactor this to collect resampled estimates and
        # plot shaded areas
        if i == 0:
            AddLabelsByDecade(groups, alpha=0.7)

        if predict_flag:
            PlotPredictionsByDecade(groups, alpha=0.1)
            EstimateSurvivalByDecade(groups, alpha=0.1)
        else:
            EstimateSurvivalByDecade(groups, alpha=0.2)


def Validate1982(df):
    assert(len(df) == 7969)
    assert(len(df[df.evrmarry]) == 4651)
    assert(df.agemarry.value_counts().max() == 71)


def Validate1988(df):
    assert(len(df) == 8450)
    assert(len(df[df.evrmarry]) == 4015)
    assert(df.agemarry.value_counts().max() == 49)


def Validate1995(df):
    print(len(df))
    print(len(df[df.evrmarry]))
    print(df.agemarry.value_counts().max())

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
    thinkstats2.RandomSeed(17)

    resp8 = ReadFemResp2013()
    Validate2013(resp8)
    return

    resp7 = ReadFemResp2010()
    Validate2010(resp7)
    return

    resp6 = ReadFemResp2002()
    Validate2002(resp6)
    return

    resp5 = ReadFemResp1995()
    Validate1995(resp5)
    return

    resp4 = ReadFemResp1988()
    Validate1988(resp4)
    return

    resp3 = ReadFemResp1982()
    Validate1982(resp3)
    return

    
    # make the plots based on Cycle 6

    sf2 = PlotMarriageData(resp6)
    ResampleSurvival(resp6)

    # read Cycles 5 and 7
    resp7 = ReadFemResp2010()


if __name__ == '__main__':
    main()

