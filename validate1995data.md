---
jupytext:
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.19.5
kernelspec:
  display_name: Python 3
  language: python
  name: python3
---

```{code-cell} ipython3
from __future__ import print_function, division

import nsfg3
```

```{code-cell} ipython3
import pandas
import numpy as np

def ReadFemResp1995():
    """Reads respondent data from NSFG Cycle 5.

    returns: DataFrame
    """
    dat_file = '1995FemRespData.dat.gz'
    names = ['cmintvw', 'timesmar', 'cmmarrhx', 'cmbirth', 'finalwgt']
    colspecs = [(12360-1, 12363),
                (4637-1, 4638),
                (11759-1, 11762),
                (14-1, 16),
                (12350-1, 12359)]
    df = pandas.read_fwf(dat_file, 
                         compression='gzip', 
                         colspecs=colspecs, 
                         names=names)

    df.timesmar.replace([98, 99], np.nan, inplace=True)
    df['evrmarry'] = (df.timesmar > 0)

    nsfg3.CleanData(df)
    return df
```

```{code-cell} ipython3
df = ReadFemResp1995()
```

```{code-cell} ipython3
sum(~df.evrmarry)
```

```{code-cell} ipython3
len(df[(df.cmbirth >= 604) & (df.cmbirth <= 720)])
```

```{code-cell} ipython3
len(df[(df.cmmarrhx >= 780) & (df.cmmarrhx <= 840)])
```

```{code-cell} ipython3
df.cmintvw.value_counts().sort_index()
```

```{code-cell} ipython3
df.finalwgt.value_counts().sort_index()
```

```{code-cell} ipython3
df.timesmar.value_counts().sort_index()
```

```{code-cell} ipython3

```
