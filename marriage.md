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

## Will Millennials Ever Get Married?

This notebook contains analysis related to a paper on marriage patterns in the U.S., based on data from the National Survey of Family Growth (NSFG).

It is based on Chapter 13 of Think Stats, 2nd Edition, by Allen Downey, available from [thinkstats2.com](http://thinkstats2.com)

```{code-cell} ipython3
%matplotlib inline

import pandas as pd
import numpy as np
import seaborn as sns

import math
import shelve

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

```{code-cell} ipython3
%time df = pd.read_hdf('FemMarriageData.hdf', 'FemMarriageData')
df.shape
```

Make a table showing the number of respondents in each cycle:

```{code-cell} ipython3
df.cycle.value_counts().sort_index()
```

```{code-cell} ipython3
SAVE_PRED = False

if SAVE_PRED:
    df = df[df['cycle'] < 10]
```

```{code-cell} ipython3
df.cycle.value_counts().sort_index()
```

```{code-cell} ipython3
70183 - 5554 - 6141
```

```{code-cell} ipython3
def format_date_range(array):
    a, b = array.astype(int)
    return '%d--%d' % (a, b)

def SummarizeCycle(cycle, df):
    ages = df.age.min(), df.age.max()
    ages= np.array(ages)
    
    intvws = df.cmintvw.min(), df.cmintvw.max()
    intvws = np.array(intvws) / 12 + 1900
    
    births = df.cmbirth.min(), df.cmbirth.max()
    births = np.array(births) / 12 + 1900
    
    intvw_dates = format_date_range(intvws)
    birth_dates = format_date_range(births)
    
    print(cycle, ' & ', intvw_dates, '&', len(df), '&', birth_dates, r'\\')
```

```{code-cell} ipython3
for cycle, group in df.groupby('cycle'):
    SummarizeCycle(cycle, group)
```

Check for missing values in `agemarry`:

```{raw-cell}

```

```{code-cell} ipython3
def CheckAgeVars(df):
    print(sum(df[df.evrmarry].agemarry.isnull()))
    
for cycle, group in df.groupby('cycle'):
    CheckAgeVars(group)
```

Generate a table with the number of respondents in each cohort:

```{code-cell} ipython3
marriage.digitize_resp(df)
grouped = df.groupby('birth_index')
for name, group in iter(grouped):
    age_range = '%d--%d' % (int(group.age.min()), int(group.age_index.max()))
    print(name, '&', len(group), '&', age_range,
                '&', len(group[group.evrmarry]), '&', sum(group.missing), r'\\')
```

```{code-cell} ipython3
def ComputeCutoffs(df):
    grouped = df.groupby('birth_index')
    cutoffs = {}
    for name, group in sorted(grouped):
        cutoffs[name] = int(group.age.max())
    return cutoffs
```

```{code-cell} ipython3
cutoffs = ComputeCutoffs(df)
cutoffs
```

Estimate the hazard function for the 80s cohort (curious to see what's going on during the "marriage strike")

```{code-cell} ipython3
cohort = grouped.get_group(80)
missing = (cohort.evrmarry & cohort.agemarry.isnull())
cohort = cohort[~missing]
complete = cohort[cohort.evrmarry].agemarry_index
ongoing = cohort[~cohort.evrmarry].age_index
hf = survival.EstimateHazardFunction(complete, ongoing, verbose=True)
```

Run the same analysis for the 70s cohort (to extract $\lambda(33)$).

```{code-cell} ipython3
cohort = grouped.get_group(70)
missing = (cohort.evrmarry & cohort.agemarry.isnull())
cohort = cohort[~missing]
complete = cohort[cohort.evrmarry].agemarry_index
ongoing = cohort[~cohort.evrmarry].age_index
hf = survival.EstimateHazardFunction(complete, ongoing, verbose=True)
```

Use the 30s cohort to demonstrate the simple way to do survival analysis, by computing the survival function directly.

```{code-cell} ipython3
cohort = grouped.get_group(30)
sf = survival.MakeSurvivalFromSeq(cohort.agemarry_index.fillna(np.inf))
ts, ss = sf.Render()
print(ss)
thinkplot.Plot(ts, ss)
thinkplot.Config(xlim=[12, 42])
plt.ylabel('Survival Function')
```

Then use the SurvivalFunction to compute the HazardFunction:

```{code-cell} ipython3
hf = sf.MakeHazardFunction()
ts, lams = hf.Render()
print(lams)
thinkplot.Plot(ts, lams)
thinkplot.Config(xlim=[12, 42])
plt.ylabel('Hazard Function')
plt.xlabel('Age (years)')
```

Make the first figure, showing sf and hf for the 30s cohort:

```{code-cell} ipython3
options = dict(formats=['pdf', 'png'], clf=False)
```

```{code-cell} ipython3
thinkplot.PrePlot(rows=2)

thinkplot.Plot(sf, label='survival')
thinkplot.Config(xlim=[13, 41], ylim=[0, 1.05])
plt.ylabel('Survival Function')

thinkplot.SubPlot(2)
thinkplot.Plot(hf, label='hazard')
thinkplot.Config(xlabel='age(years)', ylabel='Hazard function', xlim=[13, 41])
plt.ylabel('Hazard Function')
plt.xlabel('Age (years)')

thinkplot.Save(root='figs/marriage1', **options)
```

```{code-cell} ipython3
thinkplot.Plot(sf, label='30s')
thinkplot.Config(xlim=[13, 41], ylim=[0, 1.05])
plt.xlabel('Age (years)', fontsize=14)
plt.ylabel('Survival function', fontsize=14)

thinkplot.Save(root='figs/marriage2', **options)
```

```{code-cell} ipython3
thinkplot.Plot(hf, label='30s')
thinkplot.Config(xlim=[13, 41])
plt.xlabel('Age (years)', fontsize=14)
plt.ylabel('Hazard function', fontsize=14)

thinkplot.Save(root='figs/marriage3', **options)
```

Make some pivot tables, just to see where the data are:

```{code-cell} ipython3
pt = df.pivot_table(index='birth_index', columns='age_index', values='age', aggfunc=len, fill_value=0)
pt
```

The following pivot table is not as helpful as it could be, since it doesn't show the number at risk.

```{code-cell} ipython3
df.pivot_table(index='birth_index', columns='agemarry_index', values='age', aggfunc=len, fill_value=0)
```

Estimate the survival curve for each cohort:

```{code-cell} ipython3
df['complete'] = df.evrmarry
df['complete_var'] = df.agemarry_index
df['ongoing_var'] = df.age_index
df['complete_missing'] = df.complete & df.complete_var.isnull()
df['ongoing_missing'] = ~df.complete & df.ongoing_var.isnull()
```

```{code-cell} ipython3
# for some marriages, we don't have the date of marriage

for cycle, group in df.groupby('cycle'):
    print(cycle, sum(group.complete_missing), sum(group.ongoing_missing))
```

```{code-cell} ipython3
resps = [group for cycle, group in df.groupby('cycle')]
iters = 101
```

```{code-cell} ipython3
%time sf_map = marriage.EstimateSurvivalByCohort(resps, iters=iters, cutoffs=cutoffs)
```

```{code-cell} ipython3
del sf_map[30]

try: 
    del sf_map[100]
except KeyError:
    pass
```

Check a sample:

```{code-cell} ipython3
for sf in sf_map[90]:
    print(sf.ss)
    print(sf.Prob(34))
    break
```

```{code-cell} ipython3
for sf in sf_map[80]:
    print(sf.ss)
    print(sf.Prob(34))
    break
```

Make the figure showing estimated survival curves:

```{code-cell} ipython3
def PlotSurvivalFunctions(root, sf_map, sf_map_pred=None, **options):

    if sf_map_pred:
        marriage.PlotSurvivalFunctions(sf_map_pred, predict_flag=True)
    marriage.PlotSurvivalFunctions(sf_map)

    thinkplot.config(xlabel='Age (years)',
                     ylabel='Percentage never married',
                     xlim=[13, 50], 
                     ylim=[-5, 105], 
                     loc='upper right', 
                     frameon=False,
                     **options)
    plt.tight_layout()
    thinkplot.save(root=root, formats=['pdf', 'png'])
```

```{code-cell} ipython3
def set_palette(*args, **kwds):
    """Set the matplotlib color cycler.
    
    args, kwds: same as for sns.color_palette
    
    Also takes a boolean kwd, `reverse`, to indicate
    whether the order of the palette should be reversed.
    
    returns: list of colors
    """
    reverse = kwds.pop('reverse', False)
    palette = sns.color_palette(*args, **kwds)
    
    palette = list(palette)
    if reverse:
        palette.reverse()
        
    cycler = plt.cycler(color=palette)
    plt.gca().set_prop_cycle(cycler)
    return palette
```

```{code-cell} ipython3
def draw_age_lines(ages):
    for age in ages:
        plt.axvline(age, color='gray', linestyle='dotted', alpha=0.3)
```

```{code-cell} ipython3
palette = set_palette('hls', 6)
ages = [28, 38, 48]
draw_age_lines(ages)
options_w = dict(title='Women in the U.S. by decade of birth')
PlotSurvivalFunctions('figs/marriage4', sf_map, None, **options_w)
```

```{code-cell} ipython3
with shelve.open('sf_map') as d:
    d['sf_map'] = sf_map
```

```{code-cell} ipython3
with shelve.open('predictions') as d:
    sf_map_pred = d['sf_map_pred']
```

```{code-cell} ipython3
options_w = dict(title='Women in the U.S. by decade of birth')

marriage.PlotSurvivalFunctions(sf_map_pred, predict_flag=True)

palette = set_palette('hls', 6)
draw_age_lines(ages)
options_w = dict(title='Women in the U.S. by decade of birth')
PlotSurvivalFunctions('figs/marriage4', sf_map, None, **options_w)
```

```{code-cell} ipython3

```

Make a table of marriage rates for each cohort at each age:

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
def MakePercentageTable(sf_map, ages):
    """Prints percentage unmarried for each cohort at each age.
    """
    t = MakeTable(sf_map, ages)
    for name, sf_seq in sorted(sf_map.items()):
        ts, ss = marriage.MakeSurvivalCI(sf_seq, [50])
        ss = ss[0]
        vals = [np.interp(age, ts, ss, right=np.nan) for age in ages]
        print(name, '&', ' & '.join('%0.0f' % (val*100) for val in vals), r'\\')
        
MakePercentageTable(sf_map, ages)
```

Generate projections:

```{code-cell} ipython3
%time sf_map_pred = marriage.EstimateSurvivalByCohort(resps, iters=iters, cutoffs=cutoffs, predict_flag=True)
del sf_map_pred[30]
del sf_map_pred[100]
```

```{code-cell} ipython3
import shelve

if SAVE_PRED:
    with shelve.open('predictions') as d:
        d['sf_map_pred'] = sf_map_pred
```

```{code-cell} ipython3
for cohort, seq in sf_map_pred.items():
    if cohort > 90:
        break
    medians = [sf.MakeCdf().Value(0.5) for sf in seq]
    print(cohort, np.median(medians))
```

And make the figure showing projections:

```{code-cell} ipython3
palette = set_palette('hls', 6)
draw_age_lines(ages)
PlotSurvivalFunctions('figs/marriage5', sf_map, sf_map_pred, **options_w)
```

Make the table again with the projections filled in.

```{code-cell} ipython3
MakePercentageTable(sf_map_pred, ages)
```

```{code-cell} ipython3
def PlotFractions(sf_map, ages, label_flag=False, **options):
    t = MakeTable(sf_map, ages)
    cohorts, cols = zip(*t)
    rows = zip(*cols)

    thinkplot.PrePlot(3)
    t = list(zip(ages, rows))
    for age, row in reversed(t):
        label = 'at age %d' % age if label_flag else ''
        thinkplot.Plot(cohorts, row, label=label, **options)
```

```{code-cell} ipython3
PlotFractions(sf_map_pred, ages, color='gray', linestyle='dashed', linewidth=2)
PlotFractions(sf_map, ages, label_flag=True, alpha=1)

#fontsize=12
#thinkplot.Text(36, 0.26, '24', fontsize=fontsize)
#thinkplot.Text(37, 0.13, '9', fontsize=fontsize)
#thinkplot.Text(37, 0.07, '7', fontsize=fontsize)

#thinkplot.Text(90, 0.85, '80', fontsize=fontsize)
#thinkplot.Text(90, 0.56, '51', fontsize=fontsize)
#thinkplot.Text(89.5, 0.47, '42', fontsize=fontsize)

#thinkplot.Text(80, 0.42, '35', fontsize=fontsize)
#thinkplot.Text(70, 0.18, '18', fontsize=fontsize)

thinkplot.Config(xlim=[34, 97], ylim=[0, 1], legend=True, loc='lower left',
                 xlabel='cohort (decade)', ylabel='Fraction ever married', 
                 title='Women in the U.S.')

thinkplot.Save(root='figs/marriage6', **options)
```

## Marriage patterns for men

```{code-cell} ipython3
%time df2 = pd.read_hdf('MaleMarriageData.hdf', 'MaleMarriageData')
df2.shape
```

```{code-cell} ipython3
for cycle, group in df2.groupby('cycle'):
    SummarizeCycle(cycle, group)
```

```{code-cell} ipython3
sum(df2.missing)
```

```{code-cell} ipython3
marriage.digitize_resp(df2)
grouped = df2.groupby('birth_index')
for name, group in iter(grouped):
    age_range = '%d--%d' % (int(group.age.min()), int(group.age_index.max()))
    print(name, '&', len(group), '&', age_range,
                '&', len(group[group.evrmarry]), '&', sum(group.missing), r'\\')
```

```{code-cell} ipython3
cutoffs2 = ComputeCutoffs(df2)
cutoffs2
```

```{code-cell} ipython3
resps2 = [group for cycle, group in df2.groupby('cycle')]
```

```{code-cell} ipython3
%time sf_map_male = marriage.EstimateSurvivalByCohort(resps2, iters=iters, cutoffs=cutoffs2)
del sf_map_male[100]
```

```{code-cell} ipython3
palette = set_palette('hls', 6)
draw_age_lines(ages)
options_m = dict(title='Men in the U.S. by decade of birth')
PlotSurvivalFunctions('figs/marriage7', sf_map_male, None, **options_m)
```

```{code-cell} ipython3
%time sf_map_male_pred = marriage.EstimateSurvivalByCohort(resps2, iters=iters, cutoffs=cutoffs2, predict_flag=True)
del sf_map_male_pred[100]
```

```{code-cell} ipython3
for cohort, seq in sf_map_male_pred.items():
    if cohort > 90:
        break
    medians = [sf.MakeCdf().Value(0.5) for sf in seq]
    print(cohort, np.median(medians))
```

```{code-cell} ipython3
palette = set_palette('hls', 5)
draw_age_lines(ages)
PlotSurvivalFunctions('figs/marriage8', sf_map_male, sf_map_male_pred, **options_m)
```

```{code-cell} ipython3
MakePercentageTable(sf_map_male, ages)
```

```{code-cell} ipython3
MakePercentageTable(sf_map_male_pred, ages)
```

```{code-cell} ipython3
PlotFractions(sf_map_male_pred, ages, color='gray', linestyle='dashed', linewidth=2)
PlotFractions(sf_map_male, ages, label_flag=True, alpha=1)

fontsize=12
thinkplot.Text(46, 0.69, '68', fontsize=fontsize)
thinkplot.Text(46, 0.30, '26', fontsize=fontsize)
thinkplot.Text(46, 0.20, '18', fontsize=fontsize)

thinkplot.Text(70, 0.18, '19', fontsize=fontsize)

thinkplot.Text(80, 0.43, '43', fontsize=fontsize)

thinkplot.Text(90, 0.89, '86', fontsize=fontsize)
thinkplot.Text(90, 0.56, '52', fontsize=fontsize)
thinkplot.Text(90, 0.40, '38', fontsize=fontsize)

thinkplot.Config(xlim=[34, 97], ylim=[0, 1], legend=True, loc='upper left',
                 xlabel='cohort (decade)', ylabel='Fraction unmarried', 
                 title='Men in the U.S.')

thinkplot.Save(root='figs/marriage9', **options)
```

```{code-cell} ipython3

```

```{code-cell} ipython3

```
