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
df = nsfg3.ReadFemResp2010()
len(df)
```

```{code-cell} ipython3
df.evrmarry.value_counts()
```

```{code-cell} ipython3
len(df[(df.cmbirth >= 522) & (df.cmbirth <= 1278)])
```

```{code-cell} ipython3
len(df[(df.cmmarrhx >= 522) & (df.cmmarrhx <= 1278)])
```

```{code-cell} ipython3
len(df[(df.cmmarrhx.isnull())])
```

```{code-cell} ipython3
df.cmintvw.value_counts().sort_index()
```

```{code-cell} ipython3
df.finalwgt.value_counts().sort_index()
```

```{code-cell} ipython3

```

```{code-cell} ipython3

```
