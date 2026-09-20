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

## Python version

Python 3.13 is the default choice. Every dependency supports it, and `pyreadstat` — historically the one most likely to lag, since it ships compiled extensions — publishes wheels for it.

Two things to confirm at build time rather than assume: that `pyreadstat` and `tables` both have wheels for the chosen version on this platform, and that `lifelines` is current against the installed pandas. If either is a problem, 3.12 is the fallback; nothing in this project needs a 3.13 feature.

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
