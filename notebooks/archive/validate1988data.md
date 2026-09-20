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
import numpy as np

%matplotlib inline
```

```{code-cell}
filename = '1988FemRespData.dat'
fin = open(filename, 'r')
line = fin.read(3553)
print(line)
```

```{code-cell}
def add_newlines():
    filename = '1988FemRespData.dat'
    fin = open(filename, 'r')
    fout = open('1988FemRespDataLines.dat', 'w')

    for i in range(8450):
        line = fin.read(3553)
        fout.write(line + '\n')
    
    fout.close()
```

```{code-cell}
filename = '1988FemRespDataLines.dat.gz'
fp = gzip.open(filename, 'r')

s = '0123456789'
print(s*8)

for i, line in enumerate(fp):
    print(line)
    if i > 0:
        break
```

```{code-cell}
filename = '1988FemRespDataLines.dat.gz'
names = ['finalwgt', 'ageint', 'currentcm', 'firstcm', 'cmintvw', 'cmbirth']
colspecs = [(2568-1, 2574),
            (36-1, 37),
            (1521-1, 1525),
            (1538-1, 1542),
            (12-1, 16),
            (26-1, 30),
            ]
df = pandas.read_fwf(filename,
                     colspecs=colspecs, 
                     names=names,
                     header=None,
                     compression='gzip')
```

```{code-cell}
len(df)  # should be 8450
```

```{code-cell}
df.ageint.value_counts().sort_index()
```

```{code-cell}
df.currentcm.value_counts().sort_index()
```

```{code-cell}
df.currentcm.replace([0, 99999], np.nan, inplace=True)
df.loc[df.currentcm>90000, 'currentcm'] -= 90000
```

```{code-cell}
df.firstcm.value_counts().sort_index()
```

```{code-cell}
df.firstcm.replace([0, 99999], np.nan, inplace=True)
df.loc[df.firstcm>90000, 'firstcm'] -= 90000
```

```{code-cell}
df['cmmarrhx'] = df.currentcm
df.cmmarrhx.fillna(df.firstcm)
sum(df.cmmarrhx.isnull())
```

```{code-cell}
df.cmintvw.value_counts().sort_index()
```

```{code-cell}
df.cmbirth.value_counts().sort_index()
```

```{code-cell}
survival.CleanData(df)
```

```{code-cell}
df['evrmarry'] = ~df.cmmarrhx.isnull()
df
```

```{code-cell}
cdf = thinkstats2.Cdf(df.age - df.ageint)
thinkplot.Cdf(cdf)
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
