"""Tests for the ported Kaplan-Meier code.

Replaces archive/survival_test.py, which tested the vendored Think Stats
module, and archive/marriage_test.py, which called two functions
(MakeSurvivalFunction, EstimateHazardFunction) that marriage.py never had.
"""

import numpy as np

from nsfg import survival


def test_hazard_from_complete_lifetimes():
    hf = survival.EstimateHazardFunction([1, 2, 3, 4, 5], [])
    # at t=2, one event out of four still at risk
    assert np.isclose(hf[2], 0.25)
    assert np.isclose(hf[3], 1 / 3)


def test_survival_from_hazard():
    sf = survival.EstimateHazardFunction([1, 2, 3, 4, 5], []).MakeSurvival()
    assert list(sf.ts) == [1, 2, 3, 4, 5]
    assert np.allclose(sf.Probs([1, 2, 3]), [0.8, 0.6, 0.4])


def test_censored_observations_stay_in_the_risk_set():
    # one event at t=1, one censored at t=2: the censored case was at risk
    hf = survival.EstimateHazardFunction([1], [2])
    assert np.isclose(hf[1], 0.5)


def test_truncate_drops_the_tail():
    hf = survival.EstimateHazardFunction([1, 2, 3, 4, 5], [])
    hf.Truncate(4)
    assert len(hf) == 3


def test_survival_is_monotonically_decreasing():
    rng = np.random.default_rng(0)
    complete = rng.integers(1, 40, size=300).tolist()
    ongoing = rng.integers(1, 40, size=200).tolist()
    ss = survival.EstimateHazardFunction(complete, ongoing).MakeSurvival().ss
    assert np.all(np.diff(ss) <= 1e-12)
