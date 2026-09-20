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
df = nsfg3.ReadFemResp2002()
```

```{code-cell} ipython3
sum(df.evrmarry)
```

```{code-cell} ipython3
len(df[(df.cmbirth >= 301) & (df.cmbirth <= 1164)])
```

```{code-cell} ipython3
len(df[(df.cmmarrhx >= 301) & (df.cmmarrhx <= 1164)])
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
