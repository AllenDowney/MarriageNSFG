---
jupytext:
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.19.5
---

##Are first babies more likely to be late?

Copyright 2015 Allen Downey

License: [Creative Commons Attribution 4.0 International](http://creativecommons.org/licenses/by/4.0/)

```{code-cell}
from __future__ import print_function, division

import marriage

import thinkstats2
import thinkplot

import math

import pandas as pd
import numpy as np

%matplotlib inline
```

Load the data:

```{code-cell}
def ReadFemPreg(dct_file, dat_file, usecols):
    """Reads the NSFG pregnancy data.

    dct_file: string file name
    dat_file: string file name

    returns: DataFrame
    """
    dct = thinkstats2.ReadStataDct(dct_file, encoding='ISO-8859-1')
    df = dct.ReadFixedWidth(dat_file, compression='gzip', usecols=usecols)
    return df
```

```{code-cell}
usecols = ['outcome', 'prglngth', 'birthord', 'finalwgt']
preg6 = ReadFemPreg('2002FemPreg.dct', '2002FemPreg.dat.gz', usecols)
print(preg6.shape)
preg6 = preg6[preg6.outcome == 1]
```

```{code-cell}
preg6.birthord.value_counts().sort_index()
```

```{code-cell}
preg6.prglngth.value_counts().sort_index()
```

Make a list of DataFrames, one for each cycle:

```{code-cell}
sum(preg6.prglngth >= 27)
```

```{code-cell}
preg6.finalwgt.describe()
```

```{code-cell}
usecols = ['outcome', 'prglngth', 'birthord', 'wgtq1q16']
preg7 = ReadFemPreg('2006_2010_FemPregSetup.dct', '2006_2010_FemPreg.dat.gz', usecols)
print(preg7.shape)
preg7 = preg7[preg7.outcome == 1]
preg7['finalwgt'] = preg7.wgtq1q16
preg7.shape
```

```{code-cell}
preg7.birthord.value_counts().sort_index()
```

```{code-cell}
preg7.prglngth.value_counts().sort_index()
```

```{code-cell}
sum(preg7.prglngth >= 27)
```

```{code-cell}
# note: min and max should be 38.700642694-49735.071265
preg7.finalwgt.describe()
```

```{code-cell}
usecols = ['outcome', 'prglngth', 'birthord', 'wgt2011_2013']
preg8 = ReadFemPreg('2011_2013_FemPregSetup.dct', '2011_2013_FemPregData.dat.gz', usecols)
print(preg7.shape)
preg8 = preg8[preg8.outcome == 1]
preg8['finalwgt'] = preg8.wgt2011_2013
preg8.shape
```

```{code-cell}
preg8.birthord.value_counts().sort_index()
```

```{code-cell}
preg8.prglngth.value_counts().sort_index()
```

```{code-cell}
sum(preg8.prglngth >= 27)
```

```{code-cell}
preg8.finalwgt.describe()
```

```{code-cell}
#resp8 = marriage.ReadFemResp2013()
#marriage.Validate2013(resp8)
#resp8 = resp8[resp8.parity >= 1]

#resp7 = marriage.ReadFemResp2010()
#marriage.Validate2010(resp7)
#resp7 = resp7[resp7.parity >= 1]

#resp6 = marriage.ReadFemResp2002()
#marriage.Validate2002(resp6)
#resp6 = resp6[resp6.parity >= 1]
```

```{code-cell}
#resps = [resp6, resp7, resp8]
pregs = [preg6, preg7, preg8]

for preg in pregs:
    print(len(preg))
```

```{code-cell}
def SummarizeCycle(df):
    ages = df.age.min(), df.age.max()
    ages= np.array(ages)
    
    intvws = df.cmintvw.min(), df.cmintvw.max()
    intvws = np.array(intvws) / 12 + 1900
    
    births = df.cmbirth.min(), df.cmbirth.max()
    births = np.array(births) / 12 + 1900

    print('# & ', intvws.astype(int), '&', len(df), '&', births.astype(int), r'\\')
    
#for resp in reversed(resps):
#    SummarizeCycle(resp)
```

```{code-cell}
def ResampleAndSelect(resp, preg):
    sample = thinkstats2.resample_rows_weighted(resp, column='finalwgt')
    print('1')
    
    dfs = [preg[preg.caseid == caseid] for caseid in sample.caseid]
    print('2')
    
    rows = pd.concat(dfs, ignore_index=True)
    print('3')

    return rows

#%time sample6 = ResampleAndSelect(resp6, preg6)
#sample6.shape
```

```{code-cell}
#grouped6 = preg6.groupby('caseid')
```

```{code-cell}
def ResampleAndSelect(resp, grouped):
    sample = thinkstats2.resample_rows_weighted(resp, column='finalwgt')
    print('1')

    dfs = [grouped.get_group(caseid) for caseid in sample.caseid]
    print('2', len(dfs))

    rows = pd.concat(dfs, ignore_index=True)
    print('3')
    return rows

#%time sample6 = ResampleAndSelect(resp6, grouped6)
#sample6.shape
```

```{code-cell}
def ResamplePreg(preg):
    sample = thinkstats2.resample_rows_weighted(preg, column='finalwgt')
    return sample

#%time sample7 = ResamplePreg(preg7)
#ample7.shape
```

```{code-cell}
def Resample(pregs):
    samples = [thinkstats2.resample_rows_weighted(preg, column='finalwgt') 
               for preg in pregs]
    sample = pd.concat(samples)
    return sample

sample = Resample(pregs)
```

```{code-cell}
firsts = sample[sample.birthord == 1]
firsts.shape
```

```{code-cell}
others = sample[sample.birthord > 1]
others.shape
```

```{code-cell}
sum(firsts.prglngth.isnull())
```

```{code-cell}
sum(others.prglngth.isnull())
```

```{code-cell}
firsts.prglngth.value_counts().sort_index()
```

```{code-cell}
others.prglngth.value_counts().sort_index()
```

```{code-cell}
len(firsts.prglngth), len(others.prglngth)
```

```{code-cell}
firsts.prglngth.mean(), others.prglngth.mean()
```

```{code-cell}
diff = firsts.prglngth.mean() - others.prglngth.mean()
diff, diff * 7, diff * 7 * 24
```

```{code-cell}
firsts.prglngth.std(), others.prglngth.std()
```

```{code-cell}
se1 = firsts.prglngth.std() / math.sqrt(len(firsts.prglngth))
se1
```

```{code-cell}
se2 = others.prglngth.std() / math.sqrt(len(others.prglngth))
se2
```

```{code-cell}
diff / se1, diff / se2
```

```{code-cell}
cdf_firsts = thinkstats2.Cdf(firsts.prglngth, label='firsts')

thinkplot.PrePlot(2)
thinkplot.Cdf(cdf_firsts)
thinkplot.Config(xlabel='pregnancy length (weeks)',
                 ylabel='CDF',
                 loc='upper left')
```

```{code-cell}
cdf_others = thinkstats2.Cdf(others.prglngth, label='others')

thinkplot.Cdf(cdf_others)
thinkplot.Config(xlabel='pregnancy length (weeks)',
                 ylabel='CDF',
                 loc='upper left')
```

```{code-cell}
jitter = 0.5

length_firsts = thinkstats2.Jitter(firsts.prglngth, jitter)
cdf_firsts = thinkstats2.Cdf(length_firsts, label='firsts')

length_others = thinkstats2.Jitter(others.prglngth, jitter)
cdf_others = thinkstats2.Cdf(length_others, label='others')

thinkplot.PrePlot(2)
thinkplot.Cdf(cdf_firsts)
thinkplot.Cdf(cdf_others)
thinkplot.Config(xlabel='pregnancy length (weeks)',
                 xlim=[30, 45],
                 ylabel='CDF',
                 loc='upper left')
```

```{code-cell}
def RemainingDurationPmf(pmf, weeks):
    """Returns PMF of remaining duration conditioned on weeks.
    
    pmf: PMF of pregnancy length
    weeks: current weeks of pregnancy
    """
    new = thinkstats2.Pmf(label=pmf.label)
    for x, p in pmf.Items():
        if x >= weeks:
            new[x - weeks] = p
    new.Normalize()
    return new
```

```{code-cell}
pmf_firsts = thinkstats2.Pmf(length_firsts, label='firsts')
pmf_others = thinkstats2.Pmf(length_others, label='others')
```

```{code-cell}
def PlotRemaining(pmfs, weeks):
    """Plot CDF of remaining weeks.
    
    pmfs: list of PMF
    weeks: current weeks of pregnancy
    """
    cdfs = [RemainingDurationPmf(pmf, weeks).MakeCdf()
            for pmf in pmfs]

    thinkplot.PrePlot(len(cdfs))
    thinkplot.Cdfs(cdfs)
```

```{code-cell}
loc = 'lower right'
PlotRemaining([pmf_firsts, pmf_others], 30)
thinkplot.Config(xlabel='pregnancy length (weeks)',
                 ylabel='CDF',
                 loc=loc)
```

```{code-cell}
PlotRemaining([pmf_firsts, pmf_others], 32)
thinkplot.Config(xlabel='pregnancy length (weeks)',
                 ylabel='CDF',
                 loc=loc)
```

```{code-cell}
PlotRemaining([pmf_firsts, pmf_others], 34)
thinkplot.Config(xlabel='pregnancy length (weeks)',
                 ylabel='CDF',
                 loc=loc)
```

```{code-cell}
PlotRemaining([pmf_firsts, pmf_others], 36)
thinkplot.Config(xlabel='pregnancy length (weeks)',
                 ylabel='CDF',
                 loc=loc)
```

```{code-cell}
PlotRemaining([pmf_firsts, pmf_others], 38)
thinkplot.Config(xlabel='pregnancy length (weeks)',
                 ylabel='CDF',
                 loc=loc)
```

```{code-cell}
PlotRemaining([pmf_firsts, pmf_others], 39)
thinkplot.Config(xlabel='pregnancy length (weeks)',
                 ylabel='CDF',
                 loc=loc)
```

```{code-cell}
def PercentilesRemaining(pmfs, weeks):
    cdfs = [RemainingDurationPmf(pmf, weeks).MakeCdf()
            for pmf in pmfs]
    
    for cdf in cdfs:
        print([cdf.Percentile(p) * 7 for p in [25, 50, 75]])
```

```{code-cell}
PercentilesRemaining([pmf_firsts, pmf_others], 39)
```

```{code-cell}
percentiles = [50, 75, 25]

def PercentilesRemaining(pmf, ts):
    array = np.zeros((len(ts), len(percentiles)))
    
    for i, t in enumerate(ts):
        cdf = RemainingDurationPmf(pmf, t).MakeCdf()
        ps = [cdf.Percentile(p) * 7 for p in percentiles]
        #print(t, ps)
        array[i, :] = ps
        
    return array
```

```{code-cell}
ts = np.arange(36, 44)
ps_firsts = PercentilesRemaining(pmf_firsts, ts)
ps_firsts
```

```{code-cell}
ps_others = PercentilesRemaining(pmf_others, ts)
ps_others
```

```{code-cell}
nrows, ncols = ps_firsts.shape

thinkplot.PrePlot(3)
for i in range(ncols):
    thinkplot.Plot(ts, ps_firsts[:, i], label=percentiles[i])

thinkplot.PrePlot(3)
for i in range(ncols):
    thinkplot.Plot(ts, ps_others[:, i], linestyle='dashed')
    
thinkplot.Config(xlabel='t (weeks)',
                 ylabel='remaining time (days)',
                 legend=True,
                 loc='upper right')
```

```{code-cell}
sample = Resample(pregs)
sample.shape
```

```{code-cell}
firsts = sample[sample.birthord == 1] 
others = sample[sample.birthord > 1]
```

```{code-cell}
jitter = 0.5
lengths = thinkstats2.Jitter(firsts.prglngth, jitter)
pmf_firsts = thinkstats2.Pmf(lengths, label='firsts')

lengths = thinkstats2.Jitter(others.prglngth, jitter)
pmf_others = thinkstats2.Pmf(lengths, label='others')
```

```{code-cell}
def SelectFirsts(preg):
    return preg[preg.birthord == 1]
```

```{code-cell}
def SelectOthers(preg):
    return preg[preg.birthord > 1]
```

```{code-cell}
def MeanRemaining(pmf, t):
    rem_pmf = RemainingDurationPmf(pmf, t)
    mean = rem_pmf.Mean()
    return mean

MeanRemaining(pmf_firsts, 36)
```

```{code-cell}
def MedianRemaining(pmf, t):
    rem_pmf = RemainingDurationPmf(pmf, t)
    rem_cdf = rem_pmf.MakeCdf()
    median = rem_cdf.Percentile(50)
    return median

MedianRemaining(pmf_firsts, 36)
```

```{code-cell}
def ProbRemainingLess(pmf, t, weeks=1):
    rem_pmf = RemainingDurationPmf(pmf, t)
    rem_cdf = rem_pmf.MakeCdf()
    p = rem_cdf[weeks]
    return p

ProbRemainingLess(pmf_firsts, 36)
```

```{code-cell}
def Remaining(preg, iters, ts, select_func, stat_func):
    """Computes remaining lifetime versus weeks of pregnancy.
    
    preg: DataFrame of pregnancy data
    iters: int, how many resampling iterations to run
    ts: sequence of float, times to evaluate, in weeks
    select_func: function that selects a subset of pregnancies
    stat_func: function that computes summary statistic
    
    returns: array with one row for each percentile, one column
             for each item in ts
    """
    # make an array to hold one row per iteration,
    # one col per element of ts
    array = np.zeros((iters, len(ts)))

    for i in range(iters):
        sample = Resample(pregs)
        group = select_func(sample)

        lengths = thinkstats2.Jitter(group.prglngth, jitter=0.5)
        pmf = thinkstats2.Pmf(lengths)

        stats = [stat_func(pmf, t) for t in ts]
        array[i, :] = stats

    array = np.sort(array, axis=0)
    rows = [thinkstats2.PercentileRow(array, p) for p in [10, 50, 90]]
    return rows
```

```{code-cell}
def PlotStats(stat_func, iters, ts):
    """Plots a summary statistic versus weeks of pregnancy.
    
    stat_func: function that computes summary statistic
    iters: int, how many resampling iterations to run
    ts: sequence of float, times to evaluate, in weeks
    """
    # list of labels and select_funcs
    labels = [('firsts', SelectFirsts), 
              ('others', SelectOthers)]

    thinkplot.PrePlot(2)
    for label, select_func in labels:
        rows = Remaining(pmf_firsts, iters, ts, select_func, stat_func)
        thinkplot.FillBetween(ts, rows[0], rows[2], color='gray')
        thinkplot.Plot(ts, rows[1], label=label)
        print(label)
        for t, stat in zip(ts, rows[1]):
            print(t, stat)
```

```{code-cell}
iters = 101
ts = np.arange(36, 43.5, 0.5)
PlotStats(MeanRemaining, iters, ts)

thinkplot.Config(xlabel='week of pregnancy',
                 ylabel='remaining time (weeks)',
                 legend=True,
                 loc='upper right')

thinkplot.Save(root='first1', formats=['pdf', 'png'])
```

```{code-cell}
PlotStats(MedianRemaining, iters, ts)

thinkplot.Config(xlabel='t (weeks)',
                 ylabel='week of pregnancy',
                 legend=True,
                 loc='upper right')

thinkplot.Save(root='first2', formats=['pdf', 'png'])
```

```{code-cell}
PlotStats(ProbRemainingLess, iters, ts)

thinkplot.Config(xlabel='week of pregnancy',
                 ylabel='prob(birth within 1 week)',
                 legend=True,
                 loc='upper left')

thinkplot.Save(root='first3', formats=['pdf', 'png'])
```

```{code-cell}

```
