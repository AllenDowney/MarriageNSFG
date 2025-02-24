from lifelines import KaplanMeierFitter
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy.stats import norm

import matplotlib.image as mpimg
from mpl_toolkits.axes_grid1.inset_locator import inset_axes


def value_counts(series, **options):
    """Counts the values in a series and returns sorted.

    series: pd.Series

    returns: pd.Series
    """
    options = underride(options, dropna=False)
    return series.value_counts(**options).sort_index()


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

    for name, group in unweighted.groupby('cycle'):
        df = resample_rows_weighted(group, 'finalwgt')
        dfs.append(df)

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
    legend = plt.gca().get_legend()
    for line in legend.get_lines():
        line.set(**options)


def set_palette(*args, **kwds):
    """Set the matplotlib color cycler.
    
    args, kwds: same as for sns.color_palette
    
    Also takes a boolean kwd, `reverse`, to indicate
    whether the order of the palette should be reversed.
    
    returns: list of colors
    """
    reverse = kwds.pop('reverse', False)
    palette = sns.color_palette(*args, **kwds)
    
    palette = list(palette)
    if reverse:
        palette.reverse()
        
    cycler = plt.cycler(color=palette)
    plt.gca().set_prop_cycle(cycler)
    return palette


def estimate_proportion(success_series, weights_series, confidence_level=0.95):
    """
    Calculate the weighted proportion and Wilson score interval for weighted data.

    Parameters:
    success_series (pd.Series): A boolean series where True represents a success.
    weights_series (pd.Series): A series of weights corresponding to the success_series.
    confidence_level (float): The confidence level for the Wilson score interval

    Returns:
    tuple of (weighted_proportion, lower, upper)
    """
    # Ensure the series are aligned and of correct type
    success_series = success_series.astype(float)
    weights_series = weights_series.astype(float)

    # Calculate weighted proportion
    total_weight = weights_series.sum()
    weighted_successes = (success_series * weights_series).sum()
    p = weighted_successes / total_weight

    # Calculate the z-score for the given confidence level
    z = norm.ppf(1 - (1 - confidence_level) / 2)

    # Wilson score interval adjusted for weighted data
    denominator = 1 + z**2 / total_weight
    center = (p + z**2 / (2 * total_weight)) / denominator
    sd = (
        np.sqrt((p * (1 - p) + z**2 / (4 * total_weight)) / total_weight)
        / denominator
    )

    # Lower and upper bounds of the Wilson interval
    lower = center - z * sd
    upper = center + z * sd

    return p, lower, upper


def percentile_rows(row_seq, percentiles):
    """Generates a sequence of percentiles from a sequence of rows.

    row_seq: sequence of rows
    percentiles: sequence of percentiles ranks (0-100)

    returns: sequence of percentiles
    """
    array = np.asarray(row_seq)
    return np.percentile(array, percentiles, axis=0)


def make_kmf_map(grouped):
    """Dictionary that maps from cohort name to survival function

    grouped: GroupBy object

    returns: dictionary that maps from cohort name to survival Series
    """
    kmf_map = {}

    for cohort, group in grouped:
        kmf = KaplanMeierFitter()
        kmf.fit(group['duration'], group['observed'])
        series = (1 - kmf.survival_function_['KM_estimate']) * 100
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
    ax.xaxis.set_ticks_position('bottom')
    ax.yaxis.set_ticks_position('left')





def add_logo(filename="logo-hq-small.png", location=(1.0, -0.3), size=(0.6, 0.3)):
    """Add a logo inside an inset axis positioned relative to the main plot."""

    logo = mpimg.imread(filename)

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


def add_subtext(text):
    """Add a text label below the current plot.

    Args:
        text: string
    """
    ax = plt.gca()
    plt.figtext(
        0, -0.3, text, ha="left", va="bottom", fontsize=8, transform=ax.transAxes
    )


def add_title(title, subtitle, pad=20):
    """Add a title and subtitle to the current plot.

    Args:
        title (str): Title of the plot
        subtitle (str): Subtitle of the plot
        pad (int): Padding between the title and subtitle
    """
    plt.title(title, loc="left", pad=pad)
    add_text(0, 1.02, subtitle) 