#!/usr/bin/env python3
"""Plot the cohort marriage curves produced by estimate_marriage.py.

    python scripts/plot_marriage.py

Reads the cached estimates from data/interim/ and writes figures to figures/.
Separating this from the estimation means a label can be changed without
re-running the bootstrap.
"""

import sys

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402

from nsfg.paths import FIGURES, interim  # noqa: E402
from nsfg.style import apply_style, cohort_colors, decorate_axes  # noqa: E402

import pandas as pd  # noqa: E402

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


def plot_curves(df, colors, title, subtitle, outfile):
    """One line per birth cohort, with a shaded bootstrap interval."""
    fig, ax = plt.subplots(figsize=(7.5, 5))
    for cohort in sorted(df.cohort.unique()):
        g = df[df.cohort == cohort]
        color = colors[cohort]
        ax.fill_between(g.age, g.low, g.high, color=color, alpha=0.18, linewidth=0)
        ax.plot(g.age, g.fraction, color=color, label=f"{cohort}s")
        ax.plot(g.age.iloc[-1], g.fraction.iloc[-1], "o", color=color, ms=4)
    decorate_axes(
        ax, xlabel="Age", ylabel="Percent ever married", xlim=(14, 47), ylim=(0, 100)
    )
    ax.set_title(title, pad=26)
    ax.text(
        0,
        1.015,
        subtitle,
        transform=ax.transAxes,
        fontsize=8.5,
        color="0.35",
        va="bottom",
    )
    ax.legend(loc="upper left", bbox_to_anchor=(0.01, 0.97), ncol=2)
    fig.savefig(FIGURES / outfile)
    plt.close(fig)
    print(f"  wrote {outfile}")


def plot_stopping(data, colors, outfile):
    """Where each curve stops, and why."""
    fig, ax = plt.subplots(figsize=(7.5, 5))
    for sex, style in (("female", "-"), ("male", "--")):
        df = data[sex]
        for cohort in sorted(df.cohort.unique()):
            g = df[df.cohort == cohort]
            ax.plot(
                g.age,
                g.sd / g.sd.median(),
                style,
                color=colors[cohort],
                alpha=0.9,
                label=f"{cohort}s" if sex == "female" else None,
            )
    ax.axhline(3.0, color="0.45", lw=1, ls=":")
    decorate_axes(
        ax,
        xlabel="Age",
        ylabel="Bootstrap spread, relative to cohort median",
        xlim=(14, 47),
        ylim=(0, 6),
    )
    ax.set_title("Where each estimate stops being reportable", pad=34)
    ax.text(
        0,
        1.015,
        "Solid: women.  Dashed: men.  A curve is cut past the dotted line, "
        "but only if it is also\nwider than two percentage points -- so a "
        "small cohort keeps its curve and its wide interval.",
        transform=ax.transAxes,
        fontsize=9,
        color="0.35",
    )
    ax.legend(loc="upper left", ncol=2)
    fig.savefig(FIGURES / outfile)
    plt.close(fig)
    print(f"  wrote {outfile}")


def main():
    apply_style()
    data = {sex: load(sex) for sex in SOURCES}
    colors = cohort_colors(set().union(*(set(d.cohort) for d in data.values())))

    for sex in ("female", "male"):
        plot_curves(
            data[sex],
            colors,
            title=f"{SEX_LABELS[sex]}: percent ever married, by decade of birth",
            subtitle="NSFG 1982-2023.  Shaded: 90% bootstrap interval.\n"
            "Dot: where the estimate stops being reportable.",
            outfile=f"marriage_by_cohort_{sex}.png",
        )
    plot_stopping(data, colors, "marriage_by_cohort_stopping.png")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
