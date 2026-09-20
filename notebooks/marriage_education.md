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

# Marriage and Education

```{code-cell} ipython3
%load_ext autoreload
%autoreload 2
```

```{code-cell} ipython3
import pandas as pd

from nsfg.paths import raw, interim
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from nsfg.utils import decorate, value_counts

from nsfg.utils import add_title, add_aibm_logo, add_subtext, savefig
```

```{code-cell} ipython3
# Make the figures smaller to save some screen real estate.
plt.rcParams["figure.dpi"] = 100
plt.rcParams["figure.figsize"] = [6.75, 3.5]

# AIBM brand colors
aibm_light_gray = "#F3F4F3"
aibm_medium_gray = "#767676"
aibm_green = "#0B8569"
light_green = "#AAC9B8"
aibm_orange = "#C55300"
light_orange = "#F4A26B"
aibm_purple = "#9657A5"
light_purple = "#CFBCD0"
aibm_blue = "#4575D6"
light_blue = "#C9D3E8"

# additional colors from coolers.co
dark_gray = "#404040"
dark_purple = "#28112B"
dark_green = "#002500"
amber = "#F5BB00"
oxford_blue = "#000022"
bittersweet = "#FF6666"
crimson = "#D62839"

colors = [aibm_orange, aibm_green, aibm_blue, aibm_purple]
cycler = plt.cycler(color=colors)
plt.rc("axes", prop_cycle=cycler)

# tick and label colors
plt.rcParams["axes.edgecolor"] = aibm_medium_gray  # Spines (axis border)
plt.rcParams["xtick.color"] = aibm_medium_gray  # X-axis ticks
plt.rcParams["ytick.color"] = aibm_medium_gray  # Y-axis ticks
plt.rcParams["axes.labelcolor"] = aibm_medium_gray  # Axis labels

# remove all spines
plt.rcParams["axes.spines.top"] = False
plt.rcParams["axes.spines.right"] = False
plt.rcParams["axes.spines.left"] = False
plt.rcParams["axes.spines.bottom"] = False

# light gray horizontal grid lines
plt.rcParams["grid.color"] = aibm_light_gray
plt.rcParams["grid.linestyle"] = "-"  # Solid lines
plt.rcParams["grid.linewidth"] = 1  # Thin lines
plt.rcParams["axes.grid"] = True  # Enable grid
plt.rcParams["axes.grid.axis"] = "y"  # Apply only to horizontal lines

# Remove tick marks
plt.rcParams["xtick.major.size"] = 0
plt.rcParams["xtick.minor.size"] = 0
plt.rcParams["ytick.major.size"] = 0
plt.rcParams["ytick.minor.size"] = 0

# Use PT Sans as the default font
plt.rcParams["font.family"] = "PT Sans"
```

## Female respondents

Load the data cleaned in `clean_nsfg.ipynb`

```{code-cell} ipython3
resp = pd.read_hdf(interim("FemMarriageData.hdf"), "FemMarriageData")
resp.shape
```

```{code-cell} ipython3
value_counts(resp["cycle"])
```

```{code-cell} ipython3
evrmarry = resp["evrmarry"]
value_counts(evrmarry)
```

```{code-cell} ipython3
value_counts(resp["fmarital"])
```

```{code-cell} ipython3
pd.crosstab(resp["fmarital"], resp["cycle"], dropna=False)
```

```{code-cell} ipython3
resp["currmarr"] = resp["fmarital"] == 1
value_counts(resp["currmarr"])
```

```{code-cell} ipython3
resp.groupby("birth_index")["currmarr"].mean()
```

In the 2000s cohorts, the last age where we have a decent sample is 23.

```{code-cell} ipython3
subset = resp.query("birth_index==100")
value_counts(subset["ager"]).tail()
```

In the 1990s cohorts, the last age where we have a decent sample is 33.

```{code-cell} ipython3
subset = resp.query("birth_index==90")
value_counts(subset["ager"]).tail()
```

In the 1980s cohorts, the last age where we have a decent sample is 43.

```{code-cell} ipython3
subset = resp.query("birth_index==80")
value_counts(subset["ager"]).tail()
```

```{code-cell} ipython3
def add_married_column(resp, age):
    """Add a column indicating what fraction were married by a given age."""
    
    # Of all people interviewed >= age, how many had been married <= age
    col = f"married{age}"
    resp[col] = np.nan

    # if the respondent is not married, mark them unmarried for now
    unmarried = ~resp["evrmarry"]
    resp.loc[unmarried, col] = 0

    # if they have been married and they were married before age, mark them married
    married = resp["evrmarry"] & (resp["agemarry"] <= age)
    resp.loc[married, col] = 1

    # if they have been married, but not until after age, mark them unmarried
    married = resp["evrmarry"] & (resp["agemarry"] > age)
    resp.loc[married, col] = 0

    # if they were interviewed before age, we don't know yet, so mark them nan
    too_young = resp["ager"] < age
    resp.loc[too_young, col] = np.nan

    # if they have been married, but we don't know when, mark them nan
    missing = resp["evrmarry"] & resp["agemarry"].isna()
    resp.loc[missing, col] = np.nan
```

```{code-cell} ipython3
add_married_column(resp, 23)
value_counts(resp["married23"])
```

```{code-cell} ipython3
add_married_column(resp, 33)
value_counts(resp["married33"])
```

```{code-cell} ipython3
add_married_column(resp, 43)
value_counts(resp["married43"])
```

## Percent married by education level

+++

`anycoll` is a recode I computed, intended to indicate whether a participant attended college, regardless of whether they got a degree.

```
1982    df['anycoll'] = df['educat'] >= 13
1988    df['anycoll'] = df['educat'] >= 13
1995    df["anycoll"] = df["hieduc"] >= 10
2002    df["anycoll"] = df["hieduc"] >= 10
2010    df["anycoll"] = df["hieduc"] >= 10
2013    df["anycoll"] = df["hieduc"] >= 10
2015    df["anycoll"] = df["hieduc"] >= 10
2017    df["anycoll"] = df["hieduc"] >= 10
2019    df["anycoll"] = df["hieduc"] >= 10
2023    df["anycoll"] = df["hieduc"] >= 5
```

```{code-cell} ipython3
resp.groupby("birth_index")["anycoll"].mean()
```

`bdegree` is a recode I computed, intended to indicate whether a participant has a bachelor's degree. For the first two cycles, we don't know for sure

```
1982    df['bdegree'] = df['educat'] >= 16
1988    df['bdegree'] = df['educat'] >= 16
1995    df["bdegree"] = df["hidegree"] >= 3
2002    df["bdegree"] = df["hieduc"] >= 12
2010    df["bdegree"] = df["hieduc"] >= 12
2013    df["bdegree"] = df["hieduc"] >= 12
2015    df["bdegree"] = df["hieduc"] >= 12
2017    df["bdegree"] = df["hieduc"] >= 12
2019    df["bdegree"] = df["hieduc"] >= 12
2023    df["bdegree"] = df["hieduc"] >= 8
```

```{code-cell} ipython3
resp.groupby("birth_index")["bdegree"].mean()
```

## Marriage Tables

```{code-cell} ipython3
from collections import defaultdict
from nsfg.utils import estimate_proportion

def make_table(resp, column, weight_col='finalwgt'):
    """Make a table with birth_index down the rows and bdegree on the columns."""
    data = defaultdict(dict)
    columns = ["p", "low", "high"]
    subset = resp.dropna(subset=[column, weight_col, 'birth_index', 'bdegree'])

    # put the results in a dictionary
    for (cohort, degree), group in subset.groupby(["birth_index", "bdegree"]):
        series = group[column]
        weight = group[weight_col] / group[weight_col].mean()
        row = estimate_proportion(series, weight, confidence_level=0.84)
        data[degree][cohort + 1900] = row

    # arrange the results in a DataFrame
    frames = {}
    for degree, results in data.items():
        df = pd.DataFrame.from_dict(results, orient="index", columns=columns)
        frames[degree] = df

    table = pd.concat(frames, axis=1)
    return table * 100
```

```{code-cell} ipython3
def plot_frame(df, **options):
    """Plot an estimated series with CI"""
    plt.fill_between(df.index, df['low'], df['high'], alpha=0.2)
    plt.plot(df['p'], **options)

def plot_table(table):
    """Plot a table with columns False and True."""
    plot_frame(table[False], label='No degree')
    plot_frame(table[True], label='Degree')
```

The weights are on different scales in different cycles, so we need to group by cycle and normalize so the mean in each cycle is 1.

```{code-cell} ipython3
from nsfg.utils import normalize_weights_by_cycle

normalized = normalize_weights_by_cycle(resp)
normalized['finalwgt'].describe()
```

```{code-cell} ipython3
column = 'married23'
table23 = make_table(normalized, column)
table23
```

```{code-cell} ipython3
table33 = make_table(normalized, 'married33')
```

```{code-cell} ipython3
table43 = make_table(normalized, 'married43')
```

```{code-cell} ipython3
plot_table(table23)

title = "College-Educated Women Are (Still) Less Likely To Marry Young"
subtitle = "Percent married at or before age 23, females grouped by decade of birth"
add_title(title, subtitle)

subtext = """Shaded area shows 84% CI.
Source: NSFG 1982-2023, analysis by AIBM"""
add_subtext(subtext)

xlim = [1928, 2002]
decorate(xlabel="Decade of birth", ylabel="Percent", xlim=xlim)
inset = add_aibm_logo()
savefig("nsfg_marriage", 1, [inset])
```

```{code-cell} ipython3
plot_table(table33)

title = "College-Educated Women Were Less Likely To Marry By Age 33 — Not Any More"
subtitle = "Percent married at or before age 33, females grouped by decade of birth"
add_title(title, subtitle)

add_subtext(subtext)

ylim = [35, 100]
decorate(xlabel="Decade of birth", ylabel="Percent", xlim=xlim, ylim=ylim)
inset = add_aibm_logo()
savefig("nsfg_marriage", 3, [inset])
```

```{code-cell} ipython3
plot_table(table43)

title = "College-Educated Women Are More Likely To Get Married — But Only Slightly"
subtitle = "Percent married at or before age 43, females grouped by decade of birth"
add_title(title, subtitle)

add_subtext(subtext)

decorate(xlabel="Decade of birth", ylabel="Percent", xlim=xlim, ylim=ylim)
inset = add_aibm_logo()
savefig("nsfg_marriage", 5, [inset])
```

## Male respondents

Load the data cleaned in `clean_nsfg.ipynb`

+++

`anycoll` is a recode I computed, intended to indicate whether a participant attended college, regardless of whether they got a degree.

```
2002    df["anycoll"] = df["hieduc"] >= 10
2010    df["anycoll"] = df["hieduc"] >= 10
2013    df["anycoll"] = df["hieduc"] >= 10
2015    df["anycoll"] = df["hieduc"] >= 10
2017    df["anycoll"] = df["hieduc"] >= 10
2019    df["anycoll"] = df["hieduc"] >= 10
2023    df["anycoll"] = df["hieduc"] >= 5
```

Encoding in 2023

```
HIEDUC: Distribution Value n
Less than high school completion 1 623
12th grade, no diploma 2 169
GED or equivalent 3 153
High school graduate 4 807
Some college, no degree 5 956
Associate degree: occup, tech, or voc 6 353
Associate degree: academic 7 282
Bachelor's degree 8 1267
Master's degree 9 752
Professional degree 10 135
Doctoral degree 11 89
5586
```

```{code-cell} ipython3
resp2 = pd.read_hdf(interim("MaleMarriageData.hdf"), "MaleMarriageData")
resp2.shape
```

```{code-cell} ipython3
evrmarry = resp2["evrmarry"]
value_counts(evrmarry)
```

In the 2000s cohorts, the last age where we have a decent sample is 23.

```{code-cell} ipython3
subset = resp2.query("birth_index==100")
value_counts(subset["ager"]).tail()
```

In the 1990s cohorts, the last age where we have a decent sample is 33.

```{code-cell} ipython3
subset = resp2.query("birth_index==90")
value_counts(subset["ager"]).tail()
```

In the 1980s cohorts, the last age where we have a decent sample is 43.

```{code-cell} ipython3
subset = resp2.query("birth_index==80")
value_counts(subset["ager"]).tail()
```

```{code-cell} ipython3
add_married_column(resp2, 23)
value_counts(resp2["married23"])
```

```{code-cell} ipython3
add_married_column(resp2, 33)
value_counts(resp2["married33"])
```

```{code-cell} ipython3
add_married_column(resp2, 43)
value_counts(resp2["married43"])
```

Again, we have to normalize the sampling weights in each cycle

```{code-cell} ipython3
normalized2 = normalize_weights_by_cycle(resp2)
normalized2['finalwgt'].describe()
```

## Percent married by education level

```{code-cell} ipython3
resp2.groupby("birth_index")["anycoll"].mean()
```

```{code-cell} ipython3
resp2.groupby("birth_index")["bdegree"].mean()
```

```{code-cell} ipython3
resp2.groupby("birth_index")["evrmarry"].mean()
```

```{code-cell} ipython3
table23 = make_table(normalized2, 'married23')
```

```{code-cell} ipython3
plot_table(table23)

title = "College-educated Men Are Less Likely To Marry Young"
subtitle = "Percent married at or before age 23, males grouped by decade of birth"
add_title(title, subtitle)

subtext = """Shaded area shows 84% CI.
Source: NSFG 2002-2023, analysis by AIBM"""
add_subtext(subtext)

xlim = [1928, 2002]
decorate(xlabel="Decade of birth", ylabel="Percent", xlim=xlim)
inset = add_aibm_logo()
savefig("nsfg_marriage", 2, [inset])
```

```{code-cell} ipython3
table33 = make_table(normalized2, 'married33')
```

```{code-cell} ipython3
plot_table(table33)

title = "College-educated Men Were More Likely To Marry Before Age 33 — Not Any More"
subtitle = "Percent married at or before age 33, males grouped by decade of birth"
add_title(title, subtitle)

add_subtext(subtext)

ylim = [35, 100]
decorate(xlabel="Decade of birth", ylabel="Percent", xlim=xlim, ylim=ylim)
inset = add_aibm_logo()
savefig("nsfg_marriage", 4, [inset])
```

```{code-cell} ipython3
table43 = make_table(normalized2, 'married43')
```

```{code-cell} ipython3
plot_table(table43)

title = "College-Educated Men Are Now Much More Likely To Get Married"
subtitle = "Percent married at or before age 43, males grouped by decade of birth"
add_title(title, subtitle)

add_subtext(subtext)

decorate(xlabel="Decade of birth", ylabel="Percent", xlim=xlim, ylim=ylim)
inset = add_aibm_logo()
savefig("nsfg_marriage", 6, [inset])
```

```{code-cell} ipython3

```
