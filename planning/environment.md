# Environment rebuild — design

Detail for **Task 2** on `PROJECT_BOARD.md`. Written 2026-09-20, before any of it has been executed.

## Why

Three files disagree about what this project needs, and the one the `Makefile` actually uses was never fully installed.

| File | Date | Status |
|---|---|---|
| `environment.yml` | 2020 | **Dead.** Names an env (`NSFG`) that does not exist on this machine. Omits `lifelines`, `pyreadstat`, `statadict` and `seaborn` — all of which the code imports. Bypassed entirely by the `Makefile` |
| `requirements.txt` | 2025 | Roughly correct |
| `requirements-dev.txt` | 2025 | `-r requirements.txt` plus `black`, `flake8`, `nbformat`, `nbmake`, `nb_black==1.0.5`, `pytest` |
| `environment.yml~` | — | A stray editor backup **from ThinkBayes2** — `name: ThinkBayes2`, includes `pymc3`. Wrong project entirely |

The `Makefile` creates a conda env named `MarriageNSFG` at Python 3.11 and pip-installs `requirements-dev.txt` into it. What actually exists is Python **3.10.14**, and `pytest`, `flake8`, `nbmake` and `nb_black` are all **absent** — so the dev install failed or was abandoned partway. `make tests` and `make lint` have not been runnable for some time. Both would fail anyway: they reference a `code/` directory and a `pyproject.toml`, neither of which exists.

## What is installed now

| Package | Version |
|---|---|
| python | 3.10.14 |
| pandas | 2.2.3 |
| numpy | 1.26.4 |
| scipy | 1.14.1 |
| matplotlib | 3.9.2 |
| seaborn | 0.13.2 |
| statsmodels | 0.14.3 |
| lifelines | 0.29.0 |
| pyreadstat | 1.2.8 |
| tables | 3.10.1 |
| statadict | 1.1.0 |
| empiricaldist | 0.7.5 |

Everything is `pypi_0` — pip-installed per the Makefile, not from conda. The whole set is pinned in time around September 2024.

**Keep this environment intact until Task 1 is verified.** It is the reference point for proving the reorganization did not change results. Build the new one alongside it, under a different name, and switch only after stage 9 of the reorg passes.

## Target

One `environment.yml`, named `MarriageNSFG` to match the Makefile and the env that already exists. `requirements.txt`, `requirements-dev.txt` and `environment.yml~` are deleted.

```yaml
name: MarriageNSFG

channels:
  - conda-forge

dependencies:
  - python=3.13
  - pandas
  - numpy
  - scipy
  - matplotlib
  - seaborn
  - statsmodels
  - pytables
  - lifelines
  - pyreadstat          # reads the 2022-2023 .sas7bdat
  - jupyterlab
  - pip
  - pip:
    - empiricaldist
    - statadict         # marriage.py:19, parse_stata_dict
```

Dev dependencies — `jupytext`, `nbconvert`, `pytest`, `black`, `ruff` — go in a `dev` extra in `pyproject.toml` rather than a second requirements file, so `pip install -e ".[dev]"` covers both the package and the tooling.

Derived from what the code actually imports, not from what the old files claim. `statadict` stays on pip; it is not on conda-forge.

## Dropping `nb_black`

`nb_black` is removed. It has been unmaintained since 2021, it is the only hard pin in the project (`nb_black==1.0.5`), and it is the most likely reason the dev install never completed — everything listed alongside it is missing from the env too.

It is also obsolete under the new arrangement. With markdown as the notebook source of truth, code cells are formatted without a Jupyter extension:

```bash
jupytext --pipe black notebooks/*.md
```

Similarly, `flake8` is replaced by `ruff`, which subsumes it and is faster. `make lint` and `make format` are rewritten to point at `nsfg/` and a real `pyproject.toml` instead of the nonexistent `code/`:

```makefile
lint:
	ruff check nsfg/ scripts/ tests/

format:
	ruff format nsfg/ scripts/ tests/
	jupytext --pipe black notebooks/*.md
```

## Dropping PyTables for parquet

`tables` was the single blocker on the Python version: it has **no PyPI wheel past 3.11**, for any recent release. conda-forge builds it through 3.15, so a conda environment would have worked, but it constrained any pip-based install.

It supported exactly two files — `FemMarriageData` and `MaleMarriageData`, both our own extracts. No raw data format needs it; those go through `read_fwf`, `read_sas7bdat`, `read_stata`, `read_csv` and `read_excel`.

Measured on the actual data:

| | HDF | parquet (zstd) |
|---|---|---|
| FemMarriageData | 29.7 MB | **2.0 MB** |
| MaleMarriageData | 28.7 MB | **1.1 MB** |
| read | 0.100 s | **0.028 s** |

Three further reasons beyond size and speed:

- PyTables **pickles** the `want_yes` column, warning on every write that it cannot map the dtype to a C type. Pickled objects inside HDF are Python-version-dependent, which is a poor property for a file regenerated rarely and kept for years.
- HDF5 does not reclaim space on rewrite, which is why `FemMarriageData.hdf` had grown to 153 MB on disk. Parquet replaces the file atomically, so the delete-before-write workaround added earlier is no longer needed.
- `pyarrow` ships pure wheels for every current Python.

Verified: regenerated both files as parquet and compared against the HDF versions — identical shapes, columns, dtypes and frame hashes.

## Python version

**3.13**, chosen from what is actually available rather than by default. Every dependency has a manylinux wheel at both 3.13 and 3.14 — pandas 3.0.6, numpy 2.5.3, scipy 1.18.1, matplotlib 3.11.2, statsmodels 0.15.0, pyarrow 25.0.1, pyreadstat 1.3.6 — and lifelines, statadict and empiricaldist are pure Python. 3.14 would also work; 3.13 is the conservative pick of the two.

Note the jump this represents from the current environment: pandas 2.2.3 → 3.0.x and numpy 1.26.4 → 2.5.x. Both are major-version changes, which is what the "Expected breakage" section below is about.

## Outcome, 2026-09-20

The upgrade is clean. Regenerating the full pipeline under Python 3.13.15 / pandas 3.0.6 / numpy 2.5.3 produced output **identical** to Python 3.10.14 / pandas 2.2.3 / numpy 1.26.4 — same shapes, same columns, same frame hashes for both extracts. `clean_nsfg` ran all 281 cells with no errors, and lifelines returns identical Kaplan-Meier curves with no warnings.

The "expected breakage" below was overstated on one point: `marriage.py:425` is **dead code**, called only from two commented-out lines, so Copy-on-Write never had anything to change. See the correction under Task 9.

### Getting pandas 3 requires overriding lifelines

conda-forge installs pandas 3.0.6, and then the `pip:` section silently downgrades it: `lifelines` 0.30.3 — the latest release — pins `pandas<3.0,>=2.1`. `conda list` still reports 3.0.6 while `site-packages` holds 2.3.3.

Tested with `pip install --no-deps pandas==3.0.6`: lifelines works, and produces identical survival curves. The pin appears precautionary rather than a known incompatibility. Adopting pandas 3 means overriding it deliberately and saying so in `environment.yml`, so it does not later look like an accident.

## Expected breakage

Two known issues will surface on the upgrade. Both are already identified, and one is a fix rather than a regression.

| Location | Pattern | What happens |
|---|---|---|
| `nsfg.py:71` | `.iteritems()` | Removed in pandas 2.0 — **already broken** on the installed version. Leaves with the archive in Task 1 |
| `marriage.py:424` | `group[colname].fillna(fill, inplace=True)` | Chained assignment. Under Copy-on-Write it succeeds and fills nothing. **On the live path** |
| `nsfg.py:45–50`, `survival.py:569,665` | Same chained `inplace` pattern | Legacy only |
| `survival.py:307` | `pd.Series(index=ts)` with no `dtype` | Deprecated |

`marriage.py:424` deserves attention. It is on the path every current run takes, it does not raise, and a corrected version **is expected to change results** — because the current one is silently doing nothing. Survival curves computed with a working `fillna` may differ from every figure published to date. That is a correction, but it needs to be seen and understood rather than absorbed into a larger diff, which is why Task 9 handles it explicitly.

Run the first upgraded test pass with `-W error::FutureWarning` so the next one of these surfaces before it becomes a silent no-op.

## Use mamba, not conda

`mamba` (2.5.0) is installed and is the tool for this project going forward. The conda solver was still working on this environment after several minutes; mamba resolves it in a fraction of that. `make env` and `make env-update` both use it, via a `CONDA = mamba` variable at the top of the Makefile so it can be overridden if needed.

```bash
make env          # mamba env create -f environment.yml
make env-update   # mamba env update -f environment.yml --prune
```

## Order

1. **Do not touch the current env** until Task 1 stage 9 passes on it.
2. Build the new env under a temporary name; resolve install failures.
3. Run the baseline comparison from `repo_reorganization.md` on the new env.
4. Triage every difference. Expect `marriage.py:424`; investigate anything else.
5. Rename or switch over; delete the old env.
6. Task 13 (`empiricaldist`) comes after this, as its own verified step.

## Scope

- [ ] Write the new `environment.yml` and `pyproject.toml` with a `dev` extra
- [ ] Delete `requirements.txt`, `requirements-dev.txt`, `environment.yml~`
- [ ] Confirm `pyreadstat` and `tables` wheels exist for the chosen Python
- [ ] Rewrite `make lint`, `make format`, `make tests`, `make create_environment`
- [ ] Build alongside the current env; do not replace it yet
- [ ] Re-run the baseline; triage every difference
- [ ] Fix `marriage.py:424` and record the before/after explicitly (Task 9)
