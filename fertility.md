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
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from utils import decorate, value_counts
from utils import add_title, add_logo, add_subtext
```

```{code-cell} ipython3
%load_ext autoreload
%autoreload 2
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

# use rcparams to remove the tick marks -- generate code only

plt.rcParams["font.family"] = "PT Sans"  # Use PT Sans as the default font
```

## CPS Fertility Data

```{code-cell} ipython3
# Read the Census data

from os.path import basename, exists


def download(url):
    filename = basename(url)
    if not exists(filename):
        from urllib.request import urlretrieve

        local, _ = urlretrieve(url, filename)
        print("Downloaded " + local)


download(
    "https://www2.census.gov/programs-surveys/demo/tables/fertility/time-series/his-cps/h2.xlsx"
)
```

```{code-cell} ipython3
rename_dict = {
    "Unnamed: 0": "Year",
    "Unnamed: 1": "Total",
    "Unnamed: 12": "Rate per 1000",
}

df = pd.read_excel("h2.xlsx", skiprows=6)
del df["Unnamed: 7"]
df.rename(columns=rename_dict, inplace=True)
df.head()
```

```{code-cell} ipython3
# Select women ages 40-44

rows = df.iloc[9:39].drop(36)
```

```{code-cell} ipython3
# Convert the index to integers

index = rows["Year"].astype(float) * 10000
rows.index = index.round().astype(int)
```

```{code-cell} ipython3
# (Almost) Completed Cohort Fertility Rate
# Usually age 50, but with this dataset, 40-45 is what we have

cfr = rows["Rate per 1000"] / 1000
```

```{code-cell} ipython3
cfr.plot(label="CFR")
decorate(ylabel="Completed Cohort Fertility Rate (CFR)")
```

```{code-cell} ipython3

```

```{code-cell} ipython3

```

```{code-cell} ipython3

```

```{code-cell} ipython3

```

```{code-cell} ipython3

```

## Female Data

```{code-cell} ipython3
df = pd.read_hdf("FemMarriageData.hdf", "FemMarriageData")
df.shape
```

```{code-cell} ipython3
trimmed = df["parity"] > 12
df.loc[trimmed, "parity"] = np.nan
```

```{code-cell} ipython3
from utils import round_into_bins

df["age_group"] = round_into_bins(df["ager"], 3, low=14) + 1
```

```{code-cell} ipython3
pd.crosstab(df["age_group"], df["cycle"])
```

```{code-cell} ipython3
df["birth_group"] = round_into_bins(df["year"], 3, low=0) + 1
```

```{code-cell} ipython3
# Derived indicator columns. These are defined in intent.ipynb but were
# missing here, which broke every cell below that uses them.
df["intent_yes"] = np.where(df["intent"].isna(), np.nan, df["intent"] == 1)
df["want_yes"] = np.where(df["rwant"].isna(), np.nan, df["rwant"] == 1)
df["strl_yes"] = (df["tubs"] == 1) | (df["hyst"] == 1) | (df["strloper"] == 4)
```

```{code-cell} ipython3
pd.crosstab(df["birth_group"], df["cycle"])
```

### Resampling

```{code-cell} ipython3
from utils import resample_by_cycle

sample = resample_by_cycle(df)
```

```{code-cell} ipython3
table = sample.groupby(["age_group", "birth_group"])["parity"].agg(["sum", "count"])
```

```{code-cell} ipython3
def make_table(df, var, drop_cols=[]):
    table = df.groupby(["age_group", "birth_group"])[var].mean().unstack()
    if drop_cols:
        table.drop(columns=drop_cols, errors="ignore", inplace=True)
    return table
```

```{code-cell} ipython3
def plot_table(table):
    """ """
    for col in table.columns:
        table[col].plot(label="", alpha=0.3)
```

```{code-cell} ipython3
table = make_table(sample, "parity")
cohorts = table.columns
ages = table.index
```

```{code-cell} ipython3
plot_table(table)
title = "Title"
subtitle = "Subtitle"
add_title(title, subtitle)

subtext = """
Explanatory text"""
add_subtext(subtext)

decorate(xlabel="Age", ylabel="Number of live births")
add_logo()
None
```

```{code-cell} ipython3
from utils import percentile_rows


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
from marriage import underride


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
def savefig(fig_number, extra_artist):
    filename = f"nsfg_fertility{fig_number:02d}"
    plt.savefig(
        filename, dpi=150, bbox_inches="tight", bbox_extra_artists=[extra_artist]
    )
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
    "Percent who intend to have a/another child, females grouped by decade of birth"
)
add_title(title, subtitle)

subtext = """
Responses to "Looking to the future, do you intend to have a/another baby at some time?"
Source: NSFG 1982-2023, analysis by AIBM"""
add_subtext(subtext)

decorate(xlabel="Age", ylabel="Percent")
inset = add_logo()
savefig(3, inset)
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
subtitle = "Percent who want to have a/another baby, females grouped by decade of birth"
add_title(title, subtitle)

subtext = """
Responses to "Looking to the future, do you, yourself, $want$ to have a/another baby at some time?"
Source: NSFG 1982-2023, analysis by AIBM"""
add_subtext(subtext)

decorate(xlabel="Age", ylabel="Percent")
inset = add_logo()
savefig(2, inset)
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
subtitle = "Average number of live births, females grouped decade of birth"
add_title(title, subtitle)

subtext = """
Calculated parity. Source: NSFG 1982-2023, analysis by AIBM"""
add_subtext(subtext)

decorate(xlabel="Age")
inset = add_logo()
savefig(1, inset)
```

### Percent who have born at least one child

`child_yes` is based on `parity`, which is a recode, so there's not a single question

```{code-cell} ipython3
tables = [make_table(resample_by_cycle(df), "child_yes") * 100 for i in range(101)]
```

```{code-cell} ipython3
plot_table_with_errors(tables, cohorts, ages)
title = "Descriptive headline"
subtitle = (
    "Percent who have borne at least one child, females grouped by decade of birth"
)
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
df2 = pd.read_hdf("MaleMarriageData.hdf", "MaleMarriageData")
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
from utils import round_into_bins

df2["age_group"] = round_into_bins(df2["ager"], 3, low=14) + 1
```

```{code-cell} ipython3
# df2 gets age_group above but never birth_group, which make_table needs.
df2["birth_group"] = round_into_bins(df2["year"], 3, low=0) + 1
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
from utils import resample_by_cycle

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
subtitle = "Percent who want to have a/another child, males grouped by decade of birth"
add_title(title, subtitle)

subtext = """
Responses to "Looking to the future, do you, yourself, $want$ to have a/another child at some time?"
Source: NSFG 1982-2023, analysis by AIBM"""
add_subtext(subtext)

decorate(xlabel="Age", ylabel="Percent")
inset = add_logo()
savefig(5, inset)
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
subtitle = (
    "Percent who intend to have a/another child, males grouped by decade of birth"
)
add_title(title, subtitle)

subtext = """
Responses to "Looking to the future, do you intend to have a/another baby at some time?"
Source: NSFG 1982-2023, analysis by AIBM"""
add_subtext(subtext)

decorate(xlabel="Age", ylabel="Percent")
inset = add_logo()
savefig(6, inset)
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
subtitle = "Average number of children fathered, males grouped by decade of birth"
add_title(title, subtitle)

subtext = """
Responses to "Altogether, how many biological children have you fathered?"
Source: NSFG 1982-2023, analysis by AIBM"""
add_subtext(subtext)

decorate(xlabel="Age")
inset = add_logo()
savefig(4, inset)
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
add_subtext(subtext)

plt.legend(ncol=2)
decorate(xlabel="Age", ylabel="Percentage points", legend=False)
inset = add_logo()
savefig(7, inset)
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
add_subtext(subtext)

plt.legend(ncol=2)
decorate(xlabel="Age", ylabel="Percentage points", legend=False)
inset = add_logo()
savefig(8, inset)
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
add_subtext(subtext)

plt.legend(ncol=2)
decorate(xlabel="Age", ylabel="Percentage points", legend=False)
inset = add_logo()
savefig(9, inset)
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
add_subtext(subtext)

plt.legend(ncol=2)
decorate(xlabel="Age", ylabel="Percentage points", legend=False)
inset = add_logo()
savefig(10, inset)
```

## Global fertility

```{code-cell} ipython3
import pandas as pd
import zipfile

# Define the zip file name
zip_filename = "period-total-fertility-rate.filtered.zip"

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
add_subtext(subtext)

decorate(xlabel="Total fertility rate", ylabel="")
inset = add_logo()
savefig(11, inset)
```

```{code-cell} ipython3
df_pivot.loc[[2007, 2021], "United States"]
```

```{code-cell} ipython3
stop
```

## Modeling attempts

```{code-cell} ipython3
subset = df.query("birth_index >= 60").copy()
subset["sqrt_parity"] = np.sqrt(subset["parity"])
subset["age2"] = (subset["ager"] - 30) ** 2
subset["age3"] = (subset["ager"] - 30) ** 3
```

```{code-cell} ipython3
from scipy.special import logit

middle = subset.query("age_group >= 21 and age_group <= 33")
intent_series = middle.groupby("parity")["intent_yes"].mean()
x = np.sqrt(intent_series.index)
y = logit(intent_series)
plt.plot(x, y)
```

```{code-cell} ipython3
intention = subset.query("age_group <= 21").groupby("birth_index")["addexp"].mean()
intention
```

```{code-cell} ipython3
subset["intention"] = intention[subset["birth_index"]].values
subset["intention"].mean()
```

```{code-cell} ipython3

```

```{code-cell} ipython3
import statsmodels.formula.api as smf

formula = "intent_yes ~ ager + sqrt_parity + C(birth_index)"
results = smf.logit(formula=formula, data=subset).fit()

results.summary()
```

```{code-cell} ipython3
subset["parity"].mean(), subset["parity"].var()
```

```{code-cell} ipython3
formula = "sqrt_parity ~ ager + age2 + age3 + C(birth_index)"
results = smf.ols(formula=formula, data=subset).fit()

results.summary()
```

```{code-cell} ipython3
pred_df = pd.DataFrame(dtype=float)
pred_df["ager"] = np.arange(15, 51, 3)
pred_df["age2"] = (pred_df["ager"] - 30) ** 2
pred_df["age3"] = (pred_df["ager"] - 30) ** 3
pred_df["birth_index"] = 100

pred = results.predict(pred_df) ** 2
pred = pd.Series(pred.values, pred_df["ager"])
```

```{code-cell} ipython3
table = make_table(subset, "parity")
table["2000s"].plot()
pred.plot()
```

```{code-cell} ipython3

```
