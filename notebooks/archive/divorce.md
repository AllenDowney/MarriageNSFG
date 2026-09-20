---
jupytext:
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.19.5
kernelspec:
  display_name: Python 3 (ipykernel)
  language: python
  name: python3
---

## Divorce


```{code-cell} ipython3
%matplotlib inline

import pandas as pd
import numpy as np
import seaborn as sns

import math

import matplotlib.pyplot as plt
from matplotlib import pylab

from scipy.interpolate import interp1d
from scipy.misc import derivative

import thinkstats2
import thinkplot
from thinkstats2 import Cdf

import survival
import marriage
```

## Divorce

```{code-cell} ipython3
%time nsfg_female = pd.read_hdf('FemMarriageData.hdf', 'FemMarriageData')
```

```{code-cell} ipython3
resp10 = marriage.ReadFemResp2017()
marriage.Validate2017(resp10)

resp9 = marriage.ReadFemResp2015()
marriage.Validate2015(resp9)

resp8 = marriage.ReadFemResp2013()
marriage.Validate2013(resp8)

resp7 = marriage.ReadFemResp2010()
marriage.Validate2010(resp7)

resp6 = marriage.ReadFemResp2002()
marriage.Validate2002(resp6)

married_resps = [resp[resp.evrmarry] for resp in [resp6, resp7, resp8, resp9, resp10]]
```

```{code-cell} ipython3
for df in married_resps:
    df['complete'] = df.divorced
    df['complete_var'] = df.mar1diss / 12
    df['ongoing_var'] = df.mar1diss / 12
    df['complete_missing'] = df.complete & df.complete_var.isnull()
    df['ongoing_missing'] = ~df.complete & df.ongoing_var.isnull()
    print(sum(df.complete_missing), sum(df.ongoing_missing))
    
    # combine the 90s and 80s cohorts
    # df.loc[df.birth_index==90, 'birth_index'] = 80
```

```{code-cell} ipython3
df = pd.concat(married_resps, ignore_index=True, sort=False)
len(df)
```

```{code-cell} ipython3
complete = df.loc[df.complete, 'complete_var']
complete.describe()
```

```{code-cell} ipython3
ongoing = df.loc[~df.complete, 'complete_var']
ongoing.describe()
```

```{code-cell} ipython3
thinkplot.Cdf(thinkstats2.Cdf(complete))
thinkplot.Cdf(thinkstats2.Cdf(ongoing))
thinkplot.Config(xlabel='Duration of marriage (years)',
                 ylabel='CDF')
```

```{code-cell} ipython3
hf = survival.EstimateHazardFunction(complete, ongoing, verbose=True)
```

```{code-cell} ipython3
hf, sf = marriage.EstimateSurvival(df)
```

```{code-cell} ipython3
thinkplot.Plot(hf)
```

```{code-cell} ipython3
thinkplot.Plot(sf)
```

```{code-cell} ipython3
#from lifelines import KaplanMeierFitter

#kmf = KaplanMeierFitter()
#kmf.fit(df.complete_var, event_observed=df.complete)
#kmf.survival_function_.plot(color='red')
#thinkplot.Config(xlim=[0, 30])
```

```{code-cell} ipython3
colors = sns.color_palette("colorblind", 5)
cohorts = [80, 70, 60, 50, 90]
colormap = dict(zip(cohorts, colors))
```

```{code-cell} ipython3
grouped = df.groupby('birth_index')
for name, group in iter(grouped):
    hf, sf = marriage.EstimateSurvival(group)
    thinkplot.Plot(sf, label=name, color=colormap[name])

thinkplot.Config(title='Women in the U.S.',
                 xlabel='Duration of marriage (years)',
                 ylabel='Fraction still married',
                 xlim=[0, 30], ylim=[0.3, 1])
```

```{code-cell} ipython3
last = grouped.get_group(80)
complete = last[last.complete].complete_var
ongoing = last[~last.complete].ongoing_var
hf = survival.EstimateHazardFunction(complete, ongoing, verbose=True)
```

So far:

1. Doesn't take into account sampling weights.

2. Doesn't take into account `agemarry`.

3. Vulnerable to small errors in tail.

```{code-cell} ipython3

%time sf_map = marriage.EstimateSurvivalByCohort(married_resps, iters=101)
```

```{code-cell} ipython3

marriage.PlotSurvivalFunctions(sf_map, colormap=colormap)

thinkplot.Config(title='Women in the U.S.',
                     xlabel='Duration of marriage (years)',
                     ylabel='Fraction still married',
                     xlim=[0, 30], ylim=[0.3, 1],
                     legend=True, loc='upper right', frameon=False)
```

```{code-cell} ipython3
for name, group in iter(grouped):
    cdf = thinkstats2.Cdf(group.agemarry)
    thinkplot.Cdf(cdf, label=name, color=colormap[name])
```

```{code-cell} ipython3
name = 80
last = grouped.get_group(name)
thinkplot.Cdf(thinkstats2.Cdf(last.agemarry), label=name, color=colormap[name])

for name, group in iter(grouped):
    if name != '80':
        matched = marriage.PropensityMatch(last, group, colname='agemarry')
        thinkplot.Cdf(thinkstats2.Cdf(matched.agemarry), label=name, color=colormap[name])
```

```{code-cell} ipython3

%time sf_map = marriage.EstimateSurvivalByCohort(married_resps, iters=21, prop_match=80)
```

```{code-cell} ipython3

marriage.PlotSurvivalFunctions(sf_map, colormap=colormap)

thinkplot.Config(title='Women in the U.S.',
                     xlabel='Duration of marriage (years)',
                     ylabel='Fraction still married',
                     xlim=[0, 30], ylim=[0.3, 1],
                     legend=True, loc='upper right', frameon=False)
```

```{code-cell} ipython3

%time sf_map = marriage.EstimateSurvivalByCohort(married_resps, iters=21, error_rate=0.1)
```

```{code-cell} ipython3

marriage.PlotSurvivalFunctions(sf_map, colormap=colormap)

thinkplot.Config(title='Women in the U.S.',
                     xlabel='Duration of marriage (years)',
                     ylabel='Fraction still married',
                     xlim=[0, 30], ylim=[0.3, 1],
                     legend=True, loc='upper right', frameon=False)
```

```{code-cell} ipython3

%time sf_map = marriage.EstimateSurvivalByCohort(married_resps, iters=21, prop_match=80)
```

```{code-cell} ipython3

marriage.PlotSurvivalFunctions(sf_map, colormap=colormap)

thinkplot.Config(title='Women in the U.S.',
                     xlabel='Duration of marriage (years)',
                     ylabel='Fraction still married',
                     xlim=[0, 30], ylim=[0.3, 1],
                     legend=True, loc='upper right', frameon=False)
```



```{code-cell} ipython3
def MakeTable(sf_map, ages):
    t = []
    for name, sf_seq in sorted(sf_map.items()):
        ts, ss = marriage.MakeSurvivalCI(sf_seq, [50])
        ss = ss[0]
        vals = [np.interp(age, ts, ss, right=np.nan) for age in ages]
        t.append((name, vals))
    return t
```

```{code-cell} ipython3
def MakePercentageTable(sf_map, ages=[6, 16, 26]):
    t = MakeTable(sf_map, ages)
    for name, sf_seq in sorted(sf_map.items()):
        ts, ss = marriage.MakeSurvivalCI(sf_seq, [50])
        ss = ss[0]
        vals = [np.interp(age, ts, ss, right=np.nan) for age in ages]
        print(name, '&', ' & '.join('%0.0f' % (val*100) for val in vals), r'\\')
        
MakePercentageTable(sf_map)
```

# Male respondents

```{code-cell} ipython3

male2010 = marriage.ReadMaleResp2010()
male2010.head()
```

```{code-cell} ipython3
male2013 = marriage.ReadMaleResp2013()
male2013.head()
```

```{code-cell} ipython3
male2015 = marriage.ReadMaleResp2015()
male2015.head()
```

```{code-cell} ipython3
males = [male2010, male2013, male2015]
df2 = pd.concat(males, ignore_index=True)
len(df2)
```

```{code-cell} ipython3

```

```{code-cell} ipython3
married_males = [resp[resp.evrmarry] for resp in [male2010, male2013, male2015]]
```

```{code-cell} ipython3
for df in married_males:
    df['complete'] = df.divorced
    df['complete_var'] = df.mar1diss / 12
    df['ongoing_var'] = df.mar1diss / 12
    df['complete_missing'] = df.complete & df.complete_var.isnull()
    df['ongoing_missing'] = ~df.complete & df.ongoing_var.isnull()
    print(sum(df.complete_missing), sum(df.ongoing_missing))
    
    # combine the 90s and 80s cohorts
    # df.loc[df.birth_index==90, 'birth_index'] = 80
```

```{code-cell} ipython3
df = pd.concat(married_males, ignore_index=True)
len(df)
```

```{code-cell} ipython3
complete = df.loc[df.complete, 'complete_var']
complete.describe()
```

```{code-cell} ipython3
ongoing = df.loc[~df.complete, 'complete_var']
ongoing.describe()
```

```{code-cell} ipython3
thinkplot.Cdf(thinkstats2.Cdf(complete))
thinkplot.Cdf(thinkstats2.Cdf(ongoing))
thinkplot.Config(xlabel='Duration of marriage (years)',
                 ylabel='CDF')
```

```{code-cell} ipython3
hf = survival.EstimateHazardFunction(complete, ongoing, verbose=True)
```

```{code-cell} ipython3
hf, sf = marriage.EstimateSurvival(df)
```

```{code-cell} ipython3
thinkplot.Plot(hf)
```

```{code-cell} ipython3
thinkplot.Plot(sf)
```

```{code-cell} ipython3
from lifelines import KaplanMeierFitter


kmf = KaplanMeierFitter()
kmf.fit(df.complete_var, event_observed=df.complete)
kmf.survival_function_.plot(color='red')
thinkplot.Config(xlim=[0, 30])
```

```{code-cell} ipython3
colors = sns.color_palette("colorblind", 5)
cohorts = [80, 70, 60, 50, 90]
colormap = dict(zip(cohorts, colors))
```

```{code-cell} ipython3
grouped = df.groupby('birth_index')
for name, group in iter(grouped):
    hf, sf = marriage.EstimateSurvival(group)
    thinkplot.Plot(sf, label=name, color=colormap[name])

thinkplot.Config(title='Women in the U.S.',
                 xlabel='Duration of marriage (years)',
                 ylabel='Fraction still married',
                 xlim=[0, 30], ylim=[0.3, 1])
```

```{code-cell} ipython3
last = grouped.get_group(80)
complete = last[last.complete].complete_var
ongoing = last[~last.complete].ongoing_var
hf = survival.EstimateHazardFunction(complete, ongoing, verbose=True)
```

So far:

1. Doesn't take into account sampling weights.

2. Doesn't take into account `agemarry`.

3. Vulnerable to small errors in tail.

```{code-cell} ipython3
reload(marriage)

%time sf_map = marriage.EstimateSurvivalByCohort(married_males, iters=101)
```

```{code-cell} ipython3
reload(marriage)

marriage.PlotSurvivalFunctions(sf_map, colormap=colormap)

thinkplot.Config(title='Men in the U.S.',
                     xlabel='Duration of marriage (years)',
                     ylabel='Fraction still married',
                     xlim=[0, 30], ylim=[0.3, 1],
                     legend=True, loc='upper right', frameon=False)
```

```{code-cell} ipython3
for name, group in iter(grouped):
    cdf = thinkstats2.Cdf(group.agemarry)
    thinkplot.Cdf(cdf, label=name, color=colormap[name])
```

```{code-cell} ipython3
name = 80
last = grouped.get_group(name)
thinkplot.Cdf(thinkstats2.Cdf(last.agemarry), label=name, color=colormap[name])

for name, group in iter(grouped):
    if name != '80':
        matched = marriage.PropensityMatch(last, group, colname='agemarry')
        thinkplot.Cdf(thinkstats2.Cdf(matched.agemarry), label=name, color=colormap[name])
```

```{code-cell} ipython3
reload(marriage)

%time sf_map = marriage.EstimateSurvivalByCohort(married_males, iters=21, prop_match=80)
```

```{code-cell} ipython3
reload(marriage)

marriage.PlotSurvivalFunctions(sf_map, colormap=colormap)

thinkplot.Config(title='Men in the U.S.',
                     xlabel='Duration of marriage (years)',
                     ylabel='Fraction still married',
                     xlim=[0, 30], ylim=[0.3, 1],
                     legend=True, loc='upper right', frameon=False)
```

```{code-cell} ipython3
reload(marriage)

%time sf_map = marriage.EstimateSurvivalByCohort(married_males, iters=21, error_rate=0.1)
```

```{code-cell} ipython3
reload(marriage)

marriage.PlotSurvivalFunctions(sf_map, colormap=colormap)

thinkplot.Config(title='Men in the U.S.',
                     xlabel='Duration of marriage (years)',
                     ylabel='Fraction still married',
                     xlim=[0, 30], ylim=[0.3, 1],
                     legend=True, loc='upper right', frameon=False)
```

```{code-cell} ipython3
reload(marriage)

%time sf_map = marriage.EstimateSurvivalByCohort(married_males, iters=21, prop_match=80)
```

```{code-cell} ipython3
reload(marriage)

marriage.PlotSurvivalFunctions(sf_map, colormap=colormap)

thinkplot.Config(title='Men in the U.S.',
                     xlabel='Duration of marriage (years)',
                     ylabel='Fraction still married',
                     xlim=[0, 30], ylim=[0.3, 1],
                     legend=True, loc='upper right', frameon=False)
```



```{code-cell} ipython3
def MakeTable(sf_map, ages):
    t = []
    for name, sf_seq in sorted(sf_map.items()):
        ts, ss = marriage.MakeSurvivalCI(sf_seq, [50])
        ss = ss[0]
        vals = [np.interp(age, ts, ss, right=np.nan) for age in ages]
        t.append((name, vals))
    return t
```

```{code-cell} ipython3
def MakePercentageTable(sf_map, ages=[6, 16, 26]):
    t = MakeTable(sf_map, ages)
    for name, sf_seq in sorted(sf_map.items()):
        ts, ss = marriage.MakeSurvivalCI(sf_seq, [50])
        ss = ss[0]
        vals = [np.interp(age, ts, ss, right=np.nan) for age in ages]
        print(name, '&', ' & '.join('%0.0f' % (val*100) for val in vals), r'\\')
        
MakePercentageTable(sf_map)
```

## All adults

```{code-cell} ipython3
resps = [resp6, resp7, resp8, resp9, male2010, male2013, male2015]
```

```{code-cell} ipython3
married_resps = [resp[resp.evrmarry] for resp in resps]
```

```{code-cell} ipython3
for df in married_resps:
    df['complete'] = df.divorced
    df['complete_var'] = df.mar1diss / 12
    df['ongoing_var'] = df.mar1diss / 12
    df['complete_missing'] = df.complete & df.complete_var.isnull()
    df['ongoing_missing'] = ~df.complete & df.ongoing_var.isnull()
    print(len(df), sum(df.complete_missing), sum(df.ongoing_missing))
    
    # combine the 90s and 80s cohorts
    # df.loc[df.birth_index==90, 'birth_index'] = 80
```

```{code-cell} ipython3
df = pd.concat(married_resps, ignore_index=True)
len(df)
```

```{code-cell} ipython3
complete = df.loc[df.complete, 'complete_var']
complete.describe()
```

```{code-cell} ipython3
ongoing = df.loc[~df.complete, 'complete_var']
ongoing.describe()
```

```{code-cell} ipython3
thinkplot.Cdf(thinkstats2.Cdf(complete))
thinkplot.Cdf(thinkstats2.Cdf(ongoing))
thinkplot.Config(xlabel='Duration of marriage (years)',
                 ylabel='CDF')
```

```{code-cell} ipython3
hf = survival.EstimateHazardFunction(complete, ongoing, verbose=True)
```

```{code-cell} ipython3
hf, sf = marriage.EstimateSurvival(df)
```

```{code-cell} ipython3
thinkplot.Plot(hf)
```

```{code-cell} ipython3
thinkplot.Plot(sf)
```

```{code-cell} ipython3
from lifelines import KaplanMeierFitter


kmf = KaplanMeierFitter()
kmf.fit(df.complete_var, event_observed=df.complete)
kmf.survival_function_.plot(color='red')
thinkplot.Config(xlim=[0, 30])
```

```{code-cell} ipython3
colors = sns.color_palette("colorblind", 5)
cohorts = [80, 70, 60, 50, 90]
colormap = dict(zip(cohorts, colors))
```

```{code-cell} ipython3
grouped = df.groupby('birth_index')
for name, group in iter(grouped):
    hf, sf = marriage.EstimateSurvival(group)
    thinkplot.Plot(sf, label=name, color=colormap[name])

thinkplot.Config(title='Adults in the U.S.',
                 xlabel='Duration of marriage (years)',
                 ylabel='Fraction still married',
                 xlim=[0, 30], ylim=[0.3, 1])
```

```{code-cell} ipython3
last = grouped.get_group(80)
complete = last[last.complete].complete_var
ongoing = last[~last.complete].ongoing_var
hf = survival.EstimateHazardFunction(complete, ongoing, verbose=True)
```

So far:

1. Doesn't take into account sampling weights.

2. Doesn't take into account `agemarry`.

3. Vulnerable to small errors in tail.

```{code-cell} ipython3
reload(marriage)

%time sf_map = marriage.EstimateSurvivalByCohort(married_resps, iters=101)
```

```{code-cell} ipython3
reload(marriage)

marriage.PlotSurvivalFunctions(sf_map, colormap=colormap)

thinkplot.Config(title='Adults in the U.S.',
                     xlabel='Duration of marriage (years)',
                     ylabel='Fraction still married',
                     xlim=[0, 30], ylim=[0.3, 1],
                     legend=True, loc='upper right', frameon=False)
```

```{code-cell} ipython3
for name, group in iter(grouped):
    cdf = thinkstats2.Cdf(group.agemarry)
    thinkplot.Cdf(cdf, label=name, color=colormap[name])
```

```{code-cell} ipython3
name = 80
last = grouped.get_group(name)
thinkplot.Cdf(thinkstats2.Cdf(last.agemarry), label=name, color=colormap[name])

for name, group in iter(grouped):
    if name != '80':
        matched = marriage.PropensityMatch(last, group, colname='agemarry')
        thinkplot.Cdf(thinkstats2.Cdf(matched.agemarry), label=name, color=colormap[name])
```

```{code-cell} ipython3
reload(marriage)

%time sf_map = marriage.EstimateSurvivalByCohort(married_resps, iters=101, prop_match=80)
```

```{code-cell} ipython3
reload(marriage)

marriage.PlotSurvivalFunctions(sf_map, colormap=colormap)

thinkplot.Config(title='Adults in the U.S.',
                 xlabel='Duration of marriage (years)',
                 ylabel='Fraction still married',
                 xlim=[0, 30], ylim=[0.3, 1],
                 legend=True, loc='upper right', frameon=False)

thinkplot.Save('divorce1', clf=False, formats=['png'])
```



```{code-cell} ipython3
def MakeTable(sf_map, ages):
    t = []
    for name, sf_seq in sorted(sf_map.items()):
        ts, ss = marriage.MakeSurvivalCI(sf_seq, [50])
        ss = ss[0]
        vals = [np.interp(age, ts, ss, right=np.nan) for age in ages]
        t.append((name, vals))
    return t
```

```{code-cell} ipython3
def MakePercentageTable(sf_map, ages=[7, 16, 26]):
    t = MakeTable(sf_map, ages)
    for name, sf_seq in sorted(sf_map.items()):
        ts, ss = marriage.MakeSurvivalCI(sf_seq, [50])
        ss = ss[0]
        vals = [np.interp(age, ts, ss, right=np.nan) for age in ages]
        print(name, '&', ' & '.join('%0.0f' % (val*100) for val in vals), r'\\')
        
MakePercentageTable(sf_map)
```

```{code-cell} ipython3
group = grouped.get_group(80)
```

```{code-cell} ipython3
thinkplot.Cdf(thinkstats2.Cdf(group.agemarry))
```

```{code-cell} ipython3
group.agemarry.describe()
```

```{code-cell} ipython3
youngmarry = group[group.agemarry <= 21]
oldmarry = group[group.agemarry > 21]
```

```{code-cell} ipython3
len(youngmarry), len(oldmarry)
```

```{code-cell} ipython3
hf, sf = marriage.EstimateSurvival(youngmarry)
thinkplot.Plot(sf, label='Married age <= 21')
hf, sf = marriage.EstimateSurvival(oldmarry)
thinkplot.Plot(sf, label='Married age > 21')
thinkplot.Config(title='Adults in the U.S., born in 1990s',
                 xlabel='Duration of marriage (years)',
                 ylabel='Fraction still married',
                 xlim=[0, 20], ylim=[0.3, 1],
                 legend=True, loc='upper right', frameon=False)
```

```{code-cell} ipython3

```

```{code-cell} ipython3

```
