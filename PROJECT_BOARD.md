# MarriageNSFG Project Board

Numbered tasks for tracking work. Each task has a permanent number; add new tasks at the end. Update status as work progresses.

### Current focus (2026-09-20)

The 2022–2023 NSFG cycle (cycle 12) has been downloaded and the ETL already runs on it — both HDF files in the working tree contain cycle 12. What remains is to refresh the downstream analysis, and to get the repo into a state where the next cycle is straightforward.

- **Task 1:** Reorganize the repo — not started. Design in `planning/repo_reorganization.md`.
- **Task 2:** Rebuild the conda environment — not started. Design in `planning/environment.md`.
- **Task 3:** Commit 17 months of pending work — not started. **Do this first.**
- **Task 4:** Remove NSFG/IPUMS data from the repo and its history — not started.
- **Task 5:** Write the data download script — not started.
- **Task 6:** Update the analysis for cycle 12 — not started; blocked on Task 7.
- **Task 7:** Cycle 12's education recode is wrong — **confirmed**, not started.
- **Task 8:** PEP-8 rename — not started.
- **Task 9:** Fix the pandas landmines — not started.
- **Task 10:** Consolidated codebook metadata — not started.
- **Task 11:** Validation coverage — not started.
- **Task 12:** Write `CLAUDE.md` — not started.
- **Task 13:** Excise `thinkstats2` in favor of `empiricaldist` — not started.

**Three things are urgent and cheap.** `fertility.ipynb` has never been committed and exists only on this machine (Task 3). `.gitattributes` has never been committed, so the repo is unusable from a fresh clone (Task 4). And cycle 12's `bdegree` is wrong by roughly 17 percentage points, which affects the analysis this update is for (Task 7).

### How this repo fits together

`clean_nsfg.ipynb` is the hub. It calls one reader per cycle out of `marriage.py`, harmonizes them, concatenates, and writes the files every other notebook reads:

```
raw NSFG (.dat.gz + .dct, .sas7bdat)
  -> marriage.py  ReadFemResp1982..2023 / ReadMaleResp2002..2023
     -> clean_nsfg.ipynb   (concat cycles 3..12)
        -> FemMarriageData.hdf    read by 9 notebooks
        -> MaleMarriageData.hdf   read by 6 notebooks
        -> marriage_nsfg_{female,male}.csv.gz   (nothing in-repo reads these)

marriage.ipynb -> shelve sf_map -> ipums.ipynb     (only cross-notebook handoff)
```

Cycle numbers are NSFG's own: cycle 3 is 1982, cycle 12 is 2022–2023.

There are effectively **two codebases** here. The modern one — `utils.py` plus `marriage_education*`, `fertility`, `intent`, `*_lifelines` — uses `lifelines`, `empiricaldist` and `seaborn`. The legacy one — `marriage.ipynb`, `survival.ipynb`, `divorce.ipynb`, `first.ipynb` — uses the vendored 2015 Think Stats modules (`thinkstats2.py`, `thinkplot.py`, `survival.py`, `nsfg.py`). They are joined at exactly one point: `marriage.py:317` calls `survival.EstimateHazardFunction`, and that single line is what keeps all four legacy modules loaded on every current run.

`marriage.py` and `utils.py` both define `underride`, `decorate`, `legend`, `value_counts`, `resample_rows_weighted` and `percentile_rows`. The first three are identical; the last three are not. `intent.ipynb` and `fertility.ipynb` import both modules, so import order decides which definition wins.

### Traps

- Every reader in `marriage.py` uses a **bare relative filename** and assumes the CWD is the repo root.
- `.gitattributes` is **untracked**. Clones get 130-byte LFS pointers, not data.
- `make lint` and `make format` reference a `code/` directory and a `pyproject.toml`; neither exists. `make tests` needs `pytest` and `nbmake`, which are not installed.
- `marriage_test.py` tests two functions that do not exist in `marriage.py`.
- `validate1995/2002/2010/2013data.ipynb` import `nsfg3`, which does not exist anywhere. They have been unrunnable since 2017.
- `first.ipynb`, `validate1982data.ipynb` and `validate1988data.ipynb` are **nbformat v3** — their cells live under `worksheets[0]`, not a top-level `cells` key, so naive notebook tooling silently fails on them.

### Editing a notebook

Not yet in force — this is the arrangement Task 1 establishes. After Task 1, `notebooks/*.md` is the tracked source of truth and `.ipynb` is a generated artifact:

```bash
make notebooks   # jupytext: notebooks/*.md -> .ipynb
make execute     # jupyter nbconvert --execute --inplace
make clean       # remove the generated .ipynb
```

Edit the `.md`, never the `.ipynb`. Format code cells with `jupytext --pipe black notebooks/*.md`. Executed notebooks are not committed; `figures/*.png` and the `.md` write-ups in `figures/` are the published record.

---

## Task 1: Reorganize the repo

**Status:** Not started. Full design in `planning/repo_reorganization.md`.

**Context:** ~150 files in a flat root. `git status` reports 13 modified and 78 untracked paths, which makes it useless as a signal — a real change is invisible in the noise. Raw survey data, derived products, 49 loose figures, 2015-era vendored library code and active analysis all sit side by side.

The target layout separates them: `nsfg/` (an installable package), `notebooks/` (markdown source), `data/{raw,interim}/` (gitignored), `figures/`, `scripts/`, `planning/`, `tests/`.

**The one sequencing rule that matters:** do not restructure the repo and rebuild the environment at the same time. If both change at once and a figure shifts, there is no way to tell which caused it. The reorg is verified under the *current* environment first; the upgrade is a separate, separately-verified step.

### Scope

- [ ] Back up: `git clone --mirror`, and copy the data outside the repo
- [ ] Snapshot the verification baseline (HDF shapes, frame hashes, current figures)
- [ ] Create `nsfg/` with `paths.py` anchored to the package, not the CWD
- [ ] Split `marriage.py` into `readers.py`, `clean.py`, `survival.py`; `utils.py` becomes `plotting.py`
- [ ] Resolve the six duplicate definitions between `marriage.py` and `utils.py`
- [ ] Port `EstimateHazardFunction` verbatim; archive the four legacy modules
- [ ] Convert notebooks to markdown with jupytext, with a per-notebook round-trip gate
- [ ] Delete the dead weight (see the disposition table in the planning doc)
- [ ] Verify against the baseline, still on the old environment

---

## Task 2: Rebuild the conda environment

**Status:** Not started. Full design in `planning/environment.md`.

**Context:** Three files disagree about what this project needs. `environment.yml` is from 2020, names an env (`NSFG`) that does not exist on this machine, and omits `lifelines`, `pyreadstat`, `statadict` and `seaborn` — all of which the code imports. `requirements.txt` is from 2025 and is roughly right. The `Makefile` bypasses `environment.yml` entirely and pip-installs `requirements-dev.txt` into a conda env called `MarriageNSFG`.

That install evidently never completed: `pytest`, `flake8`, `nbmake` and `nb_black` are all absent from the env, most likely because of the hard pin `nb_black==1.0.5`, which has been unmaintained since 2021. So `make tests` and `make lint` have not been runnable for some time.

The current env is Python 3.10.14 with pandas 2.2.3 and numpy 1.26.4 — pinned in time around September 2024.

### Scope

- [ ] One `environment.yml`, named `MarriageNSFG`, current Python
- [ ] Delete `requirements.txt`, `requirements-dev.txt`, `environment.yml~` (a stray backup from ThinkBayes2)
- [ ] Drop `nb_black`; format via `jupytext --pipe black` instead
- [ ] Replace `flake8` with `ruff`; add a real `pyproject.toml`
- [ ] Fix `make lint` / `make format` to point at `nsfg/`
- [ ] Re-verify against the baseline and triage every difference

---

## Task 3: Commit the 17 months of pending work

**Status:** Not started. **Do this before anything else.**

**Context:** The last commit is `62df0b8`, 2025-04-29. Since then 13 tracked files have been modified — including `clean_nsfg.ipynb`, `marriage.py` and `utils.py` — and none of it is committed.

Worse, `fertility.ipynb` has **never been committed at all**. It is 1.8 MB of active analysis that produces 11 published figures, and it exists only on this machine. So does `.gitattributes`, and so do both 2022–2023 `.sas7bdat` files and the entire CPS line of work.

This is a separate task from the reorg because it is pure risk reduction and takes minutes. The commits made here will be rewritten by Task 4's history purge, but the *content* survives — that is the point.

### Scope

- [ ] Commit `fertility.ipynb`
- [ ] Commit the 13 modified files
- [ ] Commit `.gitattributes` (it is deleted again in Task 4, but commit it now so nothing depends on an untracked file)
- [ ] Note: `FemMarriageData.csv` is currently a plain blob and is modified; committing it converts it to LFS silently. Harmless, since Task 4 purges it

---

## Task 4: Remove NSFG/IPUMS data from the repo and its history

**Status:** Not started.

**Context:** Two separate problems, both rooted in the same file.

**The data should not be published.** NSFG public-use files may not be redistributed. 28 files are currently tracked in git-LFS and have already been pushed to `github.com/AllenDowney/MarriageNSFG` — every cycle from 1982 through 2017–2019, plus `usa_00002.csv.gz`, which is IPUMS and carries its own restriction. Removing them going forward is not enough; they are in every historical commit.

**The repo is unusable from a fresh clone.** `.gitattributes` declares `*.hdf`, `*.csv`, `*.gz` as LFS, but it has never been committed — `git log --all -- .gitattributes` is empty. The pointers on GitHub are correct; a cloner just has no filter configuration to resolve them with. `git show HEAD:FemMarriageData.hdf` returns:

```text
version https://git-lfs.github.com/spec/v1
oid sha256:d9f16e4d4e38d7c0a5b39b9fe7e555b93663468c3942464bf19b6e63ba3e5889
size 110761660
```

That is what a clone gets, named `FemMarriageData.hdf`, and every notebook fails on it.

Once no data is tracked, **LFS has no remaining purpose** and `.gitattributes` can go entirely. That is also what takes `.git` from 486 MB down to something reasonable.

### Scope

- [ ] Verify the mirror backup from Task 1 restores before touching anything
- [ ] `git filter-repo --invert-paths` over `*.dat.gz`, `*.csv.gz`, `*.sas7bdat`, `*.dta.gz`, `*.hdf`, `*.dat`
- [ ] Re-add `origin` — filter-repo removes it by design
- [ ] Force-push
- [ ] Delete `.gitattributes`; drop LFS
- [ ] Write a real `.gitignore`: `data/`, `*.hdf`, generated `*.ipynb`, `.ipynb_checkpoints/`, `__pycache__/`, `.vscode/`, shelve files
- [ ] Request that GitHub purge the orphaned LFS objects — **the rewrite alone does not remove them from the remote**

### Out of scope

- Deciding whether the harmonized extracts (`marriage_nsfg_*.csv.gz`) could be published separately under their own terms. For now they are treated as data and gitignored.

---

## Task 5: Write the data download script

**Status:** Not started.

**Context:** Once Task 4 lands, a clone has code and no data. `scripts/download_nsfg.py` closes that gap. Every file the readers need is available upstream at a stable path, with filenames matching exactly what the code expects:

| Cycle | Location |
|---|---|
| 2022–2023 | `ftp.cdc.gov/pub/Health_Statistics/NCHS/NSFG/NSFG-2022-2023-{FemResp,MaleResp}PUFData.sas7bdat` |
| 1973–2019 | `ftp.cdc.gov/pub/Health_Statistics/NCHS/Datasets/NSFG/*.dat` |
| Stata dictionaries | `.../Datasets/NSFG/stata/*.dct` |

Verified: a `HEAD` on the 2022–2023 female file returns `content-length: 86384640`, exactly the on-disk size.

**Two wrinkles.** CDC serves **uncompressed** `.dat`, while the readers expect `.dat.gz` — the script must compress after fetching. And NCHS gates the download *pages* behind a Data User's Agreement click-through, though the FTP paths themselves serve without one. The script should therefore state the terms and refuse to run without `--i-accept-nchs-terms`, rather than quietly fetching around a consent gate.

CPS and IPUMS extracts (`cps_00012.dta.gz`, `usa_00002.csv.gz`, `jun24pub.csv`) are **not** scriptable — IPUMS extracts are user-specific and built on request. Document how to recreate them instead.

### Scope

- [ ] Terms notice plus a required `--i-accept-nchs-terms` flag
- [ ] Per-cycle download, gzip, and sha256 verification
- [ ] `--cycle` to fetch one cycle; default to all
- [ ] Document the IPUMS/CPS extract definitions so they can be rebuilt by hand
- [ ] Do **not** re-fetch `1973NSFGData.dat` / `1976NSFGData.dat` unless they are wanted — see Task 1's disposition table

---

## Task 6: Update the analysis for the 2022–2023 cycle

**Status:** Not started. Blocked on Task 7.

**Context:** This is the original motivation, and **most of it is already done**. The ETL already handles cycle 12 — `ReadFemResp2023` and `ReadMaleResp2023` exist, `clean_nsfg.ipynb` calls both, and both HDFs in the working tree already contain cycle 12:

| File | Shape | Cycle 12 n |
|---|---|---|
| `FemMarriageData.hdf` | (75769, 52) | 5,586 |
| `MaleMarriageData.hdf` | (38769, 43) | 4,371 |

What remains is downstream: re-run the analysis notebooks, refresh the figures, and update the write-ups. But `bdegree` and `anycoll` are wrong for cycle 12 (Task 7), and those are exactly the variables the education analysis turns on — so Task 7 comes first or the figures get published wrong.

### Scope

- [ ] Fix Task 7 first
- [ ] Re-run `marriage_education`, `marriage_education_cps`, `fertility`, `intent`, `marriage_lifelines`, `agebaby_lifelines`
- [ ] Refresh `figures/*.png` and the `.md` write-ups
- [ ] Check the cycle-11 → cycle-12 boundary on every derived variable, not just `hieduc` — the same class of error could be hiding elsewhere

---

## Task 7: Cycle 12's education recode is wrong

**Status:** Confirmed 2026-09-20, not started. **Blocks Task 6.**

**Context:** Cycles 5–11 compute `bdegree` and `anycoll` on the **raw** `hieduc` scale and then remap it:

```python
df["bdegree"] = (df["hieduc"] >= 12).where(df["hieduc"].notna())
df["anycoll"] = df["hieduc"] >= 10
df["hieduc"]  = df["hieduc"].replace(range(5, 16), [1,1,1,2,4,5,7,8,9,11,10])
```

Cycle 12 (`marriage.py:1228`) uses different cutoffs and no remap:

```python
df["bdegree"] = (df["hieduc"] >= 8).where(df["hieduc"].notna())
df["anycoll"] = df["hieduc"] >= 5
```

At first glance these agree — raw 12 maps to 8, raw 10 maps to 5. But the remap collapses 5, 6 and 7 all to 1, so cycles 5–11 end up on a **sparse 9-value** subset `{1,2,4,5,7,8,9,10,11}`, while cycle 12 uses a **dense 11-value** 1–11 scale. Same cutoff number, different underlying coding.

The distributions settle it. Cycle 11 has **zero** mass at `hieduc` 3 and 6 — values the remap cannot produce — while cycle 12 has 2.7% and 6.3%:

| `hieduc` | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| cycle 11 | .185 | .005 | — | .263 | .200 | — | .083 | .175 | .072 | .010 | .007 |
| cycle 12 | .112 | .030 | .027 | .144 | .171 | .063 | .050 | .227 | .135 | .024 | .016 |

Downstream, among women aged 25–45, `bdegree` jumps **0.334 → 0.503** and `anycoll` jumps **0.636 → 0.788** between cycles 11 and 12. Those are 17- and 15-point discontinuities in a single cycle, which is not plausible as real change.

**What is not yet known:** the correct mapping. That needs the 2022–2023 codebook entry for `hieduc`, which has not been read. Do not guess a threshold.

### Scope

- [ ] Read the 2022–2023 codebook entry for `hieduc`
- [ ] Establish the correct mapping from the cycle-12 coding onto the cycles 5–11 scale
- [ ] Apply the remap in `ReadFemResp2023` and `ReadMaleResp2023`
- [ ] Confirm the cycle-11 → cycle-12 discontinuity disappears
- [ ] Add a cross-cycle continuity check to the validation suite (Task 11) so this class of error is caught next time

---

## Task 8: PEP-8 rename

**Status:** Not started.

**Context:** `marriage.py` uses CamelCase throughout (`ReadFemResp1982`, `EstimateSurvivalByCohort`, `Validate2017`). `utils.py` is already fully snake_case, as is every notebook that uses only `utils`.

The rename looks large and is not. There are 184 CamelCase functions in the repo, but 145 of them are in the four legacy Think Stats modules, which Task 1 archives. What is left:

| Scope | Count |
|---|---|
| Functions in `marriage.py` | 39 |
| Internal call sites in `marriage.py` | ~51 |
| Call sites in `clean_nsfg` | 23 |
| Call sites in every other current notebook | **0** |

**Sequence it after Task 1**, for two reasons: archiving the legacy stack removes 145 functions from scope, and the jupytext conversion means the 23 call sites are edited as markdown text rather than notebook JSON.

Then add a dispatch wrapper, so `clean_nsfg` becomes a loop instead of 17 hand-written calls:

```python
CYCLES = {1982: 3, 1988: 4, 1995: 5, 2002: 6, 2010: 7,
          2013: 8, 2015: 9, 2017: 10, 2019: 11, 2023: 12}

def read_fem_resp(year):
    return _FEM_READERS[year]()
```

### Scope

- [ ] Rename the 39 functions one-for-one
- [ ] Update the internal call sites
- [ ] Update the 23 call sites in `clean_nsfg.md`
- [ ] Add `read_fem_resp(year)` / `read_male_resp(year)` and the `CYCLES` registry
- [ ] Rewrite `clean_nsfg` as a loop over cycles
- [ ] Verify the output is unchanged — this task must not move a number

---

## Task 9: Fix the pandas landmines

**Status:** Not started.

**Context:** The live code carries patterns that modern pandas has removed or made into silent no-ops. The dangerous ones do not raise:

| Location | Pattern | Consequence |
|---|---|---|
| `marriage.py:424` | `group[colname].fillna(fill, inplace=True)` | **Live path.** Chained assignment — under Copy-on-Write it succeeds and fills nothing, silently changing survival results |
| `nsfg.py:45–50` | `df.col.replace(..., inplace=True)` ×5 | Same, in legacy code |
| `survival.py:569,665` | Same | Same |
| `nsfg.py:71` | `.iteritems()` | Removed in pandas 2.0 — **already broken** on the installed version |
| `survival.py:307` | `pd.Series(index=ts)` with no `dtype` | Deprecated |

`marriage.py:424` is the one that matters. It is on the path every current run takes, it will not error, and a corrected version is *expected to change results* — because the current one is not doing its job. That is a fix, not a regression, but it needs to be verified deliberately rather than absorbed into a larger diff.

### Scope

- [ ] Fix `marriage.py:424` and verify the before/after difference explicitly
- [ ] Fix the legacy sites if those modules survive Task 1; otherwise they leave with the archive
- [ ] Add `-W error::FutureWarning` to the test run so the next one of these surfaces early

---

## Task 10: Consolidated codebook metadata

**Status:** Not started.

**Context:** The harmonization logic in `marriage.py` encodes a great deal of per-cycle knowledge — which variable holds education in which cycle, which sentinel values mean "refused", which cycles dropped `cmbirth` and need it reconstructed — and it is all implicit in the reader functions. `FemMarriageData.txt` was an attempt at documenting it, but it is 885 bytes, describes cycles 3–9 only, and predates most of the current columns.

Task 7 is a direct consequence: a coding change between cycles was invisible because nothing compares codings across cycles.

The goal is one harmonized variable table — for each output column, which source variable it comes from in each cycle, what the value coding is, and what recoding is applied.

### Scope

- [ ] Read the per-cycle codebooks for the variables actually used
- [ ] Build one machine-readable variable table (CSV or YAML in `nsfg/`)
- [ ] Cross-check it against what the readers actually do — discrepancies here are bugs
- [ ] Delete `FemMarriageData.txt` once it is superseded
- [ ] Consider driving the readers from the table rather than hand-coding each one

---

## Task 11: Validation coverage

**Status:** Not started.

**Context:** There are three layers of testing and all three have holes.

`marriage.py` has `Validate1982` through `Validate2019` driven by `main()` — real assertions against known row counts and value distributions. But `main()` only exercises cycles 3–10. **There is no `Validate2023`**, none for 2019, and **none for any male reader** — so 9 of the 17 readers have no validation at all, including both readers for the new cycle.

`marriage_test.py` calls `marriage.MakeSurvivalFunction` and `marriage.EstimateHazardFunction`. Neither exists. Both tests raise `AttributeError`.

`survival_test.py` is the only test that would pass, and it tests the legacy module.

`make tests` runs `pytest --nbmake *.ipynb`, which would execute every notebook including the four that import the nonexistent `nsfg3`.

### Scope

- [ ] Write `Validate2023` for both female and male
- [ ] Write validators for the male readers
- [ ] Rewrite `marriage_test.py` against the real API
- [ ] Add a cross-cycle continuity check (from Task 7) that flags discontinuities in derived variables at cycle boundaries
- [ ] Fix `make tests` to run the unit tests, and the notebooks only when data is present

---

## Task 12: Write `CLAUDE.md`

**Status:** Not started.

**Context:** The traps in this repo are not guessable, and the "Traps" section at the top of this board is the raw material. A future session needs to know that readers assume the CWD is the repo root, that four notebooks import a module that does not exist, that three notebooks are nbformat v3, that `marriage.py` and `utils.py` collide on six names, and that the markdown is the source of truth and the `.ipynb` is generated.

Write this **after** Task 1, so it documents the layout that exists rather than the one being replaced.

### Scope

- [ ] Layout and where things belong
- [ ] The jupytext round-trip, and the rule that `.ipynb` is never edited
- [ ] The data situation: not in the repo, not redistributable, fetched by script
- [ ] Cycle numbering (3 = 1982 … 12 = 2022–2023)
- [ ] The verification ritual: baseline, change, compare

---

## Task 13: Excise `thinkstats2` in favor of `empiricaldist`

**Status:** Not started. Do after Tasks 1 and 2.

**Context:** Task 1 archives the four vendored Think Stats modules but ports `EstimateHazardFunction`, `HazardFunction` and `SurvivalFunction` into `nsfg/survival.py` **verbatim** — about 150 lines, minus the `MakeCdf`/`MakePmf`/`RemainingLifetime` methods, which are the only part that actually needs `thinkstats2`. That port is deliberately mechanical so it cannot change a number, which is what makes Task 1's verification meaningful.

This task replaces that ported code with the modern equivalents, all of which are already dependencies and already used by the other half of this codebase:

| Ported Think Stats | Replacement |
|---|---|
| `SurvivalFunction` | `empiricaldist.Surv` — `make_hazard()`, `make_cdf()`, `make_pmf()` |
| `HazardFunction` | `empiricaldist.Hazard` — `make_surv()` |
| `EstimateHazardFunction(complete, ongoing)` | `lifelines.KaplanMeierFitter`, as `utils.make_kmf_map` already does |
| `Hist`, `Pmf`, `Cdf` | `empiricaldist.Hist`, `Pmf`, `Cdf` |

**This is separate because it can change results.** The old estimator computes `lams[t] = ended / at_risk` with its own tie handling; lifelines may differ at tied event times. Folded into the reorg, it would make "did the reorganization change anything?" unanswerable. Done on its own, any difference is attributable and can be judged on its merits.

The payoff beyond deleting 116 KB of vendored 2015 code: the modern notebooks already use lifelines, so this puts the whole repo on one estimator instead of two.

### Scope

- [ ] Replace `EstimateSurvival` with a lifelines implementation returning `empiricaldist.Surv`
- [ ] Update `EstimateSurvivalByCohort` and `MakePredictions` to match
- [ ] Port `survival_test.py` to the new API
- [ ] Compare survival curves before and after; account for every difference at tied event times
- [ ] Delete `archive/thinkstats2.py`, `thinkplot.py`, `survival.py`, `nsfg.py`
