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

# Age at first live birth

```{code-cell} ipython3
%load_ext nb_black
```

```{code-cell} ipython3
import pandas as pd

from nsfg.paths import raw, interim, FIGURES
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from lifelines import KaplanMeierFitter

from nsfg.utils import decorate
from nsfg.utils import value_counts
from nsfg.utils import resample_by_cycle
from nsfg.utils import round_into_bins
from nsfg.utils import remove_spines
from nsfg.utils import set_palette

from empiricaldist import Pmf, Cdf

random_seed = 1
```

```{code-cell} ipython3
# Make the figures smaller to save some screen real estate.
plt.rcParams["figure.dpi"] = 75
plt.rcParams["figure.figsize"] = [5, 3.7]
```

```{code-cell} ipython3

```

## Run the analysis with lifelines

Load the data cleaned in `clean_nsfg.ipynb` and run the analysis with `lifelines`

```{code-cell} ipython3
%time unweighted = pd.read_parquet(interim("FemMarriageData.parquet"))
unweighted.shape
```

```{code-cell} ipython3
trimmed = unweighted["agebaby1"] < 14
unweighted.loc[trimmed, "agebaby1"] = 14
```

```{code-cell} ipython3
unweighted["parous"] = unweighted["parity"] > 0
value_counts(unweighted["parous"])
```

```{code-cell} ipython3
for name, group in unweighted.groupby("birth_index"):
    missing = group["parous"] & group["agebaby1"].isna()
    print(name, missing.sum())
```

```{code-cell} ipython3
sample = resample_by_cycle(unweighted)
```

```{code-cell} ipython3
value_counts(sample["birth_index"])
```

```{code-cell} ipython3
def drop_missing(df):
    # find people who are parous but have no agebaby1
    missing = df["parous"] & df["agebaby1"].isna()
    return df[~missing]
```

```{code-cell} ipython3
def fill_missing(df):
    for cohort in range(30, 110, 10):
        # find people in this cohort who are parous but have no agebaby1
        missing = (df["birth_index"] == cohort) & df["parous"] & df["agebaby1"].isna()
        n = missing.sum()
        if n == 0:
            continue

        # find people in this cohort who have borne at least one child
        donors = (df["birth_index"] == cohort) & df["parous"] & df["agebaby1"].notna()

        # select their ages at first birth
        agebaby1 = df.loc[donors, "agebaby1"]
        low, high = np.percentile(agebaby1, [1, 99])
        index = agebaby1.between(low, high)

        # fill missing data with a random sample
        sample = np.random.choice(agebaby1[index], size=n, replace=True)
        df.loc[missing, "agebaby1"] = sample
```

```{code-cell} ipython3
# fill_missing(sample)
sample = drop_missing(sample)

missing = sample["parous"] & sample["agebaby1"].isna()
missing.sum()
```

```{code-cell} ipython3
cdf = Cdf.from_seq(sample["ager"], name="age")
cdf.plot()
decorate()
```

```{code-cell} ipython3
cdf = Cdf.from_seq(sample["agebaby1"], name="agebaby1")
cdf.plot()
decorate()
```

```{code-cell} ipython3
from nsfg.utils import make_kmf_map
```

```{code-cell} ipython3
parous = sample["parous"]
sample["observed"] = parous
sample.loc[parous, "duration"] = sample["agebaby1"]
sample.loc[~parous, "duration"] = sample["ager"]
```

```{code-cell} ipython3
grouped = sample.groupby("birth_index")
nsfg_map = make_kmf_map(grouped)
```

```{code-cell} ipython3
from nsfg.utils import add_text
```

```{code-cell} ipython3
def make_title(title, subtitle, pad=30):
    plt.title(title, loc="left", pad=pad)
    add_text(0, 1.085, subtitle)
    add_text(0, 1.015, "Analysis: allendowney.com/blog")
```

```{code-cell} ipython3
def decorate_plot(**options):
    decorate(
        xlabel="Age",
        ylabel="Percent",
        xlim=[13, 55],
        **options,
    )
    title = "Percent who have borne a child, by decade of birth"
    subtitle = "Data: NSFG 1982-2023 "
    make_title(title, subtitle)
```

```{code-cell} ipython3
def plot_kmf_map(ax, kmf_map, cohorts, add_label=True, **options):
    """ """
    palette = set_palette("hls", len(cohorts))
    for cohort in cohorts:
        series = kmf_map[cohort]
        label = f"{cohort+1900}s" if add_label else ""
        series.plot(ax=ax, label=label, **options)
        label = ""
```

```{code-cell} ipython3
cohorts = range(40, 110, 10)

fig, ax = plt.subplots()
plot_kmf_map(ax, nsfg_map, cohorts)
decorate_plot()
remove_spines()
plt.tight_layout()
```

```{code-cell} ipython3
kmf_series = {}

for i in range(21):
    sample = resample_by_cycle(unweighted)
    # fill_missing(sample)
    sample = drop_missing(sample)
    parous = sample["parous"]
    sample["observed"] = parous
    sample.loc[parous, "duration"] = sample["agebaby1"]
    sample.loc[~parous, "duration"] = sample["ager"]
    grouped = sample.groupby("birth_index")
    kmf_map = make_kmf_map(grouped)
    for cohort in kmf_map:
        kmf_series.setdefault(cohort, []).append(kmf_map[cohort])
```

```{code-cell} ipython3

```

```{code-cell} ipython3
palette = sns.color_palette("hls", len(cohorts))
options = dict(alpha=0.1)
xnudge = {40: -20, 50: -20}
ynudge = {40: -7, 50: -15, 60: 2, 70: -2}

for i, cohort in enumerate(cohorts):
    label = f"{cohort+1900}s"
    series_list = kmf_series[cohort]
    coords = []
    for series in series_list:
        coords.append((series.index[-1], series.iloc[-1]))
        series.plot(label=label, color=palette[i], **options)
        label = ""

    xs, ys = np.transpose(coords)
    x = xs.max() + xnudge.get(cohort, 0.2)
    y = ys.mean() + ynudge.get(cohort, 0)
    text = f"{1900+cohort}s"
    # plt.text(x, y, text, va="center")


decorate_plot()
legend = plt.gca().legend()
for line in legend.get_lines():
    line.set_alpha(1)  # Set transparency
    line.set_linewidth(2)  # Set line width


remove_spines()
plt.tight_layout()
plt.savefig(FIGURES / "borne23.jpg", dpi=300)
```

```{code-cell} ipython3

```

```{code-cell} ipython3

```
