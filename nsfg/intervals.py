"""Honest bounds on age at first marriage, and estimators that respect them.

From cycle 10 (2015-2017) the public-use files stopped publishing century-month
birth and marriage dates. What remains is the *year* of first marriage
(`mardat01`) and the *integer* age at interview (`ager`). The readers turn those
back into century months by taking midpoints -- `cmbirth = cmintvw - ager*12 - 6`
and `cmmarrhx = (mardat01 - 1900)*12 + 6`.

Those midpoints are the right point estimate, but treating the result as an
exactly observed time is wrong in two ways:

1. It invents precision. Age at marriage is known only to within about two
   years, because both endpoints are year-resolution.
2. It creates ties. Every censored respondent in a cycle lands on one of a dozen
   integer ages, so the risk set drops in large blocks and the Kaplan-Meier tail
   moves in visible steps.

This module computes what is actually known -- an interval for each respondent --
and offers two estimators that use it:

* `impute_times` draws a time uniformly within each interval. Repeated, this is
  multiple imputation: the discretization uncertainty ends up in the spread
  across replicates instead of being hidden by a midpoint.
* `turnbull` calls the interval-censored NPMLE (Turnbull's estimator), which is
  the textbook answer for data of this shape and needs no imputation at all.

Cycles 3-9 carry real century months, so their intervals are one month wide and
both estimators reduce to the ordinary Kaplan-Meier result.
"""

import numpy as np
import pandas as pd

# from this cycle on, birth and marriage dates are year-resolution
COARSE_FROM_CYCLE = 10

# a month, in years -- the resolution of the cycles that still have century months
MONTH = 1.0 / 12.0


def add_bounds(df, cycle_col="cycle"):
    """Add [lo, hi) bounds on the survival time for each respondent.

    For the married, the time of interest is age at first marriage. For everyone
    else it is age at interview, at which point they are right-censored.

    Adds three columns:
      `t_lo`, `t_hi` -- bounds on the time, in years
      `observed`     -- whether the marriage was observed

    returns: a copy of df
    """
    out = df.copy()
    married = out.evrmarry.astype(bool)
    coarse = out[cycle_col] >= COARSE_FROM_CYCLE

    # --- age at interview ------------------------------------------------
    # coarse cycles report an integer age, so the true age is somewhere in
    # [ager, ager + 1). Finer cycles carry century months, so it is known to
    # the month.
    age_lo = np.where(coarse, np.floor(out.ager), out.ager - MONTH / 2)
    age_hi = np.where(coarse, np.floor(out.ager) + 1.0, out.ager + MONTH / 2)

    # --- age at first marriage -------------------------------------------
    # birth is in [cmintvw - (ager+1)*12, cmintvw - ager*12)
    # marriage is in [(mardat01-1900)*12, (mardat01-1900)*12 + 12)
    # so the difference spans almost two years
    birth_lo = out.cmintvw - (np.floor(out.ager) + 1) * 12
    birth_hi = out.cmintvw - np.floor(out.ager) * 12
    mar_lo = (out.mardat01 - 1900) * 12
    mar_hi = mar_lo + 12

    coarse_marry_lo = (mar_lo - birth_hi) / 12.0
    coarse_marry_hi = (mar_hi - birth_lo) / 12.0

    marry_lo = np.where(coarse, coarse_marry_lo, out.agemarry - MONTH / 2)
    marry_hi = np.where(coarse, coarse_marry_hi, out.agemarry + MONTH / 2)

    out["t_lo"] = np.where(married, marry_lo, age_lo)
    out["t_hi"] = np.where(married, marry_hi, age_hi)
    out["observed"] = married

    # a marriage cannot precede birth, and cannot follow the interview
    out["t_lo"] = out.t_lo.clip(lower=0)
    return out


def impute_times(df, rng):
    """Draw one time uniformly inside each respondent's interval.

    Married respondents get a draw from [t_lo, t_hi); censored respondents get a
    draw from their age interval. This replaces the midpoint convention with a
    draw, so repeated calls spread the discretization uncertainty rather than
    concealing it.

    returns: Series of times
    """
    lo = df.t_lo.to_numpy(dtype=float)
    hi = df.t_hi.to_numpy(dtype=float)
    width = np.where(np.isfinite(hi - lo), hi - lo, 0.0)
    return pd.Series(lo + rng.random(len(df)) * width, index=df.index)


def turnbull(df, timeline=None):
    """Interval-censored NPMLE (Turnbull) for one group.

    Right-censored respondents are represented with an infinite upper bound,
    which is how lifelines encodes them for this fitter.

    returns: Series of the fraction married, indexed by age
    """
    from lifelines import KaplanMeierFitter

    lo = df.t_lo.to_numpy(dtype=float)
    hi = np.where(df.observed.to_numpy(), df.t_hi.to_numpy(dtype=float), np.inf)

    kmf = KaplanMeierFitter()
    kmf.fit_interval_censoring(lo, hi, timeline=timeline)
    surv = kmf.survival_function_.iloc[:, 0]
    return (1 - surv) * 100


def _stable_slice(covered, sd, sd_ratio, sd_floor):
    """Where to stop a curve, given how precise it is elsewhere.

    Neither criterion works on its own:

    * An absolute threshold cannot tell "the tail has degenerated" from "this
      cohort is small". A 322-person cohort has a spread near two points at
      every age, and truncating it at the first age that exceeds two points
      throws away the whole curve.
    * A purely relative threshold punishes precision. A cohort with a median
      spread of 0.4 points trips a 3x rule at 1.2 points, which is still an
      entirely reportable estimate.

    So a point is dropped only when it is anomalous for this cohort *and*
    imprecise in absolute terms: `sd > max(sd_floor, sd_ratio * median(sd))`.
    A degenerate tail fails both and is cut; a small cohort and a mildly
    widening tail each fail one, and are kept with honestly wide intervals.

    returns: slice of the grid to keep
    """
    if not covered.any():
        return slice(0, 0)
    typical = np.nanmedian(sd[covered])
    if not np.isfinite(typical) or typical <= 0:
        return slice(None)
    limit = max(sd_floor, sd_ratio * typical)
    stable = np.flatnonzero(covered & (sd <= limit))
    return slice(None, stable[-1] + 1) if len(stable) else slice(0, 0)


def survival_curve(
    df, n_imputations=40, sd_ratio=3.0, sd_floor=2.0, grid=None, rng=None
):
    """Fraction married by age, with the tail cut where it stops being estimable.

    Fits a Kaplan-Meier curve to each of `n_imputations` draws from the
    respondents' intervals, then reports the mean across draws. The spread
    across draws is what makes this worth doing: where the dates are coarse and
    the risk set is thin, the same data supports wildly different curves, and
    the spread says so. Where there is real data the spread is a fraction of a
    percentage point, so the mean is just the ordinary estimate.

    The curve is truncated where the across-draw spread becomes anomalous for
    this cohort. That replaces an arbitrary risk-set floor with a rule that
    states its own criterion: report the curve where repeated imputations agree,
    and stop where they do not.

    df: respondents, after add_bounds
    n_imputations: number of draws
    sd_ratio: stop where the spread exceeds this multiple of the cohort median
    sd_floor: ...and also exceeds this many percentage points
    grid: ages to report on
    rng: numpy Generator

    returns: DataFrame indexed by age, with columns `fraction` and `sd`
    """
    from lifelines import KaplanMeierFitter

    if rng is None:
        rng = np.random.default_rng()
    if grid is None:
        grid = np.arange(14, 46, 0.25)

    draws = np.empty((n_imputations, len(grid)))
    for i in range(n_imputations):
        times = impute_times(df, rng)
        kmf = KaplanMeierFitter()
        kmf.fit(times, df.observed)
        curve = (1 - kmf.survival_function_.iloc[:, 0]) * 100
        draws[i] = np.interp(grid, curve.index, curve.values, right=np.nan)

    covered = ~np.all(np.isnan(draws), axis=0)
    mean = np.full(len(grid), np.nan)
    sd = np.full(len(grid), np.nan)
    mean[covered] = draws[:, covered].mean(axis=0)
    sd[covered] = draws[:, covered].std(axis=0)

    keep = _stable_slice(covered, sd, sd_ratio, sd_floor)

    return pd.DataFrame(
        {"fraction": mean[keep], "sd": sd[keep]},
        index=pd.Index(np.asarray(grid)[keep], name="age"),
    )


def bootstrap_curve(
    df,
    n_iter=101,
    sd_ratio=3.0,
    sd_floor=2.0,
    grid=None,
    rng=None,
    weight_col="finalwgt",
    cycle_col="cycle",
    percentiles=(5, 95),
):
    """Fraction married by age, with a confidence interval.

    Each iteration resamples respondents within cycle, with probability
    proportional to the sampling weight, and *then* draws a time from each
    respondent's interval. Bootstrapping the whole procedure means the spread
    across iterations carries both sources of uncertainty at once: sampling
    variability, and not knowing the dates to better than a year.

    Drawing one imputation per bootstrap iteration rather than nesting them is
    deliberate. Nesting would let the two sources be reported separately, at
    B x M times the cost; for a published interval the combined spread is what
    matters, and `survival_curve` already reports the imputation-only spread
    when the decomposition is wanted.

    The curve stops where the across-iteration spread becomes anomalous for
    this cohort -- see `_stable_slice`.

    returns: DataFrame indexed by age, with `fraction`, `sd`, `low` and `high`
    """
    from lifelines import KaplanMeierFitter

    if rng is None:
        rng = np.random.default_rng()
    if grid is None:
        grid = np.arange(14, 46, 0.25)

    draws = np.empty((n_iter, len(grid)))
    for i in range(n_iter):
        parts = []
        for _, group in df.groupby(cycle_col):
            weights = group[weight_col].to_numpy(dtype=float)
            total = weights.sum()
            if not np.isfinite(total) or total <= 0:
                continue
            idx = rng.choice(
                len(group), size=len(group), replace=True, p=weights / total
            )
            parts.append(group.iloc[idx])
        if not parts:
            draws[i] = np.nan
            continue
        sample = pd.concat(parts, ignore_index=True)

        times = impute_times(sample, rng)
        kmf = KaplanMeierFitter()
        kmf.fit(times, sample.observed)
        curve = (1 - kmf.survival_function_.iloc[:, 0]) * 100
        draws[i] = np.interp(grid, curve.index, curve.values, right=np.nan)

    covered = ~np.all(np.isnan(draws), axis=0)
    out = {k: np.full(len(grid), np.nan) for k in ("fraction", "sd", "low", "high")}
    if covered.any():
        block = draws[:, covered]
        out["fraction"][covered] = np.nanmean(block, axis=0)
        out["sd"][covered] = np.nanstd(block, axis=0)
        out["low"][covered] = np.nanpercentile(block, percentiles[0], axis=0)
        out["high"][covered] = np.nanpercentile(block, percentiles[1], axis=0)

    keep = _stable_slice(covered, out["sd"], sd_ratio, sd_floor)

    return pd.DataFrame(
        {k: v[keep] for k, v in out.items()},
        index=pd.Index(np.asarray(grid)[keep], name="age"),
    )
