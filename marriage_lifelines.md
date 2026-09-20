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

```{code-cell} ipython3
%load_ext autoreload
%autoreload 2
```

```{code-cell} ipython3
%load_ext nb_black
```

```{code-cell} ipython3
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from lifelines import KaplanMeierFitter

from utils import decorate
from utils import value_counts
from utils import resample_by_cycle
from utils import round_into_bins
from utils import remove_spines

from empiricaldist import Pmf, Cdf

random_seed = 1
```

```{code-cell} ipython3
# Make the figures smaller to save some screen real estate.
plt.rcParams["figure.dpi"] = 75
plt.rcParams["figure.figsize"] = [5, 3.7]
```

```{code-cell} ipython3
from utils import set_palette, resample_by_cycle
```

## Age at first marriage, female respondents

Load the data cleaned in `clean_nsfg.ipynb` and run the analysis with `lifelines`

```{code-cell} ipython3
%time resp = pd.read_hdf('FemMarriageData.hdf', 'FemMarriageData')
resp.shape
```

```{code-cell} ipython3
evrmarry = resp["evrmarry"]
value_counts(evrmarry)
```

```{code-cell} ipython3
for name, group in resp.groupby("birth_index"):
    missing = group["evrmarry"] & group["agemarry"].isna()
    print(name, missing.sum())
```

```{code-cell} ipython3
sample = resample_by_cycle(resp)
```

```{code-cell} ipython3
value_counts(sample["birth_index"])
```

```{code-cell} ipython3
def drop_missing(df):
    # find people who are married but have no agemarry
    missing = df["evrmarry"] & df["agemarry"].isna()
    return df[~missing]
```

```{code-cell} ipython3
def fill_missing(df):
    for cohort in range(30, 110, 10):
        # find people in this cohort who are married but have no agemarry
        missing = (df["birth_index"] == cohort) & df["evrmarry"] & df["agemarry"].isna()
        n = missing.sum()
        if n == 0:
            continue

        # find people in this cohort who have been married once
        donors = (df["birth_index"] == cohort) & df["evrmarry"] & df["agemarry"].notna()

        # select their ages when married
        agemarry = df.loc[donors, "agemarry"]
        low, high = np.percentile(agemarry, [1, 99])
        index = agemarry.between(low, high)

        # fill missing data with a random sample
        sample = np.random.choice(agemarry[index], size=n, replace=True)
        df.loc[missing, "agemarry"] = sample
```

```{code-cell} ipython3
# fill_missing(sample)
sample = drop_missing(sample)

missing = sample["evrmarry"] & sample["agemarry"].isna()
missing.sum()
```

```{code-cell} ipython3
cdf = Cdf.from_seq(sample["ager"], name="age")
cdf.plot()
decorate()
```

```{code-cell} ipython3
cdf = Cdf.from_seq(sample["agemarry"], name="agemarry")
cdf.plot()
decorate()
```

```{code-cell} ipython3
from utils import make_kmf_map
```

```{code-cell} ipython3
evrmarry = sample["evrmarry"]
sample["observed"] = evrmarry
sample.loc[evrmarry, "duration"] = sample["agemarry"]
sample.loc[~evrmarry, "duration"] = sample["ager"]
```

```{code-cell} ipython3
grouped = sample.groupby("birth_index")
nsfg_map = make_kmf_map(grouped)
```

```{code-cell} ipython3
from utils import add_text
```

```{code-cell} ipython3
def make_title(title, subtitle, pad=30):
    plt.title(title, loc="left", pad=pad)
    add_text(0, 1.085, subtitle)
    add_text(0, 1.015, "Analysis: allendowney.com/blog")
```

```{code-cell} ipython3
def decorate_plot(subtitle="", **options):
    decorate(
        xlabel="Age",
        ylabel="Percent",
        xlim=[13, 55],
        **options,
    )
    title = "Percent ever married"
    make_title(title, subtitle)
```

```{code-cell} ipython3
def plot_kmf_map(ax, kmf_map, cohorts, **options):
    """ """
    palette = set_palette("nipy_spectral", len(cohorts), reverse=True)
    for cohort in cohorts:
        series = kmf_map[cohort]
        label = f"{cohort+1900}s"
        series.plot(ax=ax, label=label, **options)
        label = ""
```

```{code-cell} ipython3
cohorts = range(40, 110, 10)

fig, ax = plt.subplots()
plot_kmf_map(ax, nsfg_map, cohorts)
decorate_plot(subtitle="Females by decade of birth, NSFG 1982-2023")
remove_spines()
plt.tight_layout()
```

```{code-cell} ipython3
def make_kmf_series(resp, iters=21):
    kmf_series = {}

    for i in range(iters):
        sample = resample_by_cycle(resp)
        sample = drop_missing(sample)
        evrmarry = sample["evrmarry"]
        sample["observed"] = evrmarry
        sample.loc[evrmarry, "duration"] = sample["agemarry"]
        sample.loc[~evrmarry, "duration"] = sample["ager"]
        grouped = sample.groupby("birth_index")
        kmf_map = make_kmf_map(grouped)
        for cohort in kmf_map:
            kmf_series.setdefault(cohort, []).append(kmf_map[cohort])

    return kmf_series
```

```{code-cell} ipython3
from utils import adjust_legend


def plot_kmf_series(kmf_series, cohorts, subtitle):
    # always make 7 colors, but only use the last n of them
    palette = sns.color_palette("nipy_spectral", 7)
    palette.reverse()
    n = len(cohorts)
    palette = palette[-n:]

    options = dict(alpha=0.1)

    for i, cohort in enumerate(cohorts):
        label = f"{cohort+1900}s"
        series_list = kmf_series[cohort]
        coords = []
        for series in series_list:
            coords.append((series.index[-1], series.iloc[-1]))
            series.plot(label=label, color=palette[i], **options)
            # only label the first line
            label = ""

    decorate_plot(subtitle, loc="lower right")
    adjust_legend(alpha=1, lw=2)
    remove_spines()
    plt.tight_layout()
```

```{code-cell} ipython3
kmf_series = make_kmf_series(resp)
```

```{code-cell} ipython3
plot_kmf_series(
    kmf_series, cohorts, subtitle="Females by decade of birth, NSFG 1982-2023"
)
plt.savefig("marriage_female23.png", dpi=300)
```

## Age at first marriage, male respondents

Load the data cleaned in `clean_nsfg.ipynb` and run the analysis with `lifelines`

```{code-cell} ipython3
%time resp2 = pd.read_hdf('MaleMarriageData.hdf', 'MaleMarriageData')
resp.shape
```

```{code-cell} ipython3
evrmarry = resp2["evrmarry"]
value_counts(evrmarry)
```

```{code-cell} ipython3
for name, group in resp2.groupby("birth_index"):
    missing = group["evrmarry"] & group["agemarry"].isna()
    print(name, missing.sum())
```

```{code-cell} ipython3
sample = resample_by_cycle(resp2)
```

```{code-cell} ipython3
value_counts(sample["birth_index"])
```

```{code-cell} ipython3
sample = drop_missing(sample)

missing = sample["evrmarry"] & sample["agemarry"].isna()
missing.sum()
```

```{code-cell} ipython3
cdf = Cdf.from_seq(sample["ager"], name="age")
cdf.plot()
decorate()
```

```{code-cell} ipython3
cdf = Cdf.from_seq(sample["agemarry"], name="agemarry")
cdf.plot()
decorate()
```

```{code-cell} ipython3
evrmarry = sample["evrmarry"]
sample["observed"] = evrmarry
sample.loc[evrmarry, "duration"] = sample["agemarry"]
sample.loc[~evrmarry, "duration"] = sample["ager"]
```

```{code-cell} ipython3
grouped = sample.groupby("birth_index")
nsfg_map = make_kmf_map(grouped)
```

```{code-cell} ipython3

```

```{code-cell} ipython3
cohorts = range(50, 110, 10)

fig, ax = plt.subplots()
plot_kmf_map(ax, nsfg_map, cohorts)

decorate_plot(subtitle="Males by decade of birth, NSFG 1982-2023")
remove_spines()
plt.tight_layout()
```

```{code-cell} ipython3
kmf_series = make_kmf_series(resp2)
```

```{code-cell} ipython3
plot_kmf_series(
    kmf_series, cohorts, subtitle="Males by decade of birth, NSFG 1982-2023"
)
plt.savefig("marriage_male23.png", dpi=300)
```

```{code-cell} ipython3

```

```{code-cell} ipython3

```

```{code-cell} ipython3

```

```{code-cell} ipython3

```
