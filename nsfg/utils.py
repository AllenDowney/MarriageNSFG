"""Plotting and estimation helpers for the NSFG analyses."""

from pathlib import Path

import matplotlib.image as mpimg
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
from lifelines import KaplanMeierFitter
from mpl_toolkits.axes_grid1.inset_locator import inset_axes
from scipy.stats import norm


def value_counts(seq, **options):
    """Make a series of values and the number of times they appear.

    Returns a DataFrame because they get rendered better in Jupyter.

    Args:
        seq: sequence
        options: passed to pd.Series.value_counts

    returns: pd.Series
    """
    options = underride(options, dropna=False)
    series = pd.Series(seq).value_counts(**options).sort_index()
    series.index.name = "values"
    series.name = "counts"
    return pd.DataFrame(series)


def sample_rows(df, nrows, replace=False):
    """Choose a sample of rows from a DataFrame.

    df: DataFrame
    nrows: number of rows
    replace: whether to sample with replacement

    returns: DataDf
    """
    indices = np.random.choice(df.index, nrows, replace=replace)
    sample = df.loc[indices]
    return sample


def resample_rows(df):
    """Resamples rows from a DataFrame.

    df: DataFrame

    returns: DataFrame
    """
    return sample_rows(df, len(df), replace=True)


def resample_rows_weighted(df, column="finalwgt"):
    """Resamples a DataFrame using probabilities proportional to given column.

    df: DataFrame
    column: string column name to use as weights

    returns: DataFrame
    """
    weights = df[column]
    sample = df.sample(n=len(df), replace=True, weights=weights)
    return sample


def resample_by_cycle(unweighted):
    """Resample a DataFrame, grouped by cycle.

    unweighted: DataFrame

    returns: DataFrame
    """
    dfs = []

    for _name, group in unweighted.groupby("cycle"):
        df = resample_rows_weighted(group, "finalwgt")
        dfs.append(df)

    return pd.concat(dfs).reset_index(drop=True)


def normalize_weights_by_cycle(unweighted, weight_col="finalwgt"):
    """Normalize finalwgt within each cycle group so the average is 1.

    unweighted: DataFrame

    returns: DataFrame with normalized weights
    """
    dfs = []

    for _name, group in unweighted.groupby("cycle"):
        group = group.copy()
        mean_weight = group[weight_col].mean()
        group[weight_col] = group[weight_col] / mean_weight
        dfs.append(group)

    return pd.concat(dfs).reset_index(drop=True)


def round_into_bins(series, bin_width, low=0, high=None):
    """Rounds values down to the bin they belong in.

    series: pd.Series
    bin_width: number, width of the bins

    returns: array of bin values
    """
    if high is None:
        high = series.max()

    bins = np.arange(low, high + bin_width, bin_width)
    indices = np.digitize(series, bins)
    return bins[indices - 1]


def underride(d, **options):
    """Add key-value pairs to d only if key is not in d.

    d: dictionary
    options: keyword args to add to d
    """
    for key, val in options.items():
        d.setdefault(key, val)

    return d


def decorate(**options):
    """Decorate the current axes.
    Call decorate with keyword arguments like
    decorate(title='Title',
             xlabel='x',
             ylabel='y')
    The keyword arguments can be any of the axis properties
    https://matplotlib.org/api/axes_api.html
    In addition, you can use `legend=False` to suppress the legend.
    And you can use `loc` to indicate the location of the legend
    (the default value is 'best')
    """
    loc = options.pop("loc", "best")
    if options.pop("legend", True):
        legend(loc=loc)

    plt.gca().set(**options)
    plt.tight_layout()


def legend(**options):
    """Draws a legend only if there is at least one labeled item.
    options are passed to plt.legend()
    https://matplotlib.org/api/_as_gen/matplotlib.pyplot.legend.html
    """
    underride(options, loc="best")

    ax = plt.gca()
    handles, labels = ax.get_legend_handles_labels()
    if handles:
        ax.legend(handles, labels, **options)


def anchor_legend(x, y):
    """Put the legend at the given location.

    x: axis coordinate
    y: axis coordinate
    """
    plt.legend(bbox_to_anchor=(x, y), loc="upper left", ncol=1)


def adjust_legend(**options):
    """Adjusts the properties of the lines in a legend.

    If draw lots of lines with low alpha, the legend is hard to read.
    Label the first line in each category, then change the properties
    of the line, usually alpha and linewidth.

    options: keyword arguments passed to line.set
    """
    current = plt.gca().get_legend()
    for line in current.get_lines():
        line.set(**options)


def set_palette(*args, **kwds):
    """Set the matplotlib color cycler.

    args, kwds: same as for sns.color_palette

    Also takes a boolean kwd, `reverse`, to indicate
    whether the order of the palette should be reversed.

    returns: list of colors
    """
    reverse = kwds.pop("reverse", False)
    palette = sns.color_palette(*args, **kwds)

    palette = list(palette)
    if reverse:
        palette.reverse()

    cycler = plt.cycler(color=palette)
    plt.gca().set_prop_cycle(cycler)
    return palette


def estimate_proportion(success_series, weights_series, confidence_level=0.95):
    """
    Estimate weighted proportion with Wilson score interval adjusted using effective sample size.

    Parameters:
    success_series (pd.Series): Boolean series (True = success).
    weights_series (pd.Series): Corresponding weights.
    confidence_level (float): Confidence level (e.g., 0.95)

    Returns:
    tuple: (weighted_proportion, lower_bound, upper_bound)
    """
    success_series = success_series.astype(float)
    weights_series = weights_series.astype(float)

    weighted_successes = (success_series * weights_series).sum()
    total_weight = weights_series.sum()
    p = weighted_successes / total_weight

    # Estimate effective sample size
    n_eff = total_weight**2 / (weights_series**2).sum()

    # Z-score for confidence interval
    z = norm.ppf(1 - (1 - confidence_level) / 2)

    denominator = 1 + z**2 / n_eff
    center = (p + z**2 / (2 * n_eff)) / denominator
    margin = (z * np.sqrt((p * (1 - p) + z**2 / (4 * n_eff)) / n_eff)) / denominator

    lower = center - margin
    upper = center + margin

    return p, lower, upper


def percentile_rows(row_seq, percentiles):
    """Generates a sequence of percentiles from a sequence of rows.

    row_seq: sequence of rows
    percentiles: sequence of percentiles ranks (0-100)

    returns: sequence of percentiles
    """
    array = np.asarray(row_seq)
    return np.percentile(array, percentiles, axis=0)


def make_kmf_map(grouped, min_at_risk=10):
    """Dictionary that maps from cohort name to survival function

    The tail of a Kaplan-Meier estimate is unreliable once the risk set is
    nearly exhausted: a single event when two people remain moves the curve by
    50 points, and a single event when one remains sends it to 100%. The
    youngest cohort is always the worst case, because it is observed over only
    a few years and almost nobody has married yet.

    Curves are therefore truncated at the last time with at least `min_at_risk`
    people still at risk. The vendored Think Stats code had the same idea, as a
    `cutoffs` argument applied by hand; that code has since been deleted.

    grouped: GroupBy object
    min_at_risk: smallest risk set to trust; None disables truncation.
        The default of 10 removes the pathological tail on the youngest
        cohort while leaving every other cohort essentially unchanged;
        25 would clip the small 1930s cohort back by a decade.

    returns: dictionary that maps from cohort name to survival Series
    """
    kmf_map = {}

    for cohort, group in grouped:
        kmf = KaplanMeierFitter()
        kmf.fit(group["duration"], group["observed"])
        series = (1 - kmf.survival_function_["KM_estimate"]) * 100

        if min_at_risk:
            reliable = kmf.event_table.index[kmf.event_table.at_risk >= min_at_risk]
            if len(reliable):
                series = series[series.index <= reliable.max()]

        series.name = cohort
        kmf_map[cohort] = series

    return kmf_map


def add_text(x, y, text, **options):
    """Add text to the current axes.

    x: float
    y: float
    text: string
    options: keyword arguments passed to plt.text
    """
    ax = plt.gca()
    underride(
        options,
        transform=ax.transAxes,
        color="0.2",
        ha="left",
        va="bottom",
        fontsize=9,
    )
    plt.text(x, y, text, **options)


def remove_spines():
    """Remove the spines of a plot but keep the ticks visible."""
    ax = plt.gca()
    for spine in ax.spines.values():
        spine.set_visible(False)

    # Ensure ticks stay visible
    ax.xaxis.set_ticks_position("bottom")
    ax.yaxis.set_ticks_position("left")


def add_logo(filename="probably_logo.png", location=(1.0, -0.3), size=(0.45, 0.45)):
    """Add a logo inside an inset axis positioned relative to the main plot."""

    from nsfg.paths import FIGURES

    path = Path(filename)
    if not path.is_absolute():
        path = FIGURES / path
    logo = mpimg.imread(path)

    # Create an inset axis in the given location (transAxes places it relative to the axes)
    ax = plt.gca()
    ax_inset = inset_axes(
        ax,
        width=size[0],
        height=size[1],
        loc="lower right",
        bbox_to_anchor=location,
        bbox_transform=ax.transAxes,
        borderpad=0,
    )

    # Display the logo
    ax_inset.imshow(logo)
    ax_inset.axis("off")

    return ax_inset


def add_aibm_logo(filename="logo-hq-small.png", location=(1.0, -0.3), size=(0.6, 0.3)):
    """Add a logo inside an inset axis positioned relative to the main plot."""

    from nsfg.paths import FIGURES

    path = Path(filename)
    if not path.is_absolute():
        path = FIGURES / path
    logo = mpimg.imread(path)

    # Create an inset axis in the given location (transAxes places it relative to the axes)
    ax = plt.gca()
    ax_inset = inset_axes(
        ax,
        width=size[0],
        height=size[1],
        loc="lower right",
        bbox_to_anchor=location,
        bbox_transform=ax.transAxes,
        borderpad=0,
    )

    # Display the logo
    ax_inset.imshow(logo)
    ax_inset.axis("off")

    return ax_inset


def add_subtext(text, x=0, y=-0.3):
    """Add a text label below the current plot.

    Args:
        text: string
    """
    ax = plt.gca()
    return plt.figtext(
        x, y, text, ha="left", va="bottom", fontsize=8, transform=ax.transAxes
    )


def add_title(title, subtitle, pad=25):
    """Add a title and subtitle to the current plot.

    Args:
        title (str): Title of the plot
        subtitle (str): Subtitle of the plot
        pad (int): Padding between the title and subtitle
    """
    plt.title(title, loc="left", pad=pad)
    add_text(0, 1.05, subtitle)


def savefig(prefix, fig_number, extra_artists=None):
    """Save the current figure into the figures/ directory.

    The path is resolved against FIGURES rather than the working directory, so
    it does not matter where the notebook is run from. An absolute prefix is
    used as given.

    Args:
        prefix (str): filename stem, e.g. "nsfg_marriage"
        fig_number (int): The figure number
        extra_artists: Additional artists to include in the bounding box
    """
    from nsfg.paths import FIGURES

    if extra_artists is None:
        extra_artists = []

    stem = f"{prefix}{fig_number:02d}"
    path = Path(stem)
    if not path.is_absolute():
        path = FIGURES / path
    path.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(path, dpi=150, bbox_inches="tight", bbox_extra_artists=extra_artists)
