#!/usr/bin/env python3
"""Estimate age at first marriage by birth cohort, and cache the result.

This is the expensive, deterministic half of the analysis: bootstrap resampling
combined with imputation of the interval-censored dates. It is a script rather
than a notebook so that the statistical choices live somewhere importable,
testable and reviewable, and so the notebooks can plot without recomputing.

    python scripts/estimate_marriage.py                 # both sexes, cache
    python scripts/estimate_marriage.py --iterations 501
    python scripts/estimate_marriage.py --sex female

Writes one tidy table per sex to data/interim/, with columns:

    cohort, age, fraction, sd, low, high

`fraction` is the mean across bootstrap iterations, `sd` the spread, and
`low`/`high` the 5th and 95th percentiles. Each curve stops at the last age
where the spread is both anomalous for the cohort (`--sd-ratio`) and large
in absolute terms (`--sd-floor`); see nsfg.intervals for why both are needed.
"""

import argparse
import sys
import time

import numpy as np
import pandas as pd

from nsfg.intervals import add_bounds, bootstrap_curve
from nsfg.paths import interim

SEXES = {
    "female": ("FemMarriageData.parquet", "marriage_by_cohort_female.parquet"),
    "male": ("MaleMarriageData.parquet", "marriage_by_cohort_male.parquet"),
}


def estimate(sex, n_iter, sd_ratio, sd_floor, seed, min_cohort_n=200):
    source, target = SEXES[sex]
    path = interim(source)
    if not path.exists():
        sys.exit(f"{path} not found -- run `make data` first")

    df = add_bounds(pd.read_parquet(path)).dropna(subset=["t_lo", "t_hi"])
    rng = np.random.default_rng(seed)

    frames = []
    print(f"\n{sex}")
    for cohort in sorted(df.birth_index.dropna().unique()):
        group = df[df.birth_index == cohort]
        if len(group) < min_cohort_n:
            continue
        start = time.time()
        curve = bootstrap_curve(
            group, n_iter=n_iter, sd_ratio=sd_ratio, sd_floor=sd_floor, rng=rng
        )
        if not len(curve):
            print(f"  {1900 + int(cohort)}s  n={len(group):6d}  no stable range")
            continue
        curve = curve.reset_index()
        curve.insert(0, "cohort", 1900 + int(cohort))
        frames.append(curve)
        print(
            f"  {1900 + int(cohort)}s  n={len(group):6d}  "
            f"married={int(group.observed.sum()):6d}  "
            f"to age {curve.age.iloc[-1]:5.2f} = {curve.fraction.iloc[-1]:5.1f}% "
            f"[{curve.low.iloc[-1]:.1f}, {curve.high.iloc[-1]:.1f}]  "
            f"({time.time() - start:.1f}s)"
        )

    if not frames:
        sys.exit(f"no cohorts produced a stable estimate for {sex}")

    out = pd.concat(frames, ignore_index=True)
    dest = interim(target)
    out.to_parquet(dest, compression="zstd")
    print(f"  -> {dest.name}  ({len(out)} rows)")
    return out


def main():
    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        "--iterations",
        type=int,
        default=101,
        help="bootstrap iterations per cohort (default 101)",
    )
    parser.add_argument(
        "--sd-ratio",
        type=float,
        default=3.0,
        help="stop where the spread exceeds this multiple of the cohort median",
    )
    parser.add_argument(
        "--sd-floor",
        type=float,
        default=2.0,
        help="...and also exceeds this many percentage points",
    )
    parser.add_argument(
        "--seed",
        type=int,
        default=17,
        help="seed, so the published numbers are reproducible",
    )
    parser.add_argument(
        "--sex",
        choices=sorted(SEXES),
        action="append",
        help="restrict to one sex; repeatable",
    )
    args = parser.parse_args()

    for sex in args.sex or sorted(SEXES):
        estimate(sex, args.iterations, args.sd_ratio, args.sd_floor, args.seed)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
