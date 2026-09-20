# Working in this repo

NSFG survey data harmonized across cycles 3 (1982) through 12 (2022–2023), and analyses of US marriage patterns. `PROJECT_BOARD.md` holds the numbered tasks and is the place to record findings; `planning/` holds the longer designs.

## The data is not here, and must not be

NSFG and IPUMS public-use files may not be redistributed. They were purged from this repo's history on 2026-09-20 (`git filter-repo`, force-pushed), and `data/` is gitignored.

**Before committing anything, check it is not survey microdata.** The derived extracts count as data too — `data/interim/*.parquet` is respondent-level and stays out.

NCHS *documentation* is different: it is a US government work in the public domain, which is why `codebooks/` is committed.

## Layout

```
nsfg/          the package: marriage.py (readers + cleaning), utils.py
               (plotting/stats), survival.py (ported KM), paths.py
notebooks/     analyses as jupytext markdown; archive/ is unmaintained
data/raw/      source files, gitignored, fetched by scripts/download_nsfg.py
data/interim/  clean_nsfg output, gitignored, regenerated
figures/       published figures and their .md write-ups
codebooks/     NSFG codebooks as greppable text
archive/       vendored Think Stats, reference only -- nothing imports it
```

## Notebooks: edit the markdown

`notebooks/*.md` is the source of truth. The `.ipynb` is generated from it and is **also committed**, because it carries the executed outputs and the data is not in the repo — those outputs are the only way a reader sees results on GitHub.

```bash
make notebooks   # .md -> .ipynb
make execute     # run in place, tolerating failures, with a per-notebook verdict
make markdown    # .ipynb -> .md, after editing in Jupyter
make data        # rebuild data/interim from data/raw
```

Never edit the `.ipynb` directly. Commit the `.md` and `.ipynb` together or they drift.

## Traps

**Paths must go through `nsfg.paths`.** `raw("file.dat.gz")`, `interim(...)`, `FIGURES / name`. Nothing may assume the working directory — nbconvert runs a notebook with *that notebook's* directory as the CWD. This has bitten four times during the reorganization; if a figure or download lands in `notebooks/`, this is why.

**`pd.read_fwf` does not infer gzip** from the filename. Pass `compression="gzip"` explicitly.

**Cycle numbers are NSFG's own**: 3=1982, 4=1988, 5=1995, 6=2002, 7=2010, 8=2013, 9=2015, 10=2017, 11=2019, 12=2022–2023.

**`ager` changes meaning across cycles.** For cycles ≤9 `clean_resp` overwrites it with the exact fractional age derived from the real `cmbirth`. Cycles 10–12 bypass `clean_resp` and keep the raw *integer* age, because the PUF stopped shipping `cmbirth` and it is reconstructed. Getting this wrong caused Task 14, where `agemarry` was a year too low in the three most recent cycles.

**Reconstructed variables need a feasibility check.** Anything derived from an integer age has a constraint it must satisfy; nothing checks these automatically yet (Task 11).

**Kaplan-Meier tails are unreliable when the risk set empties.** `make_kmf_map` truncates below `min_at_risk=10`. Without it, the youngest cohort ends on a single respondent and the curve jumps to 100%.

**`marriage.py` and `utils.py` define six of the same names** — `underride`, `decorate`, `legend` (identical), and `value_counts`, `resample_rows_weighted`, `percentile_rows` (divergent). Notebooks importing both get whichever won the import. Unresolved; see Task 1.

**`fertility.md` contains a bare `stop`** which halts execution deliberately. Cells after it are exploratory. `make execute` tolerates this; see Task 17.

**pip can silently downgrade conda packages.** `environment.yml` installs some things with pip, and `lifelines` pins `pandas<3.0` — enough to pull pandas back from 3.0.6 to 2.3.3 while `conda list` still reports 3.0.6. Check `site-packages/*.dist-info`, not just `conda list`.

## Writing markdown

Two conventions for every `.md` file in this repo — the board, the planning docs, the README, and anything under `jb/`.

No hard line breaks inside a paragraph. One paragraph is one line, however long. Wrapping at 80 columns makes every later edit produce a re-flow diff that buries the actual change, and editors soft-wrap anyway. The same goes for list items: a bullet is one line.

No bold for emphasis. Italics where a word genuinely needs marking, and otherwise let the sentence carry it. Bold used as a lead-in to bullets or paragraphs counts as emphasis too — it reads as shouting, and once it is everywhere it emphasises nothing.

## Environment

Use **mamba**, not conda — the conda solver takes minutes here.

```bash
make env          # create
make env-update   # update from environment.yml
```

## Verifying a change to the pipeline

Any change that could move numbers gets checked against a saved baseline:

```python
import pandas as pd
df = pd.read_parquet("data/interim/FemMarriageData.parquet")
print(df.shape, sorted(df.cycle.unique()))
print(pd.util.hash_pandas_object(df.fillna(-999)).sum())
```

Compare shape, columns, per-cycle counts and the frame hash before and after. A refactor that is supposed to be behavior-preserving must produce an identical hash; that is what made the reorganization verifiable. Changes that *are* expected to move numbers get their own commit, so the diff is attributable.

## Git

Commit everything before rewriting history — `git filter-repo` checks out the rewritten tree and discards uncommitted changes to tracked files. And `git clone --mirror` is not a backup of an LFS repo: it copies no LFS objects. Both were learned the hard way; see Task 1.
