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

## Validate NSFG data

```{code-cell} ipython3
%load_ext autoreload
%autoreload 2
```

```{code-cell} ipython3
import pandas as pd

from nsfg.paths import raw, interim
import numpy as np
import seaborn as sns

import math

import matplotlib.pyplot as plt

from empiricaldist import Cdf

from nsfg import marriage

from nsfg.marriage import value_counts, decorate
```

```{code-cell} ipython3
# Make the figures smaller to save some screen real estate.
# The figures generated for the book have DPI 400, so scaling
# them by a factor of 4 restores them to the size in the notebooks.
plt.rcParams["figure.dpi"] = 75
plt.rcParams["figure.figsize"] = [6, 3.5]
```

## Cycle 3

Note: Early cycles of the NSFG oversampled married women, so it's pretty important to correct for stratified sampling!

```{code-cell} ipython3
resp3 = marriage.read_fem_resp_1982()
marriage.validate_1982(resp3)
resp3.shape
```

```{code-cell} ipython3
value_counts(resp3["bdegree"])
```

```{code-cell} ipython3
value_counts(resp3["fmarital"])
```

```{code-cell} ipython3
value_counts(resp3["rwant"])
```

```{code-cell} ipython3
resp3["want_yes"] = resp3["rwant"] == 1
resp3.groupby("ager")["want_yes"].mean().plot()
```

```{code-cell} ipython3
# value_counts(resp3['nchildhh'])
```

```{code-cell} ipython3
value_counts(resp3["intent"])
```

```{code-cell} ipython3
value_counts(resp3["addexp"])
```

```{code-cell} ipython3
value_counts(resp3["rmarital"])
```

```{code-cell} ipython3
resp3["marend01"].describe()
```

```{code-cell} ipython3
value_counts(resp3["fmarno"])
```

```{code-cell} ipython3
resp3.fmarno.value_counts().sort_index()
```

```{code-cell} ipython3
resp3.widowed.value_counts()
```

```{code-cell} ipython3
sum(resp3.cmdivorcx.isnull()), 6841 + 29 + 5 + 56
```

```{code-cell} ipython3
sum((resp3.cmdivorcx >= 400) & (resp3.cmdivorcx <= 948)), 583 + 128
```

```{code-cell} ipython3
sum((resp3.cmdivorcx >= 949) & (resp3.cmdivorcx <= 1000)), 311 + 16
```

```{code-cell} ipython3
sum(resp3.cmstphsbx.isnull()), 7571 + 1 + 6 + 31
```

```{code-cell} ipython3
sum((resp3.cmstphsbx >= 400) & (resp3.cmstphsbx <= 948)), 125 + 33
```

```{code-cell} ipython3
sum((resp3.cmstphsbx >= 949) & (resp3.cmstphsbx <= 1000)), 197 + 5
```

```{code-cell} ipython3
sum(resp3.divorced)
```

```{code-cell} ipython3
sum(~resp3.cmstphsbx.isnull())
```

```{code-cell} ipython3
sum(~resp3.cmdivorcx.isnull())
```

## Cycle 4

Validating the 1988 data:

```{code-cell} ipython3
resp4 = marriage.read_fem_resp_1988()
marriage.validate_1988(resp4)
resp4.shape
```

```{code-cell} ipython3
value_counts(resp4["bdegree"])
```

```{code-cell} ipython3
value_counts(resp4["fmarital"])
```

```{code-cell} ipython3
value_counts(resp4["rwant"])
```

```{code-cell} ipython3
resp4["want_yes"] = resp4["rwant"] == 1
resp4.groupby("ager")["want_yes"].mean().plot()
```

```{code-cell} ipython3
# value_counts(resp4['nchildhh'])
```

```{code-cell} ipython3
value_counts(resp4["intent"])
```

```{code-cell} ipython3
value_counts(resp4["addexp"])
```

```{code-cell} ipython3
value_counts(resp4["rmarital"])
```

```{code-cell} ipython3
value_counts(resp4["marend01"])
```

```{code-cell} ipython3
resp4.fmarno.describe()
```

```{code-cell} ipython3
resp4.fmarno.value_counts().sort_index()
```

```{code-cell} ipython3
resp4.evrmarry.value_counts().sort_index()
```

```{code-cell} ipython3
resp4.separated.value_counts().sort_index()
```

```{code-cell} ipython3
resp4.head()
```

```{code-cell} ipython3
sum(resp4.cmdivorcx.isnull()), 6897 + 77
```

```{code-cell} ipython3
sum((resp4.cmdivorcx >= 685) & (resp4.cmdivorcx <= 1008)), 903 + 152
```

```{code-cell} ipython3
sum((resp4.cmdivorcx >= 1009) & (resp4.cmdivorcx <= 1064)), 399 + 22
```

```{code-cell} ipython3
sum(resp4.cmstphsbx.isnull()), 8113 + 29
```

```{code-cell} ipython3
sum((resp4.cmstphsbx >= 685) & (resp4.cmstphsbx <= 1008)), 75 + 31
```

```{code-cell} ipython3
sum((resp4.cmstphsbx >= 1009) & (resp4.cmstphsbx <= 1064)), 193 + 9
```

```{code-cell} ipython3
sum(resp4.divorced)
```

```{code-cell} ipython3
sum(~resp4.cmstphsbx.isnull())
```

```{code-cell} ipython3
sum(~resp4.cmdivorcx.isnull())
```

## Cycle 5

Validating the 1995 data:

```{code-cell} ipython3
resp5 = marriage.read_fem_resp_1995()
marriage.validate_1995(resp5)
resp5.shape
```

```{code-cell} ipython3
value_counts(resp5['bdegree'])
```

```{raw-cell}
value_counts(resp5['fmarital'])
```

```{code-cell} ipython3
# value_counts(resp5['rwant'])
```

```{code-cell} ipython3
# value_counts(resp5['nchildhh'])
```

```{code-cell} ipython3
value_counts(resp5["intent"])
```

```{code-cell} ipython3
value_counts(resp5["addexp"])
```

```{code-cell} ipython3
value_counts(resp5["rmarital"])
```

```{code-cell} ipython3
value_counts(resp5["fmarno"])
```

```{code-cell} ipython3
value_counts(resp5["marend01"])
```

```{code-cell} ipython3
resp5.head()
```

```{code-cell} ipython3
sum(resp5.cmdivorcx.isnull()), 9601 + 1 + 1 + 22
```

```{code-cell} ipython3
sum((resp5.cmdivorcx >= 780) & (resp5.cmdivorcx <= 1092)), 1116
```

```{code-cell} ipython3
sum((resp5.cmdivorcx >= 1093) & (resp5.cmdivorcx <= 1150)), 106
```

```{code-cell} ipython3
sum(resp5.cmstphsbx.isnull()), 9601 + 1 + 15
```

```{code-cell} ipython3
sum((resp5.cmstphsbx >= 780) & (resp5.cmstphsbx <= 1092)), 1167
```

```{code-cell} ipython3
sum((resp5.cmstphsbx >= 1093) & (resp5.cmstphsbx <= 1150)), 63
```

```{code-cell} ipython3
resp5.marend01.value_counts().sort_index()
```

```{code-cell} ipython3
sum(resp5.divorced)
```

```{code-cell} ipython3
sum(~resp5.cmstphsbx.isnull())
```

```{code-cell} ipython3
sum(~resp5.cmdivorcx.isnull())
```

```{code-cell} ipython3
sum((resp5.marend01 == 2) & (resp5.cmdivorcx.isnull()))
```

```{code-cell} ipython3
sum((resp5.marend01 == 3) & (resp5.cmdivorcx.isnull()))
```

```{code-cell} ipython3
sum((~resp5.divorced) & (~resp5.cmstphsbx.isnull()))
```

```{code-cell} ipython3
resp5.marstat.value_counts().sort_index()
```

```{code-cell} ipython3
sum((resp5.marstat == 4) & (~resp5.divorced))  # separated and not divorced
```

```{code-cell} ipython3
sum((resp5.marstat == 4) & (~resp5.divorced) & (~resp5.cmstphsbx.isnull()))
```

## Cycle 6

Validating the 2002 data:

```{code-cell} ipython3
resp6 = marriage.read_fem_resp_2002()
marriage.validate_2002(resp6)
resp6.shape
```

```{code-cell} ipython3
value_counts(resp6["bdegree"])
```

```{code-cell} ipython3
value_counts(resp6["fmarital"])
```

```{code-cell} ipython3
value_counts(resp6["hieduc"])
```

```{code-cell} ipython3
# value_counts(resp6['nchildhh'])
```

```{code-cell} ipython3
value_counts(resp6["intent"])
```

```{code-cell} ipython3
value_counts(resp6["addexp"])
```

```{code-cell} ipython3
value_counts(resp6["rmarital"])
```

```{code-cell} ipython3
resp6.head()
```

```{code-cell} ipython3
sum(resp6.cmdivorcx.isnull()), 6639 + 2 + 20
```

```{code-cell} ipython3
sum((resp6.cmdivorcx >= 301) & (resp6.cmdivorcx <= 1164)), 607
```

```{code-cell} ipython3
sum((resp6.cmdivorcx >= 1165) & (resp6.cmdivorcx <= 1239)), 375
```

```{code-cell} ipython3
resp6.marend01.value_counts().sort_index()
```

```{code-cell} ipython3
sum(resp6.divorced), sum(resp6.loc[resp6.divorced, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp6.separated), sum(resp6.loc[resp6.separated, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp6.widowed), sum(resp6.loc[resp6.widowed, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp6.stillma), sum(resp6.loc[resp6.stillma, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp6.evrmarry), 1232 + 260 + 58 + 2576
```

## Cycle 7

Validating the 2010 data:

```{code-cell} ipython3
resp7 = marriage.read_fem_resp_2010()
marriage.validate_2010(resp7)
resp7.shape
```

```{code-cell} ipython3
value_counts(resp7["fmarital"])
```

```{code-cell} ipython3
value_counts(resp7["bdegree"])
```

```{code-cell} ipython3
value_counts(resp7["hieduc"])
```

```{code-cell} ipython3
value_counts(resp7["nchildhh"])
```

```{code-cell} ipython3
value_counts(resp7["intent"])
```

```{code-cell} ipython3
value_counts(resp7["addexp"])
```

```{code-cell} ipython3
sum(resp7.cmdivorcx.isnull()), 10705 + 1 + 19
```

```{code-cell} ipython3
sum((resp7.cmdivorcx >= 522) & (resp7.cmdivorcx <= 1278)), 1286
```

```{code-cell} ipython3
sum((resp7.cmdivorcx >= 1279) & (resp7.cmdivorcx <= 1290)), 106
```

```{code-cell} ipython3
sum((resp7.cmdivorcx >= 1291) & (resp7.cmdivorcx <= 1308)), 112
```

```{code-cell} ipython3
sum((resp7.cmdivorcx >= 1309) & (resp7.cmdivorcx <= 1326)), 50
```

```{code-cell} ipython3
resp7.marend01.value_counts().sort_index()
```

```{code-cell} ipython3
sum(resp7.divorced), sum(resp7.loc[resp7.divorced, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp7.separated), sum(resp7.loc[resp7.separated, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp7.widowed), sum(resp7.loc[resp7.widowed, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp7.stillma), sum(resp7.loc[resp7.stillma, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp7.evrmarry), 1574 + 405 + 68 + 3487
```

## Cycle 8

Validating the 2013 data

```{code-cell} ipython3
resp8 = marriage.read_fem_resp_2013()
marriage.validate_2013(resp8)
resp8.shape
```

```{code-cell} ipython3
value_counts(resp8["bdegree"])
```

```{code-cell} ipython3
value_counts(resp8["fmarital"])
```

```{code-cell} ipython3
value_counts(resp8["hieduc"])
```

```{code-cell} ipython3
value_counts(resp8["nchildhh"])
```

```{code-cell} ipython3
value_counts(resp8["intent"])
```

```{code-cell} ipython3
value_counts(resp8["addexp"])
```

```{code-cell} ipython3
sum(resp8.cmdivorcx.isnull()), 4851 + 2 + 24
```

```{code-cell} ipython3
sum((resp8.cmdivorcx >= 380) & (resp8.cmdivorcx <= 1340)), 658
```

```{code-cell} ipython3
sum((resp8.cmdivorcx >= 1341) & (resp8.cmdivorcx <= 1352)), 48
```

```{code-cell} ipython3
sum((resp8.cmdivorcx >= 1353) & (resp8.cmdivorcx <= 1365)), 18
```

```{code-cell} ipython3
resp8.marend01.value_counts().sort_index()
```

```{code-cell} ipython3
sum(resp8.divorced), sum(resp8.loc[resp8.divorced, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp8.separated), sum(resp8.loc[resp8.separated, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp8.widowed), sum(resp8.loc[resp8.widowed, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp8.stillma), sum(resp8.loc[resp8.stillma, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp8.evrmarry), 755 + 214 + 26 + 1457
```

## Cycle 9

Validating the 2015 data

```{code-cell} ipython3
from nsfg.marriage import read_fem_resp_2015

resp9 = read_fem_resp_2015()
marriage.validate_2015(resp9)
resp9.shape
```

```{code-cell} ipython3
value_counts(resp9["bdegree"])
```

```{code-cell} ipython3
value_counts(resp9["fmarital"])
```

```{code-cell} ipython3
value_counts(resp9["hieduc"])
```

```{code-cell} ipython3
value_counts(resp9["nchildhh"])
```

```{code-cell} ipython3
value_counts(resp9["intent"])
```

```{code-cell} ipython3
value_counts(resp9["addexp"])
```

```{code-cell} ipython3
sum(resp9.cmdivorcx.isnull()), 4946 + 3 + 18
```

```{code-cell} ipython3
sum((resp9.cmdivorcx >= 378) & (resp9.cmdivorcx <= 1340)), 563
```

```{code-cell} ipython3
sum((resp9.cmdivorcx >= 1341) & (resp9.cmdivorcx <= 1352)), 56
```

```{code-cell} ipython3
sum((resp9.cmdivorcx >= 1353) & (resp9.cmdivorcx <= 1364)), 48
```

```{code-cell} ipython3
sum((resp9.cmdivorcx >= 1365) & (resp9.cmdivorcx <= 1376)), 46
```

```{code-cell} ipython3
sum((resp9.cmdivorcx >= 1377) & (resp9.cmdivorcx <= 1389)), 19
```

```{code-cell} ipython3
resp9.marend01.value_counts().sort_index()
```

```{code-cell} ipython3
sum(resp9.divorced), sum(resp9.loc[resp9.divorced, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp9.separated), sum(resp9.loc[resp9.separated, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp9.widowed), sum(resp9.loc[resp9.widowed, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp9.stillma), sum(resp9.loc[resp9.stillma, "mar1diss"].isnull())
```

```{code-cell} ipython3
sum(resp9.evrmarry), 756 + 169 + 28 + 1448
```

## Cycle 10

Validating 2017 data

```{code-cell} ipython3
resp10 = marriage.read_fem_resp_2017()
marriage.validate_2017(resp10)
```

```{code-cell} ipython3
value_counts(resp10["bdegree"])
```

```{code-cell} ipython3
value_counts(resp10["fmarital"])
```

```{code-cell} ipython3
value_counts(resp10["hieduc"])
```

```{code-cell} ipython3
value_counts(resp10["nchildhh"])
```

```{code-cell} ipython3
value_counts(resp10["intent"])
```

```{code-cell} ipython3
value_counts(resp10["addexp"])
```

```{code-cell} ipython3
value_counts(resp10["marend01"])
```

```{code-cell} ipython3
resp10["cmdivorcx"].describe()
```

```{code-cell} ipython3
resp10.shape
```

```{code-cell} ipython3
sum(resp10.evrmarry)
```

```{code-cell} ipython3
resp10.agemarry.value_counts().max()
```

```{code-cell} ipython3
resp10.head()
```

```{code-cell} ipython3
Cdf.from_seq(resp10.ager).plot()
decorate(xlabel="Age", ylabel="CDF")
```

```{code-cell} ipython3
Cdf.from_seq(resp10.agemarry).plot()
decorate(xlabel="Age at first marriage", ylabel="CDF")
```

```{code-cell} ipython3
Cdf.from_seq(resp10.finalwgt).plot()
decorate(xlabel="Sampling weight", ylabel="CDF")
```

## Cycle 11

Validating 2019 data

```{code-cell} ipython3
from nsfg.marriage import read_fem_resp_2019

resp11 = read_fem_resp_2019()
marriage.validate_2019(resp11)
resp11.shape
```

```{code-cell} ipython3
value_counts(resp11["bdegree"])
```

```{code-cell} ipython3
value_counts(resp11["fmarital"])
```

```{code-cell} ipython3
value_counts(resp11["hieduc"])
```

```{code-cell} ipython3
value_counts(resp11["nchildhh"])
```

```{code-cell} ipython3
value_counts(resp11["intent"])
```

```{code-cell} ipython3
value_counts(resp11["addexp"])
```

```{code-cell} ipython3
value_counts(resp11["marend01"])
```

```{code-cell} ipython3
resp11["cmdivorcx"].describe()
```

```{code-cell} ipython3
sum(resp11.evrmarry)
```

```{code-cell} ipython3
resp11.agemarry.value_counts().max()
```

```{code-cell} ipython3
resp11.head()
```

```{code-cell} ipython3
Cdf.from_seq(resp11.ager).plot()
decorate(xlabel="Age", ylabel="CDF")
```

```{code-cell} ipython3
Cdf.from_seq(resp11.agemarry).plot()
decorate(xlabel="Age at first marriage", ylabel="CDF")
```

```{code-cell} ipython3
Cdf.from_seq(resp11.finalwgt).plot()
decorate(xlabel="Sampling weight", ylabel="CDF")
```

```{code-cell} ipython3
value_counts(resp11["intent"])
```

```{code-cell} ipython3
value_counts(resp11["addexp"])
```

## Cycle 12

Validating 2023 data

```{code-cell} ipython3
from nsfg.marriage import read_fem_resp_2023

resp12 = read_fem_resp_2023()
resp12.shape
```

```{code-cell} ipython3
value_counts(resp12["bdegree"])
```

```{code-cell} ipython3
value_counts(resp12["fmarital"])
```

```{code-cell} ipython3
value_counts(resp12["hieduc"])
```

```{code-cell} ipython3
for col in resp12.columns:
    if "baby" in col:
        print(col)
```

```{code-cell} ipython3
value_counts(resp12["parity"])
```

```{code-cell} ipython3
value_counts(resp12["nchildhh"])
```

```{code-cell} ipython3
value_counts(resp12["intent"])
```

```{code-cell} ipython3
value_counts(resp12["addexp"])
```

```{code-cell} ipython3
resp12["evrmarry"].value_counts()
```

```{code-cell} ipython3
resp12["marend01"].value_counts()
```

```{code-cell} ipython3
resp12["fmarno"].value_counts()
```

```{code-cell} ipython3
resp12["fmarno"].value_counts()
```

```{code-cell} ipython3
resp12["ager"].value_counts()
```

```{code-cell} ipython3
resp12["mardat01"].value_counts()
```

```{code-cell} ipython3
resp12["mardis01"].value_counts()
```

```{code-cell} ipython3
value_counts(resp12["marend01"])
```

```{code-cell} ipython3
resp12["cmdivorcx"].describe()
```

```{code-cell} ipython3
sum(resp12.evrmarry)
```

```{code-cell} ipython3
resp12.agemarry.value_counts().max()
```

```{code-cell} ipython3
Cdf.from_seq(resp12.ager).plot()
decorate(xlabel="Age", ylabel="CDF")
```

```{code-cell} ipython3
Cdf.from_seq(resp12.agemarry).plot()
decorate(xlabel="Age at first marriage", ylabel="CDF")
```

```{code-cell} ipython3
Cdf.from_seq(resp12.finalwgt).plot()
decorate(xlabel="Sampling weight", ylabel="CDF")
```

## Concatenate the data

Make a list of DataFrames, one for each cycle:

```{code-cell} ipython3
resps = [resp12, resp11, resp10, resp9, resp8, resp7, resp6, resp5, resp4, resp3]
# resps = [resp11]
```

Make a table showing the number of respondents in each cycle:

```{code-cell} ipython3
def SummarizeCycle(df):
    ages = df.ager.min(), df.ager.max()
    ages = np.array(ages)

    intvws = df.cmintvw.min(), df.cmintvw.max()
    intvws = np.array(intvws) / 12 + 1900

    births = df.cmbirth.min(), df.cmbirth.max()
    births = np.array(births) / 12 + 1900

    print("# & ", intvws.astype(int), "&", len(df), "&", births.astype(int), r"\\")


for resp in reversed(resps):
    SummarizeCycle(resp)
```

Check for missing values in `agemarry`:

```{code-cell} ipython3
def CheckAgeVars(df):
    print(sum(df[df.evrmarry].agemarry.isnull()))


for resp in resps:
    CheckAgeVars(resp)
```

Combine the DataFrames (but remember that this is not resampled properly):

```{code-cell} ipython3
df = pd.concat(resps, ignore_index=True, sort=False)
len(df)
```

```
1 CURRENTLY MARRIED 3971
2 NOT MARRIED BUT LIVING WITH OPP SEX PARTNER 1451
3 WIDOWED 43
4 DIVORCED 786
5 SEPARATED FOR REASONS OF MARITAL DISCORD 431
6 NEVER BEEN MARRIED 5597
```

```{code-cell} ipython3
pd.crosstab(df["bdegree"], df["cycle"], dropna=False)
```

```{code-cell} ipython3
pd.crosstab(df["fmarital"], df["cycle"], dropna=False)
```

```{code-cell} ipython3
pd.crosstab(df["strloper"], df["cycle"], dropna=False)
```

```{code-cell} ipython3
pd.crosstab(df["tubs"], df["cycle"], dropna=False)
```

```{code-cell} ipython3
pd.crosstab(df["hyst"], df["cycle"], dropna=False)
```

```{code-cell} ipython3
pd.crosstab(df["anycoll"], df["cycle"], dropna=False)
```

```{code-cell} ipython3
pd.crosstab(df["educat"], df["cycle"], dropna=False)
```

```{code-cell} ipython3
pd.crosstab(df["hieduc"], df["cycle"], dropna=False)
```

```{code-cell} ipython3
pd.crosstab(df["addexp"], df["cycle"], dropna=False)
```

```{code-cell} ipython3
pd.crosstab(df["agebaby1"], df["cycle"], dropna=False)
```

```{code-cell} ipython3
df.groupby("cycle")["agebaby1"].describe()
```

```{code-cell} ipython3
pd.crosstab(df["intent"], df["cycle"], dropna=False)
```

```{code-cell} ipython3
pd.crosstab(df["strloper"], df["cycle"], dropna=False)
```

```{code-cell} ipython3
pd.crosstab(df["parity"], df["cycle"], dropna=False)
```

```{code-cell} ipython3
pd.crosstab(df["fmarno"], df["cycle"], dropna=False)
```

```{code-cell} ipython3
pd.crosstab(df["evrmarry"], df["cycle"])
```

```{code-cell} ipython3
pd.crosstab(df["marend01"], df["cycle"])
```

```{code-cell} ipython3
df.groupby("cycle")["ager"].describe()
```

```{code-cell} ipython3
df.groupby("cycle")["cmmarrhx"].describe()
```

```{code-cell} ipython3
df.groupby("cycle")["cmintvw"].describe()
```

```{code-cell} ipython3
df.groupby("cycle")["cmbirth"].describe()
```

```{code-cell} ipython3
df.groupby("cycle")["cmdivorcx"].describe()
```

Double check missing data:

```{code-cell} ipython3
sum(df.missing)
```

Generate a table with the number of respondents in each cohort:

```{code-cell} ipython3
marriage.digitize_resp(df)
grouped = df.groupby("birth_index")
for name, group in iter(grouped):
    print(
        name,
        "&",
        len(group),
        "&",
        int(group.ager.min()),
        "--",
        int(group.age_index.max()),
        "&",
        len(group[group.evrmarry]),
        "&",
        sum(group.missing),
        r"\\",
    )
```

## Generate extracts

```{code-cell} ipython3
df.to_parquet(interim("FemMarriageData.parquet"), compression="zstd")
```

```{code-cell} ipython3
%time nsfg_female = pd.read_parquet(interim("FemMarriageData.parquet"))
```

```{code-cell} ipython3
df.to_csv(interim("marriage_nsfg_female.csv.gz"), index=False, compression="gzip")
```

```{code-cell} ipython3
!ls -lh marriage_nsfg_female.csv.gz
```

## Male data

+++

### Male 2002

```{code-cell} ipython3
male2002 = marriage.read_male_resp_2002()
male2002.columns
```

```{code-cell} ipython3
value_counts(male2002["bdegree"])
```

```{code-cell} ipython3
value_counts(male2002["fmarital"])
```

```{code-cell} ipython3
value_counts(male2002["rwant"])
```

### Male 2010

```{code-cell} ipython3
male2010 = marriage.read_male_resp_2010()
male2010.columns
```

```{code-cell} ipython3
value_counts(male2010["bdegree"])
```

```{code-cell} ipython3
value_counts(male2010["fmarital"])
```

```{code-cell} ipython3
value_counts(male2010["rwant"])
```

### Male 2013

```{code-cell} ipython3
male2013 = marriage.read_male_resp_2013()
male2013.columns
```

```{code-cell} ipython3
value_counts(male2013["bdegree"])
```

```{code-cell} ipython3
value_counts(male2013["fmarital"])
```

```{code-cell} ipython3
value_counts(male2013["rwant"])
```

### Male 2015

```{code-cell} ipython3
male2015 = marriage.read_male_resp_2015()
male2015.columns
```

```{code-cell} ipython3
value_counts(male2015["bdegree"])
```

```{code-cell} ipython3
value_counts(male2015["fmarital"])
```

```{code-cell} ipython3
value_counts(male2015["rwant"])
```

### Male 2017

```{code-cell} ipython3
male2017 = marriage.read_male_resp_2017()
male2017.columns
```

```{code-cell} ipython3
value_counts(male2017["bdegree"])
```

```{code-cell} ipython3
value_counts(male2017["fmarital"])
```

```{code-cell} ipython3
value_counts(male2017["rwant"])
```

### Male 2019

```{code-cell} ipython3
male2019 = marriage.read_male_resp_2019()
male2019.columns
```

```{code-cell} ipython3
value_counts(male2019["bdegree"])
```

```{code-cell} ipython3
value_counts(male2019["fmarital"])
```

```{code-cell} ipython3
value_counts(male2019["rwant"])
```

### Male 2023

```{code-cell} ipython3
male2023 = marriage.read_male_resp_2023()
male2023.columns
```

```{code-cell} ipython3
value_counts(male2023["bdegree"])
```

```{code-cell} ipython3
value_counts(male2023["fmarital"])
```

```{code-cell} ipython3
value_counts(male2023["anycoll"])
```

### Concat male data

```{code-cell} ipython3
import pandas as pd

males = [male2002, male2010, male2013, male2015, male2017, male2019, male2023]
df2 = pd.concat(males, ignore_index=True, sort=False)
len(df2)
```

```{code-cell} ipython3
value_counts(df2["cycle"])
```

```{code-cell} ipython3
pd.crosstab(df2["bdegree"], df2["cycle"], normalize='columns', dropna=False)
```

```{code-cell} ipython3
pd.crosstab(df2["fmarital"], df2["cycle"])
```

```{code-cell} ipython3
pd.crosstab(df2["anycoll"], df2["cycle"])
```

```{code-cell} ipython3
pd.crosstab(df2["hieduc"], df2["cycle"])
```

```{code-cell} ipython3
pd.crosstab(df2["everoper"], df2["cycle"])
```

```{code-cell} ipython3
pd.crosstab(df2["intent"], df2["cycle"])
```

```{code-cell} ipython3
pd.crosstab(df2["addexp"], df2["cycle"])
```

```{code-cell} ipython3
sum(df2.missing)
```

```{code-cell} ipython3
marriage.digitize_resp(df2)
grouped = df2.groupby("birth_index")
for name, group in iter(grouped):
    print(
        name,
        "&",
        len(group),
        "&",
        int(group.ager.min()),
        "--",
        int(group.age_index.max()),
        "&",
        len(group[group.evrmarry]),
        "&",
        sum(group.missing),
        r"\\",
    )
```

```{code-cell} ipython3
df2["complete"] = df2.evrmarry
df2["complete_var"] = df2.agemarry_index
df2["ongoing_var"] = df2.age_index
df2["complete_missing"] = df2.complete & df2.complete_var.isnull()
df2["ongoing_missing"] = ~df2.complete & df2.ongoing_var.isnull()
```

```{code-cell} ipython3
print(sum(df2.complete_missing), sum(df2.ongoing_missing))
```

```{code-cell} ipython3
df2.to_parquet(interim("MaleMarriageData.parquet"), compression="zstd")
```

```{code-cell} ipython3
%time nsfg_male = pd.read_parquet(interim("MaleMarriageData.parquet"))
```

```{code-cell} ipython3
df2.to_csv(interim("marriage_nsfg_male.csv.gz"), index=False, compression="gzip")
```

```{code-cell} ipython3
!ls -lh marriage_nsfg_*.csv.gz
```

```{code-cell} ipython3

```
