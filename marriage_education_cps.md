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
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from utils import decorate, value_counts

from utils import add_title, add_aibm_logo, add_subtext, savefig
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

## Data

Read the combined file with data up through 2022.

```{code-cell} ipython3
df22 = pd.read_stata("cps_00012.dta.gz", convert_categoricals=False)
df22.head()
```

```{code-cell} ipython3
df22['weight'] = df22['wtfinl'] / df22['wtfinl'].mean()
```

```{code-cell} ipython3
value_counts(df22['marst'])
```

```{code-cell} ipython3
df22['educ'] = df22['educ'].replace(999, np.nan)
value_counts(df22['educ'])
```

Note: 1990 and earlier, code 110 means 4 years of college. 1992 and later, code 111 means bachelor's degree. 

```{code-cell} ipython3
df22['bach'] = np.where(df22['educ'].notna(), df22['educ'] >= 110, np.nan)
value_counts(df22['bach'])
```

```{code-cell} ipython3
df22['marst'] = df22['marst'].replace(9, np.nan)
value_counts(df22['marst'])
```

```{code-cell} ipython3
df22['evrmarry'] = np.where(df22['marst'].notna(), df22['marst'] != 6, np.nan)
value_counts(df22['evrmarry'])
```

```{code-cell} ipython3
df22['married'] = np.where(df22['marst'].notna(), df22['marst'] <= 2, np.nan)
value_counts(df22['married'])
```

### 2024 data

```{code-cell} ipython3
df24_all = pd.read_csv('jun24pub.csv')
```

```{code-cell} ipython3
df24_all.columns = df24_all.columns.str.lower()
df24_all.head()
```

```{code-cell} ipython3
column_map = {
    'hryear4': 'year',
    'pwsswgt': 'wtfinl',
    'prtage': 'age',
    'pesex': 'sex',
    'ptdtrace': 'race',
    'pemaritl': 'marst',
    'peeduca': 'educa',
}
```

```{code-cell} ipython3
keys = list(column_map.keys())
df24 = df24_all[keys].rename(columns=column_map).replace(-1, np.nan)
df24.head()
```

```{code-cell} ipython3
df24['year'].describe()
```

```{code-cell} ipython3
df24['weight'] = df24['wtfinl'] / df24['wtfinl'].mean()
```

```{code-cell} ipython3
value_counts(df24['educa'])
```

```{code-cell} ipython3
df24['bach'] = np.where(df24['educa'].notna(), df24['educa'] >= 43, np.nan)
value_counts(df24['bach'])
```

```{code-cell} ipython3
value_counts(df24['marst'])
```

```{code-cell} ipython3
df24['evrmarry'] = np.where(df24['marst'].notna(), df24['marst'] != 6, np.nan)
value_counts(df24['evrmarry'])
```

```{code-cell} ipython3
df24['married'] = np.where(df24['marst'].notna(), df24['marst'] <= 2, np.nan)
value_counts(df24['married'])
```

### Combine

```{code-cell} ipython3
df_all = pd.concat([df22, df24]).dropna(subset=["marst"])
df_all.shape
```

```{code-cell} ipython3
from utils import round_into_bins

df_all["age_group"] = round_into_bins(df_all["age"], 3, low=14) + 1
df_all.groupby("age_group")["age"].describe()
```

```{code-cell} ipython3
df_all["cohort"] = df_all["year"] - df_all["age"]
value_counts(df_all['cohort'])
```

```{code-cell} ipython3
df_all["birth_group"] = round_into_bins(df_all["cohort"], 10, low=0)
```

```{code-cell} ipython3
df_all.groupby("birth_group")["cohort"].describe()
```

```{code-cell} ipython3
value_counts(df_all['marst'])
```

```{code-cell} ipython3
df_all['currmarry'] = df_all['marst'] == 1
value_counts(df_all['currmarry'])
```

```{code-cell} ipython3
table = df_all.pivot_table(index='birth_group', columns='age_group', 
                           values='evrmarry', aggfunc='mean')
```

```{code-cell} ipython3
table[42].plot(label='Age 42')
table[33].plot(label='Age 33')
table[24].plot(label='Age 24')
decorate()
```

```{code-cell} ipython3
df = df_all.dropna(subset=['age_group', 'birth_group', 'evrmarry', 'bach', 'sex']).copy()
df['bach'] = df['bach'].astype(bool)
```

```{code-cell} ipython3
df['year'].describe()
```

```{code-cell} ipython3
df['weight'].describe()
```

```{code-cell} ipython3
value_counts(df['sex'])
```

```{code-cell} ipython3
df_male = df.query('sex == 1')
df_female = df.query('sex == 2')
```

## Replicate

```{code-cell} ipython3
subset = df_female.dropna(subset=['cohort', 'bach', 'married']).query('40 <= age <= 49')
subset.shape
```

```{code-cell} ipython3
from utils import resample_rows_weighted

sample = resample_rows_weighted(subset, 'weight')
```

```{code-cell} ipython3
table = sample.pivot_table(index='cohort', columns='bach', 
                           values='married', aggfunc='mean')
table.plot()

title = "College-Educated Women Are More Likely to BE Married"
subtitle = "Percent CURRENTLY married when interviewed at age 40-49, females grouped by decade of birth"
add_title(title, subtitle)

ylim = [0.5, 1.0]
decorate(xlabel='Birth year', ylim=ylim)
```

```{code-cell} ipython3
table = sample.pivot_table(index='cohort', columns='bach', 
                           values='evrmarry', aggfunc='mean')
table.plot()

title = "College-Educated Women Are More Likely to GET Married"
subtitle = "Percent EVER married when interviewed at age 40-49, females grouped by decade of birth"
add_title(title, subtitle)

decorate(xlabel='Birth year', ylim=ylim)
```

```{code-cell} ipython3

```

```{code-cell} ipython3

```

## Female respondents

Load the data cleaned in `clean_nsfg.ipynb`

```{code-cell} ipython3
df_female.groupby("birth_group")["bach"].mean()
```

## Marriage Tables

```{code-cell} ipython3
from collections import defaultdict
from utils import estimate_proportion

def make_table(resp, column, weight_col='weight'):
    """Make a table with birth_group down the rows and bdegree on the columns."""
    data = defaultdict(dict)
    columns = ["p", "low", "high"]
    subset = resp.dropna(subset=[column, weight_col, 'birth_group', 'bach'])

    # put the results in a dictionary
    for (cohort, degree), group in subset.groupby(["birth_group", "bach"]):
        series = group[column]
        weight = group[weight_col] / group[weight_col].mean()
        row = estimate_proportion(series, weight, confidence_level=0.84)
        data[degree][cohort] = row

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
table24 = make_table(df_female.query('age_group == 24'), 'evrmarry')
table24
```

```{code-cell} ipython3
table33 = make_table(df_female.query('age_group == 33'), 'evrmarry')
table33
```

```{code-cell} ipython3
table45 = make_table(df_female.query('age_group == 45'), 'evrmarry')
table45
```

```{code-cell} ipython3
plot_table(table24)

title = "College-Educated Women Were Less Likely To Marry Young — Not Any More"
subtitle = "Percent married at or before age 23, females grouped by decade of birth"
add_title(title, subtitle)

subtext = """Shaded area shows 84% CI.
Source: CPS Fertility Supplement 1976-2024, analysis by AIBM"""
add_subtext(subtext)

xlim = [1928, 2002]
decorate(xlabel="Decade of birth", ylabel="Percent", xlim=xlim)
inset = add_aibm_logo()
savefig("figures/marriage_education_cps", 1, [inset])
```

```{code-cell} ipython3
plot_table(table33)

title = "College-Educated Women Were Less Likely To Marry By Age 33 — Now More Likely"
subtitle = "Percent married at or before age 33, females grouped by decade of birth"
add_title(title, subtitle)

add_subtext(subtext)

ylim = [35, 100]
decorate(xlabel="Decade of birth", ylabel="Percent", xlim=xlim, ylim=ylim)
inset = add_aibm_logo()
savefig("figures/marriage_education_cps", 3, [inset])
```

```{code-cell} ipython3
plot_table(table45)

title = "College-Educated Women Are More Likely To Get Married — But Only Slightly"
subtitle = "Percent married at or before age 45, females grouped by decade of birth"
add_title(title, subtitle)

add_subtext(subtext)

decorate(xlabel="Decade of birth", ylabel="Percent", xlim=xlim, ylim=ylim)
inset = add_aibm_logo()
savefig("figures/marriage_education_cps", 5, [inset])
```

## Male respondents


```{code-cell} ipython3
table24 = make_table(df_male.query('age_group == 24'), 'evrmarry')
table24
```

```{code-cell} ipython3
table33 = make_table(df_male.query('age_group == 33'), 'evrmarry')
table33
```

```{code-cell} ipython3
table45 = make_table(df_male.query('age_group == 45'), 'evrmarry')
table45
```

```{code-cell} ipython3
plot_table(table24)

title = "College-educated Men Were Less Likely To Marry Young — Not Any More"
subtitle = "Percent married at or before age 23, males grouped by decade of birth"
add_title(title, subtitle)

add_subtext(subtext)

xlim = [1928, 2002]
decorate(xlabel="Decade of birth", ylabel="Percent", xlim=xlim)
inset = add_aibm_logo()
savefig("figures/marriage_education_cps", 2, [inset])
```

```{code-cell} ipython3
plot_table(table33)

title = "College-educated Men Were Less Likely To Marry Before Age 33 — Now More Likely"
subtitle = "Percent married at or before age 33, males grouped by decade of birth"
add_title(title, subtitle)

add_subtext(subtext)

ylim = [35, 100]
decorate(xlabel="Decade of birth", ylabel="Percent", xlim=xlim, ylim=ylim)
inset = add_aibm_logo()
savefig("figures/marriage_education_cps", 4, [inset])
```

```{code-cell} ipython3
plot_table(table45)

title = "College-Educated Men Are More Likely To Get Married, But Only Slightly"
subtitle = "Percent married at or before age 45, males grouped by decade of birth"
add_title(title, subtitle)

add_subtext(subtext)

decorate(xlabel="Decade of birth", ylabel="Percent", xlim=xlim, ylim=ylim)
inset = add_aibm_logo()
savefig("figures/marriage_education_cps", 6, [inset])
```

```{code-cell} ipython3

```
