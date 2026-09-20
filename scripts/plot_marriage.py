#!/usr/bin/env python3
"""Plot the cohort marriage curves produced by estimate_marriage.py.

    python scripts/plot_marriage.py

Reads the cached estimates from data/interim/ and writes figures to figures/.
Separating this from the estimation means a label can be changed without
re-running the bootstrap.
"""

import sys

import matplotlib
import pandas as pd

matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402

from nsfg.paths import FIGURES, interim  # noqa: E402

SOURCES = {
    "female": "marriage_by_cohort_female.parquet",
    "male": "marriage_by_cohort_male.parquet",
}

SEX_LABELS = {"female": "Women", "male": "Men"}


def load(sex):
    path = interim(SOURCES[sex])
    if not path.exists():
        sys.exit(f"{path.name} not found -- run scripts/estimate_marriage.py first")
    return pd.read_parquet(path)


def cohort_colors(cohorts, cmap="viridis"):
    """Map cohort -> colour, fixed across panels.

    Men were not interviewed before 2002, so the male panel has fewer cohorts
    than the female one. Colouring by position within each panel would make the
    same colour mean different decades on the two sides of the figure.
    """
    cohorts = sorted(cohorts)
    scale = plt.get_cmap(cmap)
    n = max(len(cohorts) - 1, 1)
    return {c: scale(i / n) for i, c in enumerate(cohorts)}


def plot_cohorts(ax, df, colors):
    """One line per birth cohort, with a shaded bootstrap interval."""
    for cohort in sorted(df.cohort.unique()):
        color = colors[cohort]
        g = df[df.cohort == cohort]
        ax.fill_between(g.age, g.low, g.high, color=color, alpha=0.2, linewidth=0)
        ax.plot(g.age, g.fraction, color=color, label=f"{cohort}s")
        # mark where the estimate stops being reportable
        ax.plot(g.age.iloc[-1], g.fraction.iloc[-1], "o", color=color, ms=4)


def main():
    data = {sex: load(sex) for sex in SOURCES}
    colors = cohort_colors(set().union(*(set(d.cohort) for d in data.values())))

    fig, axes = plt.subplots(1, 2, figsize=(11, 4.5), sharey=True)
    for ax, sex in zip(axes, ("female", "male")):
        df = data[sex]
        plot_cohorts(ax, df, colors)
        ax.set_title(SEX_LABELS[sex])
        ax.set(xlabel="Age", ylabel="Percent ever married")
        ax.spines[["top", "right"]].set_visible(False)
    axes[0].legend(loc="upper left", fontsize=8, frameon=False)
    axes[0].set_ylim(0, 100)
    fig.suptitle("Percent ever married, by decade of birth", y=1.02)
    fig.tight_layout()
    out = FIGURES / "marriage_by_cohort.png"
    fig.savefig(out, dpi=150, bbox_inches="tight")
    print(f"  wrote {out.name}")

    # a second figure: why each curve stops where it does
    fig, axes = plt.subplots(1, 2, figsize=(11, 4.5), sharey=True)
    for ax, sex in zip(axes, ("female", "male")):
        df = data[sex]
        for cohort in sorted(df.cohort.unique()):
            g = df[df.cohort == cohort]
            typical = g.sd.median()
            ax.plot(g.age, g.sd / typical, color=colors[cohort], label=f"{cohort}s")
            ax.plot(
                g.age.iloc[-1], g.sd.iloc[-1] / typical, "o", color=colors[cohort], ms=4
            )
        ax.axhline(3.0, color="0.4", lw=1, ls="--")
        ax.set(xlabel="Age", title=SEX_LABELS[sex])
        ax.spines[["top", "right"]].set_visible(False)
    axes[0].set_ylabel("Bootstrap spread / cohort median")
    axes[1].annotate(
        "curves stop above this line,\nif also above 2 points absolute",
        xy=(33, 3.25),
        fontsize=8,
        color="0.4",
    )
    axes[0].legend(
        loc="upper left", fontsize=8, frameon=False, bbox_to_anchor=(0, 0.92)
    )
    axes[0].set_ylim(0, 6)
    fig.suptitle("Where each estimate stops being reportable", y=1.02)
    fig.tight_layout()
    out = FIGURES / "marriage_by_cohort_stopping.png"
    fig.savefig(out, dpi=150, bbox_inches="tight")
    print(f"  wrote {out.name}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
