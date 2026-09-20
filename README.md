# MarriageNSFG

Harmonized National Survey of Family Growth data across survey cycles 3 (1982) through 12 (2022–2023), and analyses of US marriage patterns.

## Layout

| Path | What it holds |
|---|---|
| `nsfg/` | The package: cycle readers, cleaning, survival estimation, plotting |
| `notebooks/` | Analyses, as jupytext markdown. `notebooks/archive/` is unmaintained |
| `data/raw/` | Source survey files — **not in the repo**, see below |
| `data/interim/` | Harmonized output of `clean_nsfg`, regenerated not committed |
| `figures/` | Published figures and their write-ups |
| `codebooks/` | NSFG codebooks as greppable text |
| `archive/` | Vendored Think Stats code, kept for reference only |
| `PROJECT_BOARD.md` | Numbered tasks and their status |

## The data is not in this repository

NSFG and IPUMS public-use files may not be redistributed, so `data/` is gitignored and was purged from this repo's history in September 2026.

```bash
python scripts/download_nsfg.py --i-accept-nchs-terms   # all ten cycles
python scripts/download_nsfg.py --check                 # what is present, offline
```

NCHS distributes these files under a data user agreement. Read and accept it before downloading. CPS and IPUMS extracts are user-specific and must be requested from those providers directly.

## Getting started

```bash
make env          # creates the environment with mamba
conda activate MarriageNSFG
make install      # pip install -e ".[dev]"
make data         # rebuild data/interim from data/raw
make execute      # run the notebooks
```

## Editing a notebook

The markdown under `notebooks/` is the source of truth; edit the `.md`, not the `.ipynb`. Both are committed: the `.md` gives readable diffs, and the `.ipynb` carries the executed outputs so the analyses render on GitHub. Since the data is not in the repo, those stored outputs are the only way a reader sees results.

```bash
make notebooks    # .md -> .ipynb
make execute      # run them in place, populating outputs
make markdown     # .ipynb -> .md, to capture edits made in Jupyter
```

Commit the `.md` and the `.ipynb` together, or the two will drift.

## The pipeline

`notebooks/clean_nsfg.md` is the hub. It calls one reader per cycle out of `nsfg.marriage`, harmonizes them, concatenates, and writes the files every other notebook reads:

```
data/raw/*.dat.gz + *.dct, *.sas7bdat
  -> nsfg.marriage  ReadFemResp1982..2023 / ReadMaleResp2002..2023
     -> notebooks/clean_nsfg.md
        -> data/interim/FemMarriageData.hdf
        -> data/interim/MaleMarriageData.hdf
```

Cycle numbers are NSFG's own: cycle 3 is 1982, cycle 12 is 2022–2023.

## License

Code under the MIT License (see `LICENSE`). The survey data is not covered by it and is not distributed here.
