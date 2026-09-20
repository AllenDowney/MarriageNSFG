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

```{code-cell} ipython3
%load_ext autoreload
%autoreload 2
%load_ext nb_black
```

```{code-cell} ipython3
import pandas as pd

from nsfg.paths import raw, interim
import numpy as np
import matplotlib.pyplot as plt

from nsfg.utils import decorate, value_counts
from nsfg.utils import add_title, add_logo, add_subtext
```

## Configure matplotlib

+++

To install PT Sans:

```
sudo apt install fonts-paratype
fc-cache -fv
fc-list | grep "PT Sans"
rm ~/.cache/matplotlib/fontlist-v390.json 
```

Restart Python/Jupyter and run the following:

```{code-cell} ipython3
import matplotlib.font_manager as fm

# Get list of available fonts
available_fonts = set(f.name for f in fm.fontManager.ttflist)

# Check for specific fonts
print("PT Sans is available:", "PT Sans" in available_fonts)
print("Skolar Sans is available:", "Skolar Sans" in available_fonts)
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

rainbow = [crimson, aibm_orange, amber, aibm_green, aibm_blue, aibm_purple]
plt.rcParams["axes.prop_cycle"] = plt.cycler(color=rainbow)

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

## Female Data

```{code-cell} ipython3
df = pd.read_parquet(interim("FemMarriageData.parquet"))
df.shape
```

```{code-cell} ipython3
df.columns
```

```{code-cell} ipython3
df.groupby("cycle")["finalwgt"].describe()
```

```{code-cell} ipython3
pd.crosstab(df["parity"], df["cycle"])
```

```{code-cell} ipython3
trimmed = df["parity"] > 12
df.loc[trimmed, "parity"] = np.nan
```

```{code-cell} ipython3
pd.crosstab(df["addexp"], df["cycle"])
```

```{code-cell} ipython3
trimmed = df["addexp"] > 12
df.loc[trimmed, "addexp"] = np.nan
```

```{code-cell} ipython3
pd.crosstab(df["age_index"], df["cycle"])
```

```{code-cell} ipython3
age_min = 14
age_max = 55
age_step = 3
age_bins = np.arange(age_min, age_max, age_step)

df["age_group"] = np.digitize(df["ager"], age_bins) * age_step
df["age_group"] += age_min - 2
df.loc[df["ager"].isnull(), "age_index"] = np.nan
```

```{code-cell} ipython3
from nsfg.utils import round_into_bins

df["age_group"] = round_into_bins(df["ager"], 3, low=14) + 1
```

```{code-cell} ipython3
pd.crosstab(df["age_group"], df["cycle"])
```

```{code-cell} ipython3
pd.crosstab(df["birth_index"], df["cycle"])
```

```{code-cell} ipython3
value_counts(df["intent"])
```

```{code-cell} ipython3
df["intent_yes"] = np.where(df["intent"].isna(), np.nan, df["intent"] == 1)
df["want_yes"] = np.where(df["rwant"].isna(), np.nan, df["rwant"] == 1)
df["child_yes"] = np.where(df["parity"].isna(), np.nan, df["parity"] > 0)
```

```{code-cell} ipython3
# R is surgically sterile at interview due to tubal sterilization
# R is surgically sterile at interview due to hysterectomy
# Type of sterilization operation in effect is "other female operation"

df["strl_tubs"] = df["tubs"] == 1
df["strl_yes"] = (df["tubs"] == 1) | (df["hyst"] == 1) | (df["strloper"] == 4)
value_counts(df["strl_yes"])
```

```{code-cell} ipython3
(df["tubs"] == 1).mean() / df["strl_yes"].mean()
```

### Do responses depend on mode?

```{code-cell} ipython3
df["ftfmode"].value_counts(normalize=True)
```

```{code-cell} ipython3
df.groupby("ftfmode")["want_yes"].mean()
```

```{code-cell} ipython3
df.groupby(["birth_index", "ftfmode"])["want_yes"].mean()
```

```{code-cell} ipython3
df.groupby("ftfmode")["intent_yes"].mean()
```

```{code-cell} ipython3
df.groupby(["birth_index", "ftfmode"])["intent_yes"].mean()
```

```{code-cell} ipython3
df.groupby("ftfmode")["parity"].mean()
```

```{code-cell} ipython3
df.groupby(["birth_index", "ftfmode"])["parity"].mean()
```

### Resampling

```{code-cell} ipython3
from nsfg.utils import resample_by_cycle

sample = resample_by_cycle(df)
```

```{code-cell} ipython3
sample.groupby(["birth_index", "ftfmode"])["want_yes"].mean()
```

```{code-cell} ipython3
def make_table(df, var, drop_cols=[30, 40]):
    table = df.groupby(["age_group", "birth_index"])[var].mean().unstack()
    table.drop(columns=drop_cols, errors="ignore", inplace=True)
    table.columns = [f"{1900+cohort}s" for cohort in table.columns]
    return table
```

```{code-cell} ipython3
from nsfg.utils import set_palette


def plot_table(table):
    """ """
    rows, cols = table.shape
    # set_palette("nipy_spectral", cols, reverse=True)
    table.plot(ax=plt.gca())
```

### Checking for data problems

```{code-cell} ipython3
table = df.groupby(["cycle", "birth_index"])["parity"].mean().unstack()
table.plot()
```

### Simple example to test functions

```{code-cell} ipython3
table = make_table(sample, "want_yes") * 100
cohorts = table.columns
ages = table.index
```

```{code-cell} ipython3
plot_table(table)
title = "Percent who want to have another child"
subtitle = "Females by age group and decade of birth, NSFG 1982-2023 "
add_title(title, subtitle)

subtext = """
Long line of subtext so we can see if it collides with the xlabel and here's even more text
Source: a very long line of source information so we can see where it aligns with the logo"""
inset = add_subtext(subtext)

decorate(xlabel="Age", ylabel="Percent")
None
```

```{code-cell} ipython3
from nsfg.utils import percentile_rows


def plot_table_with_errors(tables, cohorts, ages):
    table = tables[0]
    rows, cols = table.shape
    # set_palette("nipy_spectral", len(cohorts), reverse=True)

    for cohort in cohorts:
        frame = pd.DataFrame(columns=ages)
        for i, table in enumerate(tables):
            frame.loc[i] = table[cohort]

        # using the 84% CI, so non-overlapping corresponds to
        # a difference that's significant at 5% level
        low, median, high = percentile_rows(frame, [8, 50, 92])
        plt.fill_between(ages, low, high, alpha=0.15)
        plt.plot(ages, median, label=cohort, alpha=0.6)
```

```{code-cell} ipython3
from nsfg.marriage import underride


def add_question_text(text, **options):
    underride(
        options, ha="left", va="bottom", color="0.2", fontname="PT Sans", fontsize=9
    )
    ax = plt.gca()
    ax.text(0.04, 0.05, text, transform=ax.transAxes, **options)
```

```{code-cell} ipython3
def summarize_age_groups(df, var, age_groups):
    columns = np.sort(df["birth_index"].unique())
    res = pd.DataFrame(dtype=float, columns=columns)

    for i in range(101):
        sample = resample_by_cycle(df).query("age_group in @age_groups")
        row = sample.groupby("birth_index")[var].mean() * 100
        res.loc[i] = row

    return res.mean(axis=0)
```

```{code-cell} ipython3
def summarize_age_group(tables, age_group):
    df = pd.DataFrame(dtype=float, columns=tables[0].columns)

    for i, table in enumerate(tables):
        df.loc[i] = table.loc[age_group]

    return df.mean()
```

```{code-cell} ipython3
from nsfg.utils import savefig
```

### Intend to have another child

Looking to the future, do you intend to have a/another baby at some time?

```{code-cell} ipython3
tables = [make_table(resample_by_cycle(df), "intent_yes") * 100 for i in range(101)]
```

```{code-cell} ipython3
plot_table_with_errors(tables, cohorts, ages)
title = "Young Women Are Less Likely To Intend To Have a Child"
subtitle = (
    "Percent who intend to have a/another child, women grouped by decade of birth"
)
add_title(title, subtitle)

subtext = """
Responses to "Looking to the future, do you intend to have a/another baby at some time?"
Source: NSFG 1982-2023"""
inset = add_subtext(subtext)

decorate(xlabel="Age", ylabel="Percent")
logo = add_logo()
savefig("nsfg_intent", 3, [inset, logo])
```

```{code-cell} ipython3
age_groups = [15, 18, 21, 24]
summarize_age_groups(df, "intent_yes", age_groups).dropna()
```

### Percent who want to have another child

Looking to the future, do you, yourself, _want_ to have a/another baby at
some time?

```{code-cell} ipython3
tables = [make_table(resample_by_cycle(df), "want_yes") * 100 for i in range(101)]
```

```{code-cell} ipython3
plot_table_with_errors(tables, cohorts, ages)
title = "Young Women Are Less Likely To Want To Have a Baby"
subtitle = "Percent who want to have a/another baby, women grouped by decade of birth"
add_title(title, subtitle)

subtext = """
Responses to "Looking to the future, do you, yourself, $want$ to have a/another baby at some time?"
Source: NSFG 1982-2023"""
inset = add_subtext(subtext)

decorate(xlabel="Age", ylabel="Percent")
logo = add_logo()
savefig("nsfg_intent", 2, [inset, logo])
```

```{code-cell} ipython3
summarize_age_group(tables, 24)
```

```{code-cell} ipython3
summarize_age_group(tables, 24)
```

"Among women aged 15 to 24 in this birth cohort, 76% say they want to become mothers, markedly lower than the 87% for women born in the 1980s and 1990s"

```{code-cell} ipython3
age_groups = [15, 18, 21, 24]
summarize_age_groups(df, "want_yes", age_groups).dropna()
```

### Number of live births

parity is a recoded variable, so there's no single question it corresponds to

```{code-cell} ipython3
tables = [make_table(resample_by_cycle(df), "parity") for i in range(101)]
```

```{code-cell} ipython3
summary = summarize_age_group(tables, 24)
summary.round(1)
```

```{code-cell} ipython3
summary = summarize_age_group(tables, 33)
summary.round(1)
```

```{code-cell} ipython3
plot_table_with_errors(tables, cohorts, ages)
title = "Young Women Are On Track To Have Fewer Children, Later"
subtitle = "Average number of live births, women grouped decade of birth"
add_title(title, subtitle)

subtext = """
Calculated parity. Source: NSFG 1982-2023"""
inset = add_subtext(subtext)

decorate(xlabel="Age")
logo = add_logo()
savefig("nsfg_intent", 1, [inset, logo])
```

### Percent who have born at least one child

`child_yes` is based on `parity`, which is a recode, so there's not a single question

```{code-cell} ipython3
tables = [make_table(resample_by_cycle(df), "child_yes") * 100 for i in range(101)]
```

```{code-cell} ipython3
plot_table_with_errors(tables, cohorts, ages)
title = "Descriptive headline"
subtitle = "Percent who have borne at least one child, women grouped by decade of birth"
add_title(title, subtitle)

# subtext: Question, NSFG 1982-2023 "

decorate(xlabel="Age")
```

### Expected additional births

`addexp` is a recoded "sentral number of additional births expected", based on a series of questions including "smallest" and "largest" number of babies

```{code-cell} ipython3
tables = [make_table(resample_by_cycle(df), "addexp") for i in range(101)]
```

```{code-cell} ipython3
plot_table_with_errors(tables, cohorts, ages)
title = "Average number of additional births expected"
subtitle = "Females by decade of birth, NSFG 1982-2023 "
add_title(title, subtitle)

decorate(xlabel="Age")
```

### Sterilizing operations

`strl_yes` includes tubal ligation, hysterectory, and "other operation"

`strl_tubs` is only tubal ligation

```{code-cell} ipython3
df.groupby("cycle")["strl_yes"].mean()
```

```{code-cell} ipython3
recent = df.query("cycle >=6")
```

```{code-cell} ipython3
tables = [make_table(resample_by_cycle(recent), "strl_yes") * 100 for i in range(101)]
```

```{code-cell} ipython3
plot_table_with_errors(tables, cohorts, ages)
title = "Percent who have received surgical sterilization"
subtitle = "Females by decade of birth, NSFG 1982-2023 "
add_title(title, subtitle)

decorate(xlabel="Age")
```

## Male data

```{code-cell} ipython3
df2 = pd.read_parquet(interim("MaleMarriageData.parquet"))
df2.shape
```

```{code-cell} ipython3
df2.columns
```

```{code-cell} ipython3
df2.groupby("cycle")["finalwgt"].describe()
```

```{code-cell} ipython3
pd.crosstab(df2["addexp"], df2["cycle"])
```

```{code-cell} ipython3
trimmed = df2["addexp"] > 12
df2.loc[trimmed, "addexp"] = np.nan
```

```{code-cell} ipython3
pd.crosstab(df2["age_index"], df2["cycle"])
```

```{code-cell} ipython3
from nsfg.utils import round_into_bins

df2["age_group"] = round_into_bins(df2["ager"], 3, low=14) + 1
```

```{code-cell} ipython3
pd.crosstab(df2["age_group"], df2["cycle"])
```

```{code-cell} ipython3
pd.crosstab(df2["birth_index"], df2["cycle"])
```

```{code-cell} ipython3
value_counts(df2["intent"])
```

```{code-cell} ipython3
df2["intent_yes"] = np.where(df2["intent"].isna(), np.nan, df2["intent"] == 1)
df2["want_yes"] = np.where(df2["rwant"].isna(), np.nan, df2["rwant"] == 1)
df2["child_yes"] = np.where(df2["numbiokid"].isna(), np.nan, df2["numbiokid"] > 0)
```

```{code-cell} ipython3
# Have you ever had a vasectomy or any other operation that makes it
# impossible for you to father a child?
df2["strl_yes"] = np.where(df2["everoper"].isna(), np.nan, df2["everoper"] == 1)
```

### Do the responses depend on mode?

```{code-cell} ipython3
df2["ftfmode"].value_counts(normalize=True)
```

```{code-cell} ipython3
df2.groupby("ftfmode")["want_yes"].mean()
```

```{code-cell} ipython3
df2.groupby(["birth_index", "ftfmode"])["want_yes"].mean()
```

```{code-cell} ipython3
df2.groupby("ftfmode")["intent_yes"].mean()
```

```{code-cell} ipython3
df2.groupby(["birth_index", "ftfmode"])["intent_yes"].mean()
```

```{code-cell} ipython3
df2.groupby("ftfmode")["numbiokid"].mean()
```

```{code-cell} ipython3
df2.groupby(["birth_index", "ftfmode"])["numbiokid"].mean()
```

```{code-cell} ipython3
from nsfg.utils import resample_by_cycle

sample = resample_by_cycle(df2)
```

```{code-cell} ipython3
table = make_table(sample, "want_yes") * 100
cohorts = table.columns
ages = table.index
```

```{code-cell} ipython3
plot_table(table)
title = "Percent who want to have another child"
subtitle = "Males by decade of birth, NSFG 2002-2023 "
add_title(title, subtitle)

decorate(xlabel="Age", ylabel="Percent")
```

### Want

`rwant`

Looking to the future, do you, yourself, want to have another child at some time?

```{code-cell} ipython3
tables = [make_table(resample_by_cycle(df2), "want_yes") * 100 for i in range(101)]
```

```{code-cell} ipython3
plot_table_with_errors(tables, cohorts, ages)
title = "Young Men Are Less Likely To Want To Have a Child"
subtitle = "Percent who want to have a/another child, men grouped by decade of birth"
add_title(title, subtitle)

subtext = """
Responses to "Looking to the future, do you, yourself, $want$ to have a/another child at some time?"
Source: NSFG 1982-2023"""
inset = add_subtext(subtext)

decorate(xlabel="Age", ylabel="Percent")
logo = add_logo()
savefig("nsfg_intent", 5, [inset, logo])
```

```{code-cell} ipython3
summarize_age_group(tables, 24)
```

"Among the young men (15 to 24) born in the 2000s, for example, 86% say they want children, compared to the 76% among their female peers. "

```{code-cell} ipython3
age_groups = [15, 18, 21, 24]
summarize_age_groups(df2, "want_yes", age_groups).dropna()
```

### Intend

`intent`

Looking to the future, do you intend to have another child at some time?

```{code-cell} ipython3
tables = [make_table(resample_by_cycle(df2), "intent_yes") * 100 for i in range(101)]
```

```{code-cell} ipython3
plot_table_with_errors(tables, cohorts, ages)
title = "Young Men Are Less Likely To Intend To Have a Child"
subtitle = "Percent who intend to have a/another child, men grouped by decade of birth"
add_title(title, subtitle)

subtext = """
Responses to "Looking to the future, do you intend to have a/another baby at some time?"
Source: NSFG 1982-2023"""
inset = add_subtext(subtext)

decorate(xlabel="Age", ylabel="Percent")
logo = add_logo()
savefig("nsfg_intent", 6, [inset, logo])
```

```{code-cell} ipython3
age_groups = [15, 18, 21, 24]
summarize_age_groups(df2, "intent_yes", age_groups).dropna()
```

### Additional expected births

```{code-cell} ipython3
tables = [make_table(resample_by_cycle(df2), "addexp") for i in range(101)]
```

```{code-cell} ipython3
plot_table_with_errors(tables, cohorts, ages)
title = "Average number of additional births expected"
subtitle = "Males by decade of birth, NSFG 2002-2023 "
add_title(title, subtitle)

decorate(xlabel="Age")
```

### Number of children

`numbiokid`

"Altogether, how many biological children have you fathered?"

```{code-cell} ipython3
tables = [make_table(resample_by_cycle(df2), "numbiokid") for i in range(101)]
```

```{code-cell} ipython3
summary = summarize_age_group(tables, 33)
summary.round(1)
```

```{code-cell} ipython3
summary = summarize_age_group(tables, 24)
summary.round(1)
```

```{code-cell} ipython3
plot_table_with_errors(tables, cohorts, ages)
title = "Young Men Are On Track To Have Fewer Children, Later"
subtitle = "Average number of children fathered, men grouped by decade of birth"
add_title(title, subtitle)

subtext = """
Responses to "Altogether, how many biological children have you fathered?"
Source: NSFG 1982-2023"""
inset = add_subtext(subtext)

decorate(xlabel="Age")
logo = add_logo()
savefig("nsfg_intent", 4, [inset, logo])
```

```{code-cell} ipython3
# it looks like there is one respondent over 50 who generates a spurious point
subset = df2.query("ager < 50")
tables = [make_table(resample_by_cycle(subset), "child_yes") * 100 for i in range(101)]
```

```{code-cell} ipython3
plot_table_with_errors(tables, cohorts, ages)
title = "Percent who have fathered at least one child"
subtitle = "Males by decade of birth, NSFG 2002-2023 "
add_title(title, subtitle)

decorate(xlabel="Age")
```

```{code-cell} ipython3
tables = [make_table(resample_by_cycle(df2), "strl_yes") * 100 for i in range(101)]
```

```{code-cell} ipython3
plot_table_with_errors(tables, cohorts, ages)
title = "Percent who have had a vasectomy"
subtitle = "Males by decade of birth, NSFG 2002-2023 "
add_title(title, subtitle)

decorate(xlabel="Age")
```

### Sterilizing operation

```{code-cell} ipython3
subset = df.query("cycle >= 10")
subset2 = df2.query("cycle >= 10")
```

```{code-cell} ipython3
def make_simple_table(df, var):
    """Group by age only, not cohort"""
    # subset = df.query("birth_index >= 60")
    table = df.groupby(["age_group"])[var].mean()
    return table
```

```{code-cell} ipython3
make_simple_table(subset, "strl_yes")
```

```{code-cell} ipython3
tables = [
    make_simple_table(resample_by_cycle(subset), "strl_tubs") * 100 for i in range(101)
]
```

```{code-cell} ipython3
tables2 = [
    make_simple_table(resample_by_cycle(subset2), "strl_yes").drop(51) * 100
    for i in range(101)
]
```

```{code-cell} ipython3
def plot_simple_table_with_errors(tables, ages, color="C0", **options):
    frame = pd.DataFrame(columns=ages)
    for i, table in enumerate(tables):
        frame.loc[i] = table

    # using the 84% CI, so non-overlapping corresponds to
    # a difference that's significant at 5% level
    low, median, high = percentile_rows(frame, [8, 50, 92])
    plt.fill_between(ages, low, high, color=color, alpha=0.15)
    plt.plot(ages, median, color=color, **options)
```

```{code-cell} ipython3
plot_simple_table_with_errors(tables, ages, color=aibm_orange, label="Female")
plot_simple_table_with_errors(tables2, ages, color=aibm_green, label="Male")

title = "Percent who have had sterilizing procedure"
subtitle = "NSFG 2017-2023 "
add_title(title, subtitle)

decorate(xlabel="Age")
```

## Differences

+++

### Difference between want and intend for women

```{code-cell} ipython3
tables1 = [make_table(resample_by_cycle(df), "intent_yes") * 100 for i in range(101)]
tables2 = [make_table(resample_by_cycle(df), "want_yes") * 100 for i in range(101)]
diffs = [table2 - table1 for table1, table2 in zip(tables1, tables2)]
```

```{code-cell} ipython3
plot_table_with_errors(diffs, cohorts, ages)
title = "Among Young Women the Difference Between Desire and Intent Is Small"
subtitle = "Percent who want to have a child minus percent who intend to, females by decade of birth"
add_title(title, subtitle)

subtext = """
Responses to "Looking to the future, do you, yourself $want$ to have a/another baby at some time?" and
"Looking to the future, do you intend to have a/another baby at some time?" Source: NSFG 1982-2023."""
inset = add_subtext(subtext)

plt.legend(ncol=2)
decorate(xlabel="Age", ylabel="Percentage points", legend=False)
logo = add_logo()
savefig("nsfg_intent", 7, [inset, logo])
```

### Difference between want and intend for men

```{code-cell} ipython3
tables1 = [make_table(resample_by_cycle(df2), "intent_yes") * 100 for i in range(101)]
tables2 = [make_table(resample_by_cycle(df2), "want_yes") * 100 for i in range(101)]
diffs = [table2 - table1 for table1, table2 in zip(tables1, tables2)]
```

```{code-cell} ipython3
plot_table_with_errors(diffs, cohorts, ages)
title = "Among Young Men the Difference Between Desire and Intent Is Small"
subtitle = "Percent who want to have a child minus percent who intend to, males by decade of birth"
add_title(title, subtitle)

subtext = """
Responses to "Looking to the future, do you, yourself $want$ to have a/another child at some time?" and
"Looking to the future, do you intend to have a/another child at some time?" Source: NSFG 1982-2023."""
inset = add_subtext(subtext)

plt.legend(ncol=2)
decorate(xlabel="Age", ylabel="Percentage points", legend=False)
logo = add_logo()
savefig("nsfg_intent", 8, [inset, logo])
```

### Gender difference in desire for children

```{code-cell} ipython3
tables1 = [make_table(resample_by_cycle(df), "intent_yes") * 100 for i in range(101)]
tables2 = [make_table(resample_by_cycle(df2), "intent_yes") * 100 for i in range(101)]
diffs = [table2 - table1 for table1, table2 in zip(tables1, tables2)]
```

```{code-cell} ipython3
plot_table_with_errors(diffs, cohorts, ages)
title = "More Men Than Women Say They Intend To Have a Child"
subtitle = "Percent of men who intend to have a child minus percent of women, by decade of birth"
add_title(title, subtitle)

subtext = """
Responses to "Looking to the future, do you intend to have a/another baby/child at some time?" 
Source: NSFG 1982-2023."""
inset = add_subtext(subtext)

plt.legend(ncol=2)
decorate(xlabel="Age", ylabel="Percentage points", legend=False)
logo = add_logo()
savefig("nsfg_intent", 9, [inset, logo])
```

### Gender difference in desire for children

```{code-cell} ipython3
tables1 = [make_table(resample_by_cycle(df), "want_yes") * 100 for i in range(101)]
tables2 = [make_table(resample_by_cycle(df2), "want_yes") * 100 for i in range(101)]
diffs = [table2 - table1 for table1, table2 in zip(tables1, tables2)]
```

```{code-cell} ipython3
plot_table_with_errors(diffs, cohorts, ages)
title = "More Men Than Women Say They Want To Have a Child"
subtitle = (
    "Percent of men who want to have a child minus percent of women, by decade of birth"
)
add_title(title, subtitle)

subtext = """
Responses to "Looking to the future, do you, yourself $want$ to have a/another baby/child at some time?"
Source: NSFG 1982-2023."""
inset = add_subtext(subtext)

plt.legend(ncol=2)
decorate(xlabel="Age", ylabel="Percentage points", legend=False)
logo = add_logo()
savefig("nsfg_intent", 10, [inset, logo])
```

## Global fertility

```{code-cell} ipython3
import pandas as pd
import zipfile

# Define the zip file name
zip_filename = raw("period-total-fertility-rate.filtered.zip")

# Open the zip file and extract the CSV
with zipfile.ZipFile(zip_filename, "r") as z:
    # Get the list of files inside the zip
    file_list = z.namelist()

    # Assuming there's only one CSV file, extract its name
    csv_filename = [f for f in file_list if f.endswith(".csv")][0]

    # Read the CSV file into a DataFrame
    with z.open(csv_filename) as f:
        fertility_df = pd.read_csv(f)

fertility_df.columns
```

```{code-cell} ipython3
# Pivoting the DataFrame
df_pivot = fertility_df.pivot(
    index="Year", columns="Entity", values="Period total fertility rate - Total"
)[["United States", "Canada", "South Korea"]]
df_pivot.head()
```

```{code-cell} ipython3
colors = [aibm_blue, crimson, aibm_green]
plt.rcParams["axes.prop_cycle"] = plt.cycler(color=colors)

df_pivot.plot(alpha=0.8)

title = "Fertility rates have declined in the U.S. and other developed countries"
subtitle = "Total fertility rate: births per woman"
add_title(title, subtitle)

subtext = """
Period fertility rates from Human Fertility Database (2024) via Our World in Data"""
inset = add_subtext(subtext)

decorate(xlabel="Total fertility rate", ylabel="")
logo = add_logo()
savefig("nsfg_intent", 11, [inset, logo])
```

```{code-cell} ipython3
df_pivot.loc[[2007, 2021], "United States"]
```

```{code-cell} ipython3

```

### Checking for data problems

```{code-cell} ipython3
plt.rcParams["axes.prop_cycle"] = plt.rcParamsDefault["axes.prop_cycle"]
```

```{code-cell} ipython3
table = df.groupby(["cycle", "birth_index"])["parity"].mean().unstack()
table.plot()
None
```

```{code-cell} ipython3
table = df.groupby(["cycle", "birth_index"])["child_yes"].mean().unstack()
table.plot()
None
```

```{code-cell} ipython3
table = df.groupby(["cycle", "birth_index"])["want_yes"].mean().unstack()
table.plot()
None
```

```{code-cell} ipython3
table = df.groupby(["cycle", "birth_index"])["intent_yes"].mean().unstack()
table.plot()
```

```{code-cell} ipython3
subset = df.query("parity == 0")
table = subset.groupby(["cycle", "birth_index"])["intent_yes"].mean().unstack()
table.plot()
```

### Males

```{code-cell} ipython3
table = df2.groupby(["cycle", "birth_index"])["numbiokid"].mean().unstack()
table.plot()
None
```

```{code-cell} ipython3
table = df2.groupby(["cycle", "birth_index"])["child_yes"].mean().unstack()
table.plot()
None
```

```{code-cell} ipython3
table = df2.groupby(["cycle", "birth_index"])["want_yes"].mean().unstack()
table.plot()
None
```

```{code-cell} ipython3
table = df2.groupby(["cycle", "birth_index"])["intent_yes"].mean().unstack()
table.plot()
```

```{code-cell} ipython3
subset = df2.query("numbiokid == 0")
table = subset.groupby(["cycle", "birth_index"])["intent_yes"].mean().unstack()
table.plot()
```

```{code-cell} ipython3

```
