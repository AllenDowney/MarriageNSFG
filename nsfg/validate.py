"""Checks that would have caught the bugs this project actually had.

Three layers:

* `check_counts` -- per-cycle row and marriage counts, the existing
  `marriage.validate_*` assertions generalized to a table so the male readers
  and the newest cycles are covered too.
* `check_reconstructed_age` -- a feasibility check on `cmbirth`. From cycle 10
  the PUF stopped shipping it and it is reconstructed from the integer age at
  interview, so the implied age must land in `[ager, ager + 1)`. This is the
  check that would have caught Task 14 in 2018, where a `+6` offset put births
  six months *after* the latest feasible date and made `agemarry` a year too low
  in the three most recent cycles.
* `check_cross_cycle` -- flags derived variables that jump at a cycle boundary
  by much more than the typical step. This is what would have settled Task 7 in
  seconds instead of an investigation: cycle 12's `bdegree` looked wrong because
  it moved 17 points, and the question was whether that was a recode error or a
  real change.

Run them all with `python -m nsfg.validate`, which needs the raw data. The
counts are also exercised by `tests/test_validate.py`, which does not.
"""

import warnings

import numpy as np
import pandas as pd

# year -> (cycle, n_rows, n_ever_married)
FEM_COUNTS = {
    1982: (3, 7969, 4651),
    1988: (4, 8450, 5290),
    1995: (5, 10847, 6841),
    2002: (6, 7643, 4126),
    2010: (7, 12279, 5534),
    2013: (8, 5601, 2452),
    2015: (9, 5699, 2401),
    2017: (10, 5554, 2582),
    2019: (11, 6141, 2722),
    2023: (12, 5586, 2562),
}

MALE_COUNTS = {
    2002: (6, 4928, 1752),
    2010: (7, 10403, 3733),
    2013: (8, 4815, 1684),
    2015: (9, 4506, 1611),
    2017: (10, 4540, 1770),
    2019: (11, 5206, 1961),
    2023: (12, 4371, 1624),
}

# cycles from 10 on reconstruct cmbirth from the integer age at interview
RECONSTRUCTED_FROM = 10


class ValidationError(AssertionError):
    """A validation check failed."""


def check_counts(df, year, expected):
    """Check row count and ever-married count for one cycle."""
    cycle, n_rows, n_married = expected[year]
    if len(df) != n_rows:
        raise ValidationError(f"{year}: {len(df)} rows, expected {n_rows}")
    got = int(df.evrmarry.sum())
    if got != n_married:
        raise ValidationError(f"{year}: {got} ever married, expected {n_married}")
    return cycle


def check_reconstructed_age(df, year, cycle):
    """`cmbirth` must imply an age consistent with the reported `ager`.

    For the cycles where `cmbirth` is reconstructed, `ager` is the raw integer
    age at interview, so the true birth date lies in the year *before*
    `cmintvw - ager * 12`. The implied exact age must therefore fall in
    `[ager, ager + 1)`, and a midpoint estimate should sit near `ager + 0.5`.
    """
    if cycle < RECONSTRUCTED_FROM:
        return None
    for col in ("cmbirth", "cmintvw", "ager"):
        if col not in df.columns:
            return None

    sub = df.dropna(subset=["cmbirth", "cmintvw", "ager"])
    implied = (sub.cmintvw - sub.cmbirth) / 12.0
    # The male readers overwrite `ager` with the implied fractional age, so it
    # arrives as int+0.5 there and as a raw integer on the female side. floor()
    # recovers the reported integer age under either convention; round() does
    # not, because banker's rounding sends 30.5 down and 31.5 up.
    offset = implied - np.floor(sub.ager)

    if offset.min() < 0 or offset.max() >= 1:
        raise ValidationError(
            f"{year}: reconstructed cmbirth implies an age outside "
            f"[ager, ager+1) -- offset runs {offset.min():+.3f} to "
            f"{offset.max():+.3f}. A negative offset means the birth date is "
            f"later than the reported age allows."
        )

    mean = float(offset.mean())
    # Feasible but biased: an offset of 0 puts every birth at the earliest
    # date the reported age allows, rather than the middle of the window.
    # That was the male readers' formula before Task 14, and it is half a year
    # low on average without ever being impossible.
    if abs(mean - 0.5) > 0.25:
        warnings.warn(
            f"{year}: reconstructed cmbirth is feasible but biased -- mean "
            f"offset {mean:+.3f}, expected near +0.5 for a midpoint estimate.",
            stacklevel=2,
        )
    return mean


def check_cross_cycle(
    df, columns=None, threshold=4.0, cycle_col="cycle", weight_col="finalwgt"
):
    """Flag derived variables that jump at a cycle boundary.

    Compares each step against the typical step over the other boundaries. A
    ratio above `threshold` means the variable moved far more between two
    adjacent cycles than it usually does, which is either a real event or a
    recoding change that was not harmonized.

    Returns a DataFrame of the flagged boundaries; empty means nothing stood out.
    """
    if columns is None:
        columns = [
            c
            for c in df.columns
            if df[c].dtype.kind in "bif" and c not in (cycle_col, weight_col, "caseid")
        ]

    cycles = sorted(df[cycle_col].dropna().unique())
    rows = []
    for col in columns:
        means = []
        for cy in cycles:
            g = df[df[cycle_col] == cy].dropna(subset=[col, weight_col])
            means.append(
                np.average(g[col], weights=g[weight_col]) if len(g) else np.nan
            )
        means = pd.Series(means, index=cycles, dtype=float)
        steps = means.diff().abs()
        typical = steps.median()
        if not np.isfinite(typical) or typical == 0:
            continue
        for cy, step in steps.items():
            if np.isfinite(step) and step / typical > threshold:
                rows.append(
                    {
                        "column": col,
                        "boundary": f"{cy - 1}->{cy}",
                        "step": step,
                        "typical": typical,
                        "ratio": step / typical,
                    }
                )
    out = pd.DataFrame(rows)
    return out.sort_values("ratio", ascending=False) if len(out) else out


def main():
    from nsfg import marriage

    print("Per-cycle counts and reconstructed-age feasibility\n")
    for label, counts, reader in (
        ("female", FEM_COUNTS, marriage.read_fem_resp),
        ("male", MALE_COUNTS, marriage.read_male_resp),
    ):
        print(f"  {label}")
        for year in sorted(counts):
            df = reader(year)
            cycle = check_counts(df, year, counts)
            offset = check_reconstructed_age(df, year, cycle)
            note = "" if offset is None else f"  age offset {offset:+.3f}"
            print(f"    {year} (cycle {cycle:2d})  ok{note}")

    from nsfg.paths import interim

    path = interim("FemMarriageData.parquet")
    if path.exists():
        print("\nCross-cycle continuity, female extract\n")
        flagged = check_cross_cycle(pd.read_parquet(path))
        if len(flagged):
            print(flagged.to_string(index=False, float_format="%.3f"))
        else:
            print("  nothing flagged")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
