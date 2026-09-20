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

# Age at first marriage

Comparing results from NSFG and IPUMS data.

```{code-cell} ipython3
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

import shelve

from lifelines import KaplanMeierFitter

from utils import decorate
from utils import values
from utils import resample_rows_weighted
from utils import round_into_bins

from empiricaldist import Pmf, Cdf

random_seed = 12
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
def plot_kmf_map(kmf_map, cohorts, **options):
    """
    """
    fig, ax = plt.subplots()
    palette = set_palette('hls', len(cohorts))
    for cohort in cohorts:
        series = kmf_map[cohort]
        series.plot(ax=ax, label=f'{cohort+1900}s')

    decorate(xlabel='Age (years)',
             ylabel='Percent ever married',
             xlim=[13, 55], 
             **options,
             )
    
    ax.legend(title='Decade of birth', loc='lower right')
```

## NSFG original analysis

Get the curves computed in marriage.ipynb

```{code-cell} ipython3
def PercentileRow(array, p):
    """Selects the row from a sorted array that maps to percentile p.

    p: float 0--100

    returns: NumPy array (one row)
    """
    rows, cols = array.shape
    index = int(rows * p / 100)
    return array[index,]
```

```{code-cell} ipython3
def PercentileRows(ys_seq, percents):
    """Given a collection of lines, selects percentiles along vertical axis.

    For example, if ys_seq contains simulation results like ys as a
    function of time, and percents contains (5, 95), the result would
    be a 90% CI for each vertical slice of the simulation results.

    ys_seq: sequence of lines (y values)
    percents: list of percentiles (0-100) to select

    returns: list of NumPy arrays, one for each percentile
    """
    nrows = len(ys_seq)
    ncols = len(ys_seq[0])
    array = np.zeros((nrows, ncols))

    for i, ys in enumerate(ys_seq):
        array[i,] = ys

    array = np.sort(array, axis=0)

    rows = [PercentileRow(array, p) for p in percents]
    return rows
```

```{code-cell} ipython3
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
    rows = PercentileRows(ss_seq, percents)
    return ts, rows
```

```{code-cell} ipython3
def PlotSurvivalFunctions(sf_map):
    """Plot estimated survival functions.

    sf_map: map from group name to sequence of survival functions
    predict_flag: whether the lines are predicted or actual
    colormap: map from group name to color
    """
    for name, sf_seq in sorted(sf_map.items(), reverse=False):
        if len(sf_seq) == 0:
            continue

        sf = sf_seq[0]
        if len(sf) == 0:
            continue

        ts, rows = MakeSurvivalCI(sf_seq, [50])
        plt.plot(ts, 100-rows[0], label='19%ds'%name, alpha=0.8)
```

```{code-cell} ipython3
with shelve.open('sf_map') as d:
    sf_map = d['sf_map']
```

```{code-cell} ipython3
palette = set_palette('hls', 6)
PlotSurvivalFunctions(sf_map)
decorate()
```

## NSFG corrected analysis

Load the data cleaned in clean_nsfg.ipynb and run the analysis with `lifelines`

```{code-cell} ipython3
%time unweighted = pd.read_hdf('FemMarriageData.hdf', 'FemMarriageData')
unweighted.shape
```

```{code-cell} ipython3
dfs = []

np.random.seed(random_seed)
for name, group in unweighted.groupby('cycle'):
    df = resample_rows_weighted(group, 'finalwgt')
    dfs.append(df)
    
nsfg_female = pd.concat(dfs).reset_index(drop=True)
```

```{code-cell} ipython3
evrmarry = nsfg_female['evrmarry']
values(evrmarry)
```

```{code-cell} ipython3
invalid = evrmarry & nsfg_female['agemarry'].isna()
invalid.sum()
```

```{code-cell} ipython3
cdf = Cdf.from_seq(nsfg_female['age'], name='age')
cdf.plot()
decorate()
```

```{code-cell} ipython3
cdf = Cdf.from_seq(nsfg_female['agemarry'], name='agemarry')
cdf.plot()
decorate()
```

```{code-cell} ipython3
nsfg_female['observed'] = nsfg_female['evrmarry']
nsfg_female.loc[evrmarry, 'duration'] = nsfg_female['agemarry']
nsfg_female.loc[~evrmarry, 'duration'] = nsfg_female['age']
```

```{code-cell} ipython3
values(nsfg_female['birth_index'])
```

```{code-cell} ipython3
def make_kmf_map(grouped):
    kmf_map = {}

    for cohort, group in grouped:
        kmf = KaplanMeierFitter()
        kmf.fit(group['duration'], group['observed'])
        series = (1 - kmf.survival_function_['KM_estimate']) * 100
        series.name = cohort
        kmf_map[cohort] = series
        
    return kmf_map
```

```{code-cell} ipython3
grouped = nsfg_female.dropna(subset='duration').groupby('birth_index')
nsfg_map = make_kmf_map(grouped)
```

```{code-cell} ipython3
cohorts = range(40, 100, 10)
plot_kmf_map(nsfg_map, cohorts, title='U.S. Women, NSFG')
```

## NSFG time between marriages

```{code-cell} ipython3
values(nsfg_female['cycle'])
```

In the last two cycles, the `mardat` variables are in years rather than century-months.

```{code-cell} ipython3
subset = nsfg_female.query('cycle <= 9')
```

```{code-cell} ipython3
subset['mardat01'].notna().sum()
```

```{code-cell} ipython3
subset['mardat02'].notna().sum()
```

```{code-cell} ipython3
subset['mardat03'].notna().sum()
```

```{code-cell} ipython3
subset['mardat04'].notna().sum()
```

```{code-cell} ipython3
time_between_two = (subset['mardat02'] - subset['mardat01']) / 12
pmf_two = Pmf.from_seq(time_between_two, name='first and second')
pmf_two.make_cdf().plot()
decorate(xlabel='Time between first two marriages')
```

```{code-cell} ipython3
time_between_three = (subset['mardat03'] - subset['mardat01']) / 12
pmf_three = Pmf.from_seq(time_between_three, name='first and third')
pmf_three.make_cdf().plot()
decorate(xlabel='Time between first three marriages')
```

```{code-cell} ipython3
from scipy.stats import gaussian_kde

kde_two = gaussian_kde(time_between_two.dropna())
kde_three = gaussian_kde(time_between_three.dropna())

qs = np.linspace(0, 25)
ps = kde_two(qs)
pmf = Pmf(ps, qs)
pmf.normalize()
pmf.make_cdf().plot(color='gray')

ps = kde_three(qs)
pmf = Pmf(ps, qs)
pmf.normalize()
pmf.make_cdf().plot(color='gray')

pmf_two.make_cdf().plot()
pmf_three.make_cdf().plot()
decorate(xlabel='Time between first two marriages')
```

```{code-cell} ipython3
np.percentile(time_between_two.dropna(), [50])
```

```{code-cell} ipython3
np.percentile(time_between_three.dropna(), [50])
```

## IPUMS data

Includes 10% sample from years 2008-2022, excluding 2020.

2008 is the first year that includes MARRNO and YRMARR.

2020 uses "experimental weights" to correct for the effect of the pandemic on data collection

```{code-cell} ipython3
unweighted = pd.read_csv('usa_00002.csv.gz')
unweighted.shape
```

```{code-cell} ipython3
unweighted.head()
```

Resample

```{code-cell} ipython3
np.random.seed(random_seed)
df = resample_rows_weighted(unweighted, 'PERWT').reset_index(drop=True)
```

```{code-cell} ipython3
df.head()
```

```{code-cell} ipython3
values(df['YEAR'])
```

```{code-cell} ipython3
values(df['SEX'])
```

```{code-cell} ipython3
df['AGE'].isna().sum()
```

```{code-cell} ipython3
cdf_age = Cdf.from_seq(df['AGE'], name='age')
cdf_age.plot()
decorate(ylabel='CDF')
```

```{code-cell} ipython3
df['BIRTHYR'].isna().sum()
```

```{code-cell} ipython3
df['BIRTHYR'].describe()
```

```{code-cell} ipython3
cdf_birthyr = Cdf.from_seq(df['BIRTHYR'], name='birth year')
cdf_birthyr.plot()
decorate(ylabel='CDF')
```

```{code-cell} ipython3
values(df['MARRNO'])
```

```{code-cell} ipython3
married0 = df['MARRNO'] == 0
married0.mean()
```

```{code-cell} ipython3
married1 = df['MARRNO'] == 1
married1.mean()
```

```{code-cell} ipython3
married2 = df['MARRNO'] == 2
married2.mean()
```

`married3` actually means three or more times

```{code-cell} ipython3
married3 = df['MARRNO'] == 3
married3.mean()
```

```{code-cell} ipython3
df['cohort10'] = round_into_bins(df, 'BIRTHYR', 10) - 1900
```

```{code-cell} ipython3
millennial1 = df['BIRTHYR'].between(1981, 1988)
millennial1.sum()
```

```{code-cell} ipython3
millennial2 = df['BIRTHYR'].between(1989, 1995)
millennial2.sum()
```

```{code-cell} ipython3
genz1 = df['BIRTHYR'].between(1996, 2003)
genz1.sum()
```

```{code-cell} ipython3
genz2 = df['BIRTHYR'].between(2004, 2012)
genz2.sum()
```

```{code-cell} ipython3
df['gen'] = np.nan
df.loc[millennial1, 'gen'] = 1
df.loc[millennial2, 'gen'] = 2
df.loc[genz1, 'gen'] = 3
df.loc[genz2, 'gen'] = 4
```

```{code-cell} ipython3
values(df['gen'])
```

Set up the values we need for Kaplan-Meier estimation

```{code-cell} ipython3
df['agemarr'] = df['YRMARR'] - df['BIRTHYR']
df['duration'] = np.nan
df['observed'] = np.nan
```

```{code-cell} ipython3
df.loc[married0, 'duration'] = df.loc[married0, 'AGE']
df.loc[married0, 'observed'] = 0
```

```{code-cell} ipython3
df.loc[married1, 'duration'] = df.loc[married1, 'agemarr']
df.loc[married1, 'observed'] = 1
```

For people married more than once, `YRMARR` is the year of the *last marriage*, so we have to treat year of first marriage as missing data.

```{code-cell} ipython3
def fill_missing(df):
    df['filled'] = np.nan

    for cohort in range(10, 110, 10):
        # find people in this cohort who have been married once
        donors = (df['cohort10'] == cohort) & (df['MARRNO'] == 1)

        # select their ages when married
        agemarr = df.loc[donors, 'agemarr']
        low, high = np.percentile(agemarr, [2, 98])
        index = agemarr.between(low, high)

        # find people in this cohort married more than once 
        missing = (df['cohort10'] == cohort) & (df['MARRNO'] > 1)
        n = missing.sum()

        # fill missing data with a random sample
        sample = np.random.choice(agemarr[index], size=n, replace=True)
        df.loc[missing, 'filled'] = sample
```

```{code-cell} ipython3
np.random.seed(random_seed)
fill_missing(df)
df['filled'].describe()
```

```{code-cell} ipython3
df.loc[married2, 'duration'] = np.minimum(df.loc[married2, 'filled'], 
                                          df.loc[married2, 'agemarr'])
df.loc[married2, 'observed'] = 1
```

```{code-cell} ipython3
df.loc[married3, 'duration'] = np.minimum(df.loc[married3, 'filled'], 
                                          df.loc[married3, 'agemarr'])
df.loc[married3, 'observed'] = 1
```

```{code-cell} ipython3
df['duration'].isna().sum()
```

```{code-cell} ipython3
agemarr_cdf = Cdf.from_seq(df['agemarr'])
```

```{code-cell} ipython3
subset = df.query('cohort10 == 50')
values(subset['MARRNO'])
```

```{code-cell} ipython3
Cdf.from_seq(subset.loc[married0, 'duration']).plot(label='marrno==0')
Cdf.from_seq(subset.loc[married1, 'duration']).plot(label='marrno==1')
Cdf.from_seq(subset.loc[married2, 'duration']).plot(label='marrno==2')
Cdf.from_seq(subset.loc[married3, 'duration']).plot(label='marrno>=3')
decorate()
```

```{code-cell} ipython3
grouped = df.query('SEX==2').groupby('cohort10')
kmf_map = make_kmf_map(grouped)

cohorts = range(40, 110, 10)
plot_kmf_map(kmf_map, cohorts, title='U.S. Women, 2008-2022 IPUMS')
```

```{code-cell} ipython3
cohort = 50
sf_map_subset = {key: sf_map[key] for key in [cohort] if key in sf_map}
PlotSurvivalFunctions(sf_map_subset)

nsfg_map[cohort].plot(label='NSFG corrected')
kmf_map[cohort].plot(label='ipums')

decorate(xlim=[13, 53])
```

Now the men

```{code-cell} ipython3
grouped = df.query('SEX==1').groupby('cohort10')
kmf_map = make_kmf_map(grouped)
plot_kmf_map(kmf_map, cohorts, title='U.S. Men, 2008-2022 IPUMS')
```

The male and female curves are substantially different

```{code-cell} ipython3
grouped = df.query('SEX==2').groupby('cohort10')
kmf_map2 = make_kmf_map(grouped)

fig, ax = plt.subplots()
palette = set_palette('hls', len(cohorts))
for cohort in cohorts:
    series = kmf_map2[cohort]
    series.plot(ax=ax, label='', color='gray', alpha=0.4)
    series = kmf_map[cohort]
    series.plot(ax=ax, label=f'{cohort+1900}s')

decorate(xlabel='Age (years)',
         ylabel='Percent ever married',
         xlim=[13, 55]
         )

ax.legend(title='Decade of birth', loc='lower right');
```

I thought the old people might cause a problem, but they don't.

```{code-cell} ipython3
grouped = df.query('AGE<=65 and SEX==1').groupby('cohort10')
kmf_map2 = make_kmf_map(grouped)

fig, ax = plt.subplots()
palette = set_palette('hls', len(cohorts))
for cohort in cohorts:
    series = kmf_map2[cohort]
    series.plot(ax=ax, label='', color='gray', alpha=0.4)
    series = kmf_map[cohort]
    series.plot(ax=ax, label=f'{cohort+1900}s')

decorate(xlabel='Age (years)',
         ylabel='Percent ever married',
         xlim=[13, 55]
         )

ax.legend(title='Decade of birth', loc='lower right');
```

```{code-cell} ipython3

```
