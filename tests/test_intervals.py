"""Tests for interval bounds and the imputation-based survival estimator."""

import numpy as np
import pandas as pd

from nsfg.intervals import add_bounds, impute_times, survival_curve


def frame(cycle, ager, mardat01=None, married=False, cmintvw=1400.0, n=1):
    return pd.DataFrame(
        {
            "cycle": [cycle] * n,
            "ager": [float(ager)] * n,
            "cmintvw": [cmintvw] * n,
            "mardat01": [mardat01] * n,
            "agemarry": [np.nan if mardat01 is None else 25.0] * n,
            "evrmarry": [married] * n,
        }
    )


class TestBounds:
    """Interval width should reflect what each cycle actually published."""

    def test_coarse_cycle_censored_spans_one_year(self):
        b = add_bounds(frame(12, 30))
        assert np.isclose(b.t_hi[0] - b.t_lo[0], 1.0)

    def test_coarse_cycle_married_spans_two_years(self):
        b = add_bounds(frame(12, 40, mardat01=2000, married=True))
        assert np.isclose(b.t_hi[0] - b.t_lo[0], 2.0)

    def test_fine_cycle_spans_one_month(self):
        b = add_bounds(frame(9, 30.5))
        assert np.isclose(b.t_hi[0] - b.t_lo[0], 1 / 12, atol=1e-9)

    def test_bounds_contain_the_midpoint_convention(self):
        # the readers' -6/+6 midpoint must lie inside the honest interval
        b = add_bounds(frame(12, 40, mardat01=2000, married=True))
        midpoint = ((2000 - 1900) * 12 + 6 - (1400 - 40 * 12 - 6)) / 12
        assert b.t_lo[0] <= midpoint <= b.t_hi[0]

    def test_times_are_never_negative(self):
        b = add_bounds(frame(12, 15, mardat01=1900, married=True))
        assert (b.t_lo >= 0).all()


class TestImputation:
    """Draws must land inside the interval and actually vary."""

    def test_draws_stay_inside_the_interval(self):
        b = add_bounds(frame(12, 30, n=500))
        t = impute_times(b, np.random.default_rng(0))
        assert (t >= b.t_lo).all() and (t <= b.t_hi).all()

    def test_draws_break_ties(self):
        b = add_bounds(frame(12, 30, n=500))
        t = impute_times(b, np.random.default_rng(0))
        # the input is 500 identical integer ages; the output should not be
        assert t.nunique() > 400


class TestSurvivalCurve:
    """The curve should stop where repeated imputations stop agreeing."""

    def _cohort(self, n_married, n_censored, seed=0):
        rng = np.random.default_rng(seed)
        married = pd.DataFrame(
            {
                "cycle": 12,
                "ager": 40.0,
                "cmintvw": 1400.0,
                "mardat01": rng.integers(1985, 1995, n_married).astype(float),
                "agemarry": 25.0,
                "evrmarry": True,
            }
        )
        censored = pd.DataFrame(
            {
                "cycle": 12,
                "ager": rng.integers(20, 40, n_censored).astype(float),
                "cmintvw": 1400.0,
                "mardat01": np.nan,
                "agemarry": np.nan,
                "evrmarry": False,
            }
        )
        return add_bounds(pd.concat([married, censored], ignore_index=True))

    def test_returns_a_curve(self):
        out = survival_curve(
            self._cohort(200, 300), n_imputations=10, rng=np.random.default_rng(0)
        )
        assert {"fraction", "sd"} <= set(out.columns)
        assert out.index.name == "age"

    def test_truncates_where_the_spread_is_large(self):
        cohort = self._cohort(200, 300)
        wide = survival_curve(
            cohort, n_imputations=10, max_sd=100, rng=np.random.default_rng(0)
        )
        tight = survival_curve(
            cohort, n_imputations=10, max_sd=0.01, rng=np.random.default_rng(0)
        )
        assert len(tight) <= len(wide)

    def test_reported_spread_respects_the_threshold(self):
        out = survival_curve(
            self._cohort(200, 300),
            n_imputations=10,
            max_sd=2.0,
            rng=np.random.default_rng(0),
        )
        assert out.sd.iloc[-1] < 2.0
