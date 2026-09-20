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
# If we're running on Colab, install empiricaldist
# https://pypi.org/project/empiricaldist/

import sys
IN_COLAB = 'google.colab' in sys.modules

if IN_COLAB:
    !pip install empiricaldist
```

```{code-cell} ipython3
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from empiricaldist import Pmf, Cdf
```

```{code-cell} ipython3
def values(series):
    """Count the values and sort.
    
    series: pd.Series
    
    returns: series mapping from values to frequencies
    """
    return series.value_counts().sort_index()
```

```{code-cell} ipython3
import re

def read_stata_dict(filename, **options):
    """Reads a Stata dictionary file.

    filename: open file pointer
    options: dict of options passed to open()

    returns: DataFrame of variable data
    """
    type_map = dict(byte=int, int=int, long=int, float=float,
                    double=float, numeric=float)

    var_info = []
    for line in open(filename, **options):
        match = re.search(r'_column\(([^)]*)\)', line)
        if not match:
            continue
        start = int(match.group(1))
        t = line.split()
        vtype, name, fstring = t[1:4]
        name = name.lower()
        if vtype.startswith('str'):
            vtype = str
        else:
            vtype = type_map[vtype]
        long_desc = ' '.join(t[4:]).strip('"')
        var_info.append((start, vtype, name, fstring, long_desc))

    columns = ['start', 'type', 'name', 'fstring', 'desc']
    variables = pd.DataFrame(var_info, columns=columns)
    variables['start'] -= 1

    # fill in the end column by shifting the start column
    # NOTE: choose a large number for the end of the last column
    variables['end'] = variables.start.shift(-1, fill_value=100000)

    return variables
```

```{code-cell} ipython3
def read_stata(dct_file, dat_file, **options):
    """Reads the NSFG respondent data.

    dct_file: string file name
    dat_file: string file name

    returns: DataFrame
    """
    variables = read_stata_dict(dct_file)
    colspecs = variables[['start', 'end']]
    names = variables['name']
    
    df = pd.read_fwf(dat_file,
                     colspecs=colspecs.values.tolist(),
                     names=names,
                     **options)
    return df
```

```{code-cell} ipython3
def read_fem_preg_10():
    """Reads pregnancy data from NSFG Cycle 10.

    returns: DataFrame
    """
    usecols = ['caseid', 
               'outcome',    # 1 for live birth
               'birthord',
               'agepreg',
               'hpagelb',
               'babysex1', 
               'babysex2', 
               'babysex3',
               'wgt2015_2017',
               ]

    df = read_stata('2015_2017_FemPregSetup.dct',
                    '2015_2017_FemPregData.dat.gz',
                    usecols=usecols) 
    
    df['finalwgt'] = df['wgt2015_2017']
    df['cycle'] = 10

    df['babysex1'].replace(9, np.nan, inplace=True)
    df['hpagelb'].replace([98, 99], np.nan, inplace=True)
    
    return df
```

```{code-cell} ipython3
preg10 = read_fem_preg_10()
preg10.shape
```

```{code-cell} ipython3
preg10['caseid'].describe()
```

```{code-cell} ipython3
values(preg10['outcome'])
```

```{code-cell} ipython3
values(preg10['agepreg'])
```

```{code-cell} ipython3
values(preg10['hpagelb'])
```

```{code-cell} ipython3
values(preg10['babysex1'])
```

```{code-cell} ipython3
values(preg10['babysex2'])
```

```{code-cell} ipython3
values(preg10['babysex3'])
```

```{code-cell} ipython3
preg10['finalwgt'].describe()
```

```{code-cell} ipython3
def read_fem_resp_10():
    """Reads respondent data from NSFG Cycle 10.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmintvw', 'ager',
               'evrmarry', 'parity', 'wgt2015_2017',
               'mardat01', 'marend01', 'mardis01', 'rmarital',
               'fmarno', 'mar1diss']

    df = read_stata('2015_2017_FemRespSetup.dct',
                    '2015_2017_FemRespData.dat.gz',
                    usecols=usecols) 
    
    df['finalwgt'] = df['wgt2015_2017']
    df['cycle'] = 10

    return df
```

```{code-cell} ipython3
def ReadFemResp1982():
    """Reads respondent data from NSFG Cycle 3.

    returns: DataFrame
    """
    dat_file = '1982NSFGData.dat.gz'
    names = ['finalwgt', 'ageint', 'mar2p', 'cmmarrhx', 'fmarital',
             'cmintvw', 'cmbirth', 'f18m1', 'cmdivorcx', 'cmstphsbx', 'fmarno']
    colspecs = [(976-1, 982),
                (1001-1, 1002),
                (1268-1, 1271),
                (1037-1, 1040),
                (1041-1, 1041),
                (841-1, 844),
                (12-1, 15),
                (606-1, 606),
                (619-1, 622),
                (625-1, 628),
                (1142-1, 1143),
                ]

    df = pd.read_fwf(dat_file,
                         colspecs=colspecs,
                         names=names,
                         header=None,
                         nrows=7969,
                         compression='gzip')

    df.cmintvw.replace([9797, 9898, 9999], np.nan, inplace=True)
    df.cmbirth.replace([9797, 9898, 9999], np.nan, inplace=True)
    df.cmmarrhx.replace([9797, 9898, 9999], np.nan, inplace=True)
    df.cmdivorcx.replace([9797, 9898, 9999], np.nan, inplace=True)
    df.cmstphsbx.replace([9797, 9898, 9999], np.nan, inplace=True)
    df.f18m1.replace([7, 8, 9], np.nan, inplace=True)

    # CM values above 9000 indicate month unknown
    df.loc[df.cmintvw>9000, 'cmintvw'] -= 9000
    df.loc[df.cmbirth>9000, 'cmbirth'] -= 9000
    df.loc[df.cmmarrhx>9000, 'cmmarrhx'] -= 9000
    df.loc[df.cmdivorcx>9000, 'cmdivorcx'] -= 9000
    df.loc[df.cmstphsbx>9000, 'cmstphsbx'] -= 9000

    df['evrmarry'] = (df.fmarno > 0)

    df['divorced'] = (df.f18m1 == 4)
    df['separated'] = (df.f18m1 == 5)
    df['widowed'] = (df.f18m1 == 3)
    df['stillma'] = (df.fmarno==1) & (df.fmarital==1)

    df['cycle'] = 3

    clean_resp(df)
    return df
```

```{code-cell} ipython3
def ReadFemResp1988():
    """Reads respondent data from NSFG Cycle 4.
    Read as if were a standard ascii file
    returns: DataFrame
    """
    filename = '1988FemRespDataLines.dat.gz'
    names = ['finalwgt', 'ageint', 'currentcm',
             'firstcm', 'cmintvw', 'cmbirth',
             'f23m1', 'cmdivorcx', 'cmstphsbx', 'fmarno']

    colspecs = [(2568-1, 2574),
                (36-1, 37),
                (1521-1, 1525),
                (1538-1, 1542),
                (12-1, 16),
                (26-1, 30),
                (1554-1, 1554),
                (1565-1, 1569),
                (1570-1, 1574),
                (2441-1, 2442),
                ]

    df = pd.read_fwf(filename,
                     colspecs=colspecs,
                     names=names,
                     header=None,
                     compression='gzip')

    df.cmintvw.replace([0, 99999], np.nan, inplace=True)
    df.cmbirth.replace([0, 99999], np.nan, inplace=True)
    df.firstcm.replace([0, 99999], np.nan, inplace=True)
    df.currentcm.replace([0, 99999], np.nan, inplace=True)
    df.cmdivorcx.replace([0, 99999], np.nan, inplace=True)
    df.cmstphsbx.replace([0, 99999], np.nan, inplace=True)

    # CM values above 9000 indicate month unknown
    df.loc[df.cmintvw>90000, 'cmintvw'] -= 90000
    df.loc[df.cmbirth>90000, 'cmbirth'] -= 90000
    df.loc[df.firstcm>90000, 'firstcm'] -= 90000
    df.loc[df.currentcm>90000, 'currentcm'] -= 90000
    df.loc[df.cmdivorcx>90000, 'cmdivorcx'] -= 90000
    df.loc[df.cmstphsbx>90000, 'cmstphsbx'] -= 90000

    # combine current and first marriage
    df['cmmarrhx'] = df.firstcm
    df.cmmarrhx.fillna(df.currentcm, inplace=True)

    # define evrmarry if either currentcm or firstcm is non-zero
    df['evrmarry'] = (df.fmarno > 0)

    df['divorced'] = (df.f23m1==2)
    df['separated'] = (df.f23m1==3)
    df['widowed'] = (df.f23m1==1)
    df['stillma'] = (df.fmarno==1) & (df.f23m1.isnull())

    df['cycle'] = 4

    clean_resp(df)
    return df
```

```{code-cell} ipython3
def ReadFemResp1995():
    """Reads respondent data from NSFG Cycle 5.

    returns: DataFrame
    """
    dat_file = '1995FemRespData.dat.gz'
    names = ['cmintvw', 'timesmar', 'cmmarrhx', 'cmbirth', 'finalwgt',
             'marend01', 'cmdivorcx', 'cmstphsbx', 'marstat']

    colspecs = [(12360-1, 12363),
                (4637-1, 4638),
                (11759-1, 11762),
                (14-1, 16),
                (12350-1, 12359),
                (4713-1, 4713),
                (4718-1, 4721),
                (4722-1, 4725),
                (17-1, 17)]

    df = pd.read_fwf(dat_file,
                         compression='gzip',
                         colspecs=colspecs,
                         names=names)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)
    df.cmbirth.replace(invalid, np.nan, inplace=True)
    df.cmmarrhx.replace(invalid, np.nan, inplace=True)
    df.cmdivorcx.replace(invalid, np.nan, inplace=True)
    df.cmstphsbx.replace(invalid, np.nan, inplace=True)
    df.timesmar.replace([98, 99], np.nan, inplace=True)

    df['evrmarry'] = (df.timesmar > 0)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.timesmar==1) & (df.marend01.isnull())

    df['cycle'] = 5

    clean_resp(df)
    return df
```

```{code-cell} ipython3
def ReadFemResp2002():
    """Reads respondent data from NSFG Cycle 6.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'parity', 'finalwgt',
               'mardat01', 'marend01', 'mardis01', 'rmarital',
               'fmarno', 'mar1diss']

    df = read_fem_resp('2002FemResp.dct', '2002FemResp.dat.gz', usecols=usecols)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)
    df.cmbirth.replace(invalid, np.nan, inplace=True)
    df.cmmarrhx.replace(invalid, np.nan, inplace=True)

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['cycle'] = 6
    clean_resp(df)
    return df
```

```{code-cell} ipython3
def ReadFemResp2010():
    """Reads respondent data from NSFG Cycle 7.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'parity', 'wgtq1q16',
               'mardat01', 'marend01', 'mardis01', 'rmarital',
               'fmarno', 'mar1diss']

    df = read_fem_resp('2006_2010_FemRespSetup.dct',
                  '2006_2010_FemResp.dat.gz',
                  usecols=usecols)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)
    df.cmbirth.replace(invalid, np.nan, inplace=True)
    df.cmmarrhx.replace(invalid, np.nan, inplace=True)

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgtq1q16
    df['cycle'] = 7
    clean_resp(df)
    return df
```

```{code-cell} ipython3
def ReadFemResp2010():
    """Reads respondent data from NSFG Cycle 7.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'parity', 'wgtq1q16',
               'mardat01', 'marend01', 'mardis01', 'rmarital',
               'fmarno', 'mar1diss']

    df = read_fem_resp('2006_2010_FemRespSetup.dct',
                  '2006_2010_FemResp.dat.gz',
                  usecols=usecols)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)
    df.cmbirth.replace(invalid, np.nan, inplace=True)
    df.cmmarrhx.replace(invalid, np.nan, inplace=True)

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgtq1q16
    df['cycle'] = 7
    clean_resp(df)
    return df
```

```{code-cell} ipython3
def ReadFemResp2013():
    """Reads respondent data from NSFG Cycle 8.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'parity', 'wgt2011_2013',
               'mardat01', 'marend01', 'mardis01', 'rmarital',
               'fmarno', 'mar1diss']

    df = read_fem_resp('2011_2013_FemRespSetup.dct',
                  '2011_2013_FemRespData.dat.gz',
                  usecols=usecols)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)
    df.cmbirth.replace(invalid, np.nan, inplace=True)
    df.cmmarrhx.replace(invalid, np.nan, inplace=True)

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2011_2013
    df['cycle'] = 8
    clean_resp(df)
    return df
```

```{code-cell} ipython3
def ReadFemResp2015():
    """Reads respondent data from NSFG Cycle 9.

    returns: DataFrame
    """
    usecols = ['caseid', 'cmmarrhx', 'cmdivorcx', 'cmbirth', 'cmintvw',
               'evrmarry', 'parity', 'wgt2013_2015',
               'mardat01', 'marend01', 'mardis01', 'rmarital',
               'fmarno', 'mar1diss']

    df = read_fem_resp('2013_2015_FemRespSetup.dct',
                  '2013_2015_FemRespData.dat.gz',
                  usecols=usecols)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)
    df.cmbirth.replace(invalid, np.nan, inplace=True)
    df.cmmarrhx.replace(invalid, np.nan, inplace=True)

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2013_2015
    df['cycle'] = 9
    clean_resp(df)
    return df
```

```{code-cell} ipython3
def ReadFemResp2017():
    """Reads respondent data from NSFG Cycle 10.

    returns: DataFrame
    """
    # removed 'cmmarrhx', 'cmdivorcx', 'cmbirth',
    usecols = ['caseid', 'cmintvw', 'ager',
               'evrmarry', 'parity', 'wgt2015_2017',
               'mardat01', 'marend01', 'mardis01', 'rmarital',
               'fmarno', 'mar1diss']

    df = read_fem_resp('2015_2017_FemRespSetup.dct',
                  '2015_2017_FemRespData.dat.gz',
                  usecols=usecols)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)
    #df.cmbirth.replace(invalid, np.nan, inplace=True)
    #df.cmmarrhx.replace(invalid, np.nan, inplace=True)

    # since cmbirth and cmmarrhx are no longer included,
    # we have to compute them based on other variables;
    # the result can be off by up to 12 months
    df['cmbirth'] = df.cmintvw - df.ager*12
    df['cmmarrhx'] = (df.mardat01-1900) * 12

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2015_2017
    df['cycle'] = 10

    # Instead of calling clean_resp, we have to customize
    #clean_resp(df)

    df['agemarry'] = (df.cmmarrhx - df.cmbirth) / 12.0
    df['age'] = (df.cmintvw - df.cmbirth) / 12.0

    # if married, we need agemarry; if not married, we need age
    df['missing'] = np.where(df.evrmarry,
                             df.agemarry.isnull(),
                             df.age.isnull())

    month0 = pd.to_datetime('1899-12-15')
    dates = [month0 + pd.DateOffset(months=cm)
             for cm in df.cmbirth]
    df['year'] = (pd.DatetimeIndex(dates).year - 1900)

    digitize_resp(df)

    return df
```

```{code-cell} ipython3
def ReadFemResp2017():
    """Reads respondent data from NSFG Cycle 10.

    returns: DataFrame
    """
    # removed 'cmmarrhx', 'cmdivorcx', 'cmbirth',
    usecols = ['caseid', 'cmintvw', 'ager',
               'evrmarry', 'parity', 'wgt2015_2017',
               'mardat01', 'marend01', 'mardis01', 'rmarital',
               'fmarno', 'mar1diss']

    df = read_fem_resp('2015_2017_FemRespSetup.dct',
                  '2015_2017_FemRespData.dat.gz',
                  usecols=usecols)

    invalid = [9997, 9998, 9999]
    df.cmintvw.replace(invalid, np.nan, inplace=True)
    #df.cmbirth.replace(invalid, np.nan, inplace=True)
    #df.cmmarrhx.replace(invalid, np.nan, inplace=True)

    # since cmbirth and cmmarrhx are no longer included,
    # we have to compute them based on other variables;
    # the result can be off by up to 12 months
    df['cmbirth'] = df.cmintvw - df.ager*12
    df['cmmarrhx'] = (df.mardat01-1900) * 12

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2015_2017
    df['cycle'] = 10

    # Instead of calling clean_resp, we have to customize
    #clean_resp(df)

    df['agemarry'] = (df.cmmarrhx - df.cmbirth) / 12.0
    df['age'] = (df.cmintvw - df.cmbirth) / 12.0

    # if married, we need agemarry; if not married, we need age
    df['missing'] = np.where(df.evrmarry,
                             df.agemarry.isnull(),
                             df.age.isnull())

    month0 = pd.to_datetime('1899-12-15')
    dates = [month0 + pd.DateOffset(months=cm)
             for cm in df.cmbirth]
    df['year'] = (pd.DatetimeIndex(dates).year - 1900)

    digitize_resp(df)

    return df
```

```{code-cell} ipython3
def clean_resp(resp):
    """Cleans a respondent DataFrame.

    resp: DataFrame of respondents

    Adds columns: agemarry, age, decade, fives
    """
    resp['agemarry'] = (resp.cmmarrhx - resp.cmbirth) / 12.0
    resp['age'] = (resp.cmintvw - resp.cmbirth) / 12.0

    # if married, we need agemarry; if not married, we need age
    resp['missing'] = np.where(resp.evrmarry,
                               resp.agemarry.isnull(),
                               resp.age.isnull())

    month0 = pd.to_datetime('1899-12-15')
    dates = [month0 + pd.DateOffset(months=cm)
             for cm in resp.cmbirth]
    resp['year'] = (pd.DatetimeIndex(dates).year - 1900)
    #resp['decade'] = resp.year // 10
    #resp['fives'] = resp.year // 5
    digitize_resp(resp)
```

```{code-cell} ipython3
def digitize_resp(df):
    """Computes indices for age, agemarry, and birth year.

    Groups each of these variables into bins and then assigns
    an index to each bin.

    For example, anyone between 30 and 30.99 year old is
    assigned age_index 30.  Anyone born in the 80s is given
    the year_index 80.

    This function allows me to run the analysis with different
    levels of granularity.

    df: DataFrame
    """
    age_min = 10
    age_max = 55
    age_step = 1
    age_bins = np.arange(age_min, age_max, age_step)

    year_min = 0
    year_max = 120
    year_step = 10
    year_bins = np.arange(year_min, year_max, year_step)

    df['age_index'] = np.digitize(df.age, age_bins) * age_step
    df.age_index += age_min - age_step
    df.loc[df.age.isnull(), 'age_index'] = np.nan

    df['agemarry_index'] = np.digitize(df.agemarry, age_bins) * age_step
    df.agemarry_index += age_min - age_step
    df.loc[df.agemarry.isnull(), 'agemarry_index'] = np.nan

    df['birth_index'] = np.digitize(df.year, year_bins) * year_step
    df.birth_index += year_min - year_step
```

```{code-cell} ipython3
def ReadMaleResp2002():
    """Reads respondent data from NSFG Cycle 6.

    returns: DataFrame
    """
    usecols = ['caseid', 'mardat01', 'cmdivw', 'cmbirth', 'cmintvw',
               'evrmarry', 'finalwgt', 'fmarit', 'timesmar', 'marrend4',
               #'marrend', 'marrend2', 'marrend3', marrend5', 'marrend6',
               ]

    df = read_fem_resp('2002Male.dct', '2002Male.dat.gz', usecols=usecols)

    #df.marrend.replace([8,9], np.nan, inplace=True)
    #df.marrend2.replace([8,9], np.nan, inplace=True)
    #df.marrend3.replace([8,9], np.nan, inplace=True)
    df.marrend4.replace([8,9], np.nan, inplace=True)
    #df.marrend5.replace([8,9], np.nan, inplace=True)
    #df.marrend6.replace([8,9], np.nan, inplace=True)
    df.timesmar.replace([98,99], np.nan, inplace=True)

    # the way marriage ends are recorded is really confusing,
    # but it looks like marrend4 is the end of the first marriage.
    df['marend01'] = df.marrend4

    df['cmmarrhx'] = df.mardat01

    df['evrmarry'] = (df.timesmar > 0)
    df['divorced'] = (df.marend01==2) | (df.marend01==3)
    df['separated'] = (df.marend01==4)
    df['widowed'] = (df.marend01==1)
    df['stillma'] = (df.timesmar== 1) & (df.fmarit==1)

    df['cycle'] = 6
    clean_resp(df)

    return df
```

```{code-cell} ipython3
def ReadMaleResp2010():
    """Reads respondent data from NSFG Cycle 7.

    returns: DataFrame
    """
    usecols = ['caseid', 'mardat01', 'cmdivw', 'cmbirth', 'cmintvw',
               'evrmarry', 'wgtq1q16',
               'marend01', 'rmarital', 'fmarno', 'mar1diss']

    df = read_fem_resp('2006_2010_MaleSetup.dct',
                  '2006_2010_Male.dat.gz',
                  usecols=usecols)

    df['cmmarrhx'] = df.mardat01

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgtq1q16
    df['cycle'] = 7

    clean_resp(df)
    return df
```

```{code-cell} ipython3
def ReadMaleResp2013():
    """Reads respondent data from NSFG Cycle 8.

    returns: DataFrame
    """
    usecols = ['caseid', 'mardat01', 'cmdivw', 'cmbirth', 'cmintvw',
               'evrmarry', 'wgt2011_2013',
               'marend01', 'rmarital', 'fmarno', 'mar1diss']

    df = read_fem_resp('2011_2013_MaleSetup.dct',
                  '2011_2013_MaleData.dat.gz',
                  usecols=usecols)

    df['cmmarrhx'] = df.mardat01

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2011_2013
    df['cycle'] = 8

    clean_resp(df)
    return df
```

```{code-cell} ipython3
def ReadMaleResp2015():
    """Reads respondent data from NSFG Cycle 9.

    returns: DataFrame
    """
    usecols = ['caseid', 'mardat01', 'cmdivw', 'cmbirth', 'cmintvw',
               'evrmarry', 'wgt2013_2015',
               'marend01', 'rmarital', 'fmarno', 'mar1diss']

    df = read_fem_resp('2013_2015_MaleSetup.dct',
                  '2013_2015_MaleData.dat.gz',
                  usecols=usecols)

    df['cmmarrhx'] = df.mardat01

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2013_2015
    df['cycle'] = 9
    clean_resp(df)
    return df
```

```{code-cell} ipython3
def ReadMaleResp2017():
    """Reads respondent data from NSFG Cycle 10.

    returns: DataFrame
    """
    usecols = ['caseid', 'mardat01', 'cmintvw', 'ager',
               'evrmarry', 'wgt2015_2017',
               'marend01', 'rmarital', 'fmarno', 'mar1diss']

    df = read_fem_resp('2015_2017_MaleSetup.dct',
                      '2015_2017_MaleData.dat.gz',
                      usecols=usecols)

    # since cmbirth and cmmarrhx are no longer included,
    # we have to compute them based on other variables;
    # the result can be off by up to 12 months
    df['cmbirth'] = df.cmintvw - df.ager*12
    df['cmmarrhx'] = (df.mardat01-1900) * 12

    df['evrmarry'] = (df.evrmarry==1)
    df['divorced'] = (df.marend01==1)
    df['separated'] = (df.marend01==2)
    df['widowed'] = (df.marend01==3)
    df['stillma'] = (df.fmarno == 1) & (df.rmarital==1)

    df['finalwgt'] = df.wgt2015_2017
    df['cycle'] = 10

    # Instead of calling clean_resp, we have to customize
    #clean_resp(df)

    df['agemarry'] = (df.cmmarrhx - df.cmbirth) / 12.0
    df['age'] = (df.cmintvw - df.cmbirth) / 12.0

    # if married, we need agemarry; if not married, we need age
    df['missing'] = np.where(df.evrmarry,
                                 df.agemarry.isnull(),
                                 df.age.isnull())

    month0 = pd.to_datetime('1899-12-15')
    dates = [month0 + pd.DateOffset(months=cm)
                 for cm in df.cmbirth]
    df['year'] = (pd.DatetimeIndex(dates).year - 1900)

    digitize_resp(df)
    return df
```

```{code-cell} ipython3

```
