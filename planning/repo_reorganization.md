# Repo reorganization — design

Detail for **Task 1** on `PROJECT_BOARD.md`. Written 2026-09-20, before any of it has been executed.

## Why

The repo has ~150 files in a flat root. `git status` reports 13 modified and 78 untracked paths, so it no longer functions as a signal — a real change is invisible in the noise. Raw survey data, derived products, 49 loose figures, 2015-era vendored library code and active analysis all sit in one directory.

The immediate goal is to update the analysis for the 2022–2023 cycle. The organizing work is worth doing now because the next cycle will arrive too, and because three of the problems found while surveying the repo are not cosmetic: the repo cannot be cloned into a working state, it publishes data it should not, and a derived variable is wrong for the new cycle.

## Target layout

```
MarriageNSFG/
├── PROJECT_BOARD.md, CLAUDE.md, README.md, LICENSE
├── Makefile, environment.yml, pyproject.toml, .gitignore
├── nsfg/                     # installed with `pip install -e .`
│   ├── __init__.py
│   ├── paths.py              # DATA_RAW, DATA_INTERIM, FIGURES
│   ├── readers.py            # the 17 cycle readers + dispatch
│   ├── clean.py              # clean_resp, digitize_resp, resampling
│   ├── survival.py           # cohort survival estimation
│   └── plotting.py           # from utils.py
├── notebooks/                # *.md tracked; *.ipynb generated and gitignored
│   ├── clean_nsfg.md         # the ETL hub
│   ├── marriage_education.md, marriage_education_cps.md
│   ├── fertility.md, intent.md
│   ├── marriage_lifelines.md, agebaby_lifelines.md
│   ├── validate_sex_ratio.md
│   └── archive/              # converted, unmaintained
├── scripts/download_nsfg.py
├── data/
│   ├── raw/                  # gitignored except .gitkeep
│   └── interim/              # gitignored except .gitkeep
├── figures/                  # tracked PNGs + the .md write-ups
├── planning/
├── archive/                  # thinkstats2.py, thinkplot.py, survival.py, nsfg.py
└── tests/
```

## Sequencing

**The rule that governs everything else: do not restructure the repo and rebuild the environment at the same time.** If both change at once and a figure shifts, there is no way to attribute it. The reorg is verified under the *current* environment — Python 3.10.14, pandas 2.2.3, numpy 1.26.4 — and only then does the environment change, as its own separately-verified step.

| Stage | Work | Why here |
|---|---|---|
| 0 | `git clone --mirror` backup; copy `data/` outside the repo | Everything after this is destructive |
| 1 | Snapshot the verification baseline | Must predate any change |
| 2 | Commit all pending work as-is (Task 3) | Gets 17 months into history before any rewrite. The commits get replaced by stage 3; the content survives |
| 3 | `git filter-repo` purge; re-add `origin`; force-push (Task 4) | Before the restructure, so the rewrite operates on the old flat paths and the globs stay simple |
| 4 | `.gitignore`; delete `.gitattributes`; drop LFS | With no data tracked, LFS has no purpose. This is what shrinks `.git` from 486 MB |
| 5 | Directory restructure; `nsfg/paths.py`; `pyproject.toml`; `pip install -e .` | — |
| 6 | Port the hazard function verbatim; archive the legacy modules | Removes 145 of 184 CamelCase functions from the rename scope, without moving a number |
| 7 | Install jupytext; convert notebooks; round-trip gate; drop `.ipynb` from git | — |
| 8 | PEP-8 rename + dispatch wrapper (Task 8) | After 6 and 7, so it touches 39 functions in markdown rather than 184 in JSON |
| 9 | **Verify against the baseline, still on the old environment** | Isolates the reorg from the upgrade |
| 10 | Then Task 2 (environment), then Task 13 (`empiricaldist`) | Each is a separate variable with its own verification |

Two notes on stage 3. `git filter-repo` **removes the `origin` remote by design**, as a guard against reflexively pushing a rewritten history; it has to be re-added deliberately. And the rewrite does not remove the LFS objects already on GitHub — that needs a support request.

## Path resolution

Every reader in `marriage.py` uses a bare relative filename:

```python
def ReadFemResp1995():
    df = pd.read_fwf("1995FemRespData.dat.gz", compression="gzip", ...)
```

This works today only because every notebook sits in the repo root. After the move, both `nsfg/` and `notebooks/` break. The fix anchors to the package location rather than the CWD, which matters because nbconvert executes a notebook with that notebook's directory as the CWD:

```python
# nsfg/paths.py
from pathlib import Path

REPO_ROOT    = Path(__file__).resolve().parent.parent
DATA_RAW     = REPO_ROOT / "data" / "raw"
DATA_INTERIM = REPO_ROOT / "data" / "interim"
FIGURES      = REPO_ROOT / "figures"
```

A reader becomes:

```python
def read_fem_resp_1995(data_dir=None):
    path = (data_dir or DATA_RAW) / "1995FemRespData.dat.gz"
    df = pd.read_fwf(path, compression="gzip", ...)
```

The optional argument keeps the tests able to point at a fixture directory without monkeypatching.

`plotting.savefig` resolves its prefix against `FIGURES`. That also fixes an existing inconsistency: `marriage_education_cps.ipynb` hardcodes `utils.savefig("figures/marriage_education_cps", ...)` while every other notebook writes to the repo root — which is why `marriage_education_cps01–06.png` currently exist as byte-identical duplicates in both places.

## Retiring the legacy stack — two steps, deliberately separated

`marriage.py` touches the vendored Think Stats code at exactly one place, `marriage.py:317`:

```python
hf = survival.EstimateHazardFunction(complete, ongoing)
if cutoff:
    hf.Truncate(cutoff)
sf = hf.MakeSurvival()
```

Importing `survival` transitively pulls `nsfg`, `thinkstats2` and `thinkplot`, so that one line keeps 116 KB of 2015 code loaded on every current run — including in `clean_nsfg`, which uses none of its API.

**Stage 6: port verbatim.** Move `EstimateHazardFunction` (~35 lines) plus the `HazardFunction` and `SurvivalFunction` classes into `nsfg/survival.py`, dropping `MakeCdf`, `MakePmf` and `RemainingLifetime` — the only methods that reference `thinkstats2`. Nothing calls them from the live path. That is roughly 150 lines, and it retires all four legacy modules at once.

This port is deliberately mechanical. Because it cannot change a number, stage 9's verification means something: any difference found there is a real bug introduced by the restructure, not an expected consequence of a rewrite.

**Task 13: replace it.** Swapping the ported code for `empiricaldist.Surv` / `Hazard` and `lifelines.KaplanMeierFitter` is the actual goal, but it can change results at tied event times, so it happens separately with its own before/after comparison. See Task 13 on the board.

## Dispositions

### Notebooks

| Item | Disposition |
|---|---|
| `clean_nsfg`, `marriage_education`, `marriage_education_cps`, `fertility`, `intent`, `marriage_lifelines`, `agebaby_lifelines` | Convert to `notebooks/*.md`, maintained |
| `validate_sex_ratio` | Convert and keep — standalone, no local imports, Colab-portable |
| `marriage.ipynb`, `survival.ipynb`, `divorce.ipynb`, `ipums.ipynb` | Convert to `notebooks/archive/`, unmaintained. The `marriage` → `ipums` shelve handoff stays intact within the archive, so nothing breaks |
| `first.ipynb`, `validate1982data.ipynb`, `validate1988data.ipynb` | **nbformat v3** — run `nbformat.convert` to v4 before jupytext, then archive |
| `validate1995/2002/2010/2013data.ipynb` | **Delete.** They import `nsfg3`, which does not exist anywhere in the repo or on the system. Unrunnable since 2017 |
| `Untitled.ipynb` | Delete — 0 cells |

### Code

| Item | Disposition |
|---|---|
| `marriage.py` | Split into `nsfg/readers.py`, `clean.py`, `survival.py` |
| `utils.py` | Becomes `nsfg/plotting.py` |
| The six duplicate names | `underride`, `decorate`, `legend` are identical — keep one. `value_counts`, `resample_rows_weighted`, `percentile_rows` diverge — **compare them and choose deliberately**, because `intent` and `fertility` import both modules and currently get whichever import ran last |
| `thinkstats2.py`, `thinkplot.py`, `nsfg.py`, `survival.py` | `archive/` after the stage-6 port; deleted by Task 13 |
| `marriage_test.py` | Rewrite — it tests two functions that do not exist |
| `survival_test.py` | Port to the ported hazard code; it is the only test that currently passes |

### Data and artifacts

| Item | Disposition |
|---|---|
| All raw NSFG/CPS/IPUMS | `data/raw/`, gitignored, fetched by `scripts/download_nsfg.py` |
| `*.hdf`, `marriage_nsfg_*.csv.gz` | `data/interim/`, gitignored, regenerated by `clean_nsfg` |
| `sf_map.*`, `predictions.*` shelves | Gitignore — regenerable, and `predictions.*` is from Oct 2020 against an Apr 2025 HDF |
| `FemMarriageData.csv` | Delete — no writer, no reader, 7.6 MB |
| `FemMarriageData.txt` | Delete once Task 10 supersedes it — 885 bytes describing cycles 3–9 only |
| `marriage_nsfg_female.csv`, `marriage_nsfg_male.csv` | Delete — Sep 2024 orphans with an older schema than the `.csv.gz` that replaced them |
| `1973NSFGData.dat`, `1976NSFGData.dat` | Delete — **truncated**. Both are exactly 1,048,576 bytes; upstream they are 19,838,925 and 31,716,306. Nothing reads them |
| `cps_00011.dta.gz` (81 MB), `jun24pub.dat.gz` (10 MB), `1995PregData.dat` (8.9 MB) | Delete — no references anywhere |
| `1988FemRespData.dat.gz`, `1988PregData.dat.gz`, `2017_2019_FemPregData.dat.gz` | Delete — tracked but never read. `ReadFemResp1988` uses the `...DataLines` variant |
| `*.sas`, `*.do` setup files | Delete — no code opens any of them; only `.dct` is used |
| `figs/` | Delete — 20 stale files, output of the archived `marriage.ipynb` |
| `figs2019/` | Delete — empty |
| `.ipynb_checkpoints/` | Delete and gitignore — 6.5 MB, including two orphans whose parent notebooks no longer exist |
| Root `*.png` | Move to `figures/`; delete the six that duplicate `figures/marriage_education_cps0*.png` byte-for-byte |
| `environment.yml~` | Delete — a stray backup from ThinkBayes2, wrong project entirely |
| `.vscode/` | Gitignore |

## jupytext mechanics

Format: **`md:myst`**, for fidelity of cell metadata and tags.

```makefile
notebooks:                 # .md -> .ipynb
	jupytext --to ipynb notebooks/*.md

execute: notebooks         # run them in place
	jupyter nbconvert --execute --inplace notebooks/*.ipynb

format:
	jupytext --pipe black notebooks/*.md
	ruff format nsfg/

clean:
	rm -f notebooks/*.ipynb
	find . -type d -name __pycache__ -exec rm -rf {} +
```

Executed notebooks are **not** committed. `figures/*.png` and the `.md` write-ups in `figures/` are the published record.

### The round-trip gate

Before any `.ipynb` is deleted from git, prove the markdown reproduces it. Per notebook, not in aggregate:

1. `jupytext --to md:myst nb.ipynb` → `nb.md`
2. `jupytext --to ipynb nb.md` → `nb.roundtrip.ipynb`
3. Strip outputs from both, normalize with `nbformat`, and diff cell sources and metadata
4. Only after every notebook passes does the deletion commit land

This matters most for the three nbformat-v3 notebooks, which have to survive a v3 → v4 conversion first, and for any notebook using cell tags.

## Verification

**Baseline, captured at stage 1 on the current environment:**

```bash
python -c "
import pandas as pd
for f, k in [('FemMarriageData.hdf', 'FemMarriageData'),
             ('MaleMarriageData.hdf', 'MaleMarriageData')]:
    df = pd.read_hdf(f, k)
    print(f, df.shape, sorted(df.cycle.unique()))
    print(df.cycle.value_counts().sort_index().to_dict())
    print(pd.util.hash_pandas_object(df.fillna(-999)).sum())
"
mkdir -p /tmp/figures_baseline && cp -r figures/ *.png /tmp/figures_baseline/
```

Known values as of 2026-09-20, for reference:

| File | Shape | Cycles |
|---|---|---|
| `FemMarriageData.hdf` | (75769, 52) | 3–12; cycle 12 n = 5,586 |
| `MaleMarriageData.hdf` | (38769, 43) | 6–12; cycle 12 n = 4,371 |

**At stage 9, still on the old environment:** re-run `clean_nsfg`; confirm identical shapes, per-cycle counts and frame hash. Re-run each analysis notebook and compare figures against the baseline — comparing **pixel data**, not file bytes, since matplotlib embeds a creation timestamp.

Everything at this stage should match exactly. A difference is a bug in the restructure.

**After Task 2 and Task 13:** repeat, and triage every difference rather than accepting it. Two are expected: `marriage.py:424`'s chained `fillna` currently does nothing and a fixed version will fill, and lifelines may break ties differently from the old Kaplan-Meier estimator.

## Risks

| Risk | Mitigation |
|---|---|
| The force-push is irreversible | Mirror backup at stage 0 — and verify it restores before pushing, not after |
| LFS objects survive the rewrite on GitHub | The rewrite does not remove them; that needs a GitHub support request |
| jupytext loses cell metadata or tags | Per-notebook round-trip gate before any `.ipynb` leaves git |
| The reorg and the upgrade get confounded | Staged so each is verified on its own |
| Data is unrecoverable after the purge | Copy `data/` outside the repo at stage 0; Task 5 before anyone needs a clean fetch |
| Splitting `marriage.py` changes import-order semantics | The six duplicate names are resolved deliberately at stage 5, not left to import order |
