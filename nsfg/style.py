"""Figure style, following the conventions used in the CultureWar figures.

No spines, a light grid on both axes, left-aligned bold titles. Import
`apply_style()` once at the top of a plotting script, and call `decorate_axes()`
on each axes.
"""

import matplotlib as mpl
import matplotlib.pyplot as plt

FONT_FAMILY = "Roboto"
FONT_SANS_SERIF = ["Roboto", "DejaVu Sans", "Arial", "Helvetica", "sans-serif"]
GRID_ALPHA = 0.3

RCPARAMS = {
    "font.family": "sans-serif",
    "font.sans-serif": FONT_SANS_SERIF,
    "font.size": 10,
    "axes.titlesize": 12,
    "axes.labelsize": 10,
    "axes.titlelocation": "left",
    "axes.titleweight": "bold",
    "xtick.labelsize": 9,
    "ytick.labelsize": 9,
    "legend.fontsize": 9,
    "legend.frameon": False,
    "lines.linewidth": 1.6,
    "grid.linewidth": 0.4,
    "grid.alpha": GRID_ALPHA,
    "figure.dpi": 150,
    "savefig.bbox": "tight",
}

# a sequential map for birth cohorts, reversed so the oldest cohort is light
# and the most recent is dark -- the recent ones carry the argument
COHORT_CMAP = "viridis_r"


def apply_style():
    """Set the rcParams for this project's figures."""
    mpl.rcParams.update(RCPARAMS)


def decorate_axes(ax, **options):
    """Drop the spines and add the grid, then set whatever else was passed."""
    for side in ("top", "right", "bottom", "left"):
        ax.spines[side].set_visible(False)
    ax.grid(True, which="major", axis="both", alpha=GRID_ALPHA)
    ax.set_axisbelow(True)
    ax.tick_params(length=0)
    if options:
        ax.set(**options)


def cohort_colors(cohorts, cmap=COHORT_CMAP):
    """Map cohort -> colour, fixed across figures.

    Men were not interviewed before 2002, so a male figure has fewer cohorts
    than the female one. Colouring by position within each figure would make the
    same colour mean different decades in the two.
    """
    cohorts = sorted(cohorts)
    scale = plt.get_cmap(cmap)
    n = max(len(cohorts) - 1, 1)
    return {c: scale(i / n) for i, c in enumerate(cohorts)}
