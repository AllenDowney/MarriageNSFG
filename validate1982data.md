---
jupytext:
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.19.5
---

```{code-cell}
from __future__ import print_function, division

import survival
import thinkstats2
import thinkplot

import gzip
import pandas

%matplotlib inline
```

```{code-cell}
filename = '1982NSFGData.dat.gz'
fp = gzip.open(filename, 'rb')
```

```{code-cell}
s = '0123456789'
print(s*8)

for i, line in enumerate(fp):
    print(line)
    if i > 0:
        break
```

```{code-cell}
filename = '1982NSFGData.dat.gz'
names = ['finalwgt', 'ageint', 'mar2p', 'cmmarrhx', 'cmintvw', 'cmbirth']
colspecs = [(976-1, 982),
            (1001-1, 1002),
            (1268-1, 1271),
            (1037-1, 1040),
            (841-1, 844),
            (12-1, 15),
            ]
df = pandas.read_fwf(filename,
                     colspecs=colspecs, 
                     names=names,
                     header=None,
                     nrows=7969,
                     compression='gzip')

len(df) # should be 7969
```

```{code-cell}
df.ageint.value_counts().sort_index()
```

```{code-cell}
df[df.cmbirth>9000].shape   #should be 21 unknown month of birth
```

```{code-cell}
df.loc[df.cmbirth>9000, 'cmbirth'] -= 9000
```

```{code-cell}
survival.CleanData(df)
```

```{code-cell}
df[df.mar2p.isnull()].shape
```

```{code-cell}
df[df.cmmarrhx.isnull()].shape
```

```{code-cell}
df['evrmarry'] = ~df.cmmarrhx.isnull()
```

```{code-cell}
df.loc[df.evrmarry & df.cmmarrhx.isnull()].shape
```

```{code-cell}
df.ageint.value_counts().sort_index()
```

```{code-cell}
cdf = thinkstats2.Cdf(df.agemarry)
thinkplot.Cdf(cdf)
len(df.agemarry.dropna())
```

```{code-cell}

```

```{code-cell}

```
