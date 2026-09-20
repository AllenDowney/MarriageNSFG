"""Tests for the validation checks. These need no survey data."""

import warnings

import numpy as np
import pandas as pd
import pytest

from nsfg.validate import (
    FEM_COUNTS,
    MALE_COUNTS,
    ValidationError,
    check_counts,
    check_cross_cycle,
    check_reconstructed_age,
)


def make_resp(n=100, ager=30, offset_months=-6):
    """A minimal respondent frame with a reconstructed cmbirth."""
    cmintvw = np.full(n, 1400.0)
    ages = np.full(n, float(ager))
    return pd.DataFrame(
        {
            "cmintvw": cmintvw,
            "ager": ages,
            "cmbirth": cmintvw - ages * 12 + offset_months,
            "evrmarry": np.zeros(n, dtype=bool),
        }
    )


class TestCounts:
    """Per-cycle row and marriage counts."""

    def test_accepts_matching_counts(self):
        df = pd.DataFrame({"evrmarry": [True] * 4651 + [False] * (7969 - 4651)})
        assert check_counts(df, 1982, FEM_COUNTS) == 3

    def test_rejects_wrong_row_count(self):
        df = pd.DataFrame({"evrmarry": [True] * 10})
        with pytest.raises(ValidationError, match="rows"):
            check_counts(df, 1982, FEM_COUNTS)

    def test_rejects_wrong_marriage_count(self):
        df = pd.DataFrame({"evrmarry": [False] * 7969})
        with pytest.raises(ValidationError, match="ever married"):
            check_counts(df, 1982, FEM_COUNTS)

    def test_every_cycle_has_a_cycle_number(self):
        assert sorted(c for c, _, _ in FEM_COUNTS.values()) == list(range(3, 13))
        assert sorted(c for c, _, _ in MALE_COUNTS.values()) == list(range(6, 13))


class TestReconstructedAge:
    """Feasibility of cmbirth reconstructed from an integer age."""

    def test_midpoint_offset_passes(self):
        # -6 puts birth in the middle of the year the reported age allows
        assert check_reconstructed_age(make_resp(offset_months=-6), 2023, 12) == 0.5

    def test_plus_six_is_infeasible(self):
        # the Task 14 bug: birth six months after the latest possible date
        with pytest.raises(ValidationError, match=r"outside \[ager, ager\+1\)"):
            check_reconstructed_age(make_resp(offset_months=+6), 2023, 12)

    def test_zero_offset_is_feasible_but_warns(self):
        # the male readers' formula before Task 14: biased, never impossible
        with warnings.catch_warnings(record=True) as w:
            warnings.simplefilter("always")
            assert check_reconstructed_age(make_resp(offset_months=0), 2023, 12) == 0.0
            assert any("biased" in str(x.message) for x in w)

    def test_skipped_for_cycles_with_a_real_cmbirth(self):
        # cycles before 10 carry cmbirth on the file; nothing to check
        assert check_reconstructed_age(make_resp(offset_months=+6), 2002, 6) is None


class TestCrossCycle:
    """Detection of discontinuities at cycle boundaries."""

    def _frame(self, values):
        rows = []
        for cycle, val in enumerate(values, start=3):
            rows += [{"cycle": cycle, "finalwgt": 1.0, "x": val}] * 50
        return pd.DataFrame(rows)

    def test_steady_trend_is_not_flagged(self):
        df = self._frame([1, 2, 3, 4, 5, 6])
        assert len(check_cross_cycle(df, columns=["x"])) == 0

    def test_discontinuity_is_flagged(self):
        df = self._frame([1, 2, 3, 4, 5, 50])
        flagged = check_cross_cycle(df, columns=["x"])
        assert len(flagged) == 1
        assert flagged.iloc[0]["boundary"] == "7->8"
