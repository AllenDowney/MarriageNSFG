"""Filesystem locations, anchored to the package rather than the CWD.

Every reader used to take a bare relative filename and assume the working
directory was the repo root. That broke as soon as code moved into a package
and notebooks moved into a subdirectory -- and nbconvert runs a notebook with
that notebook's own directory as the CWD, so it could not be relied on anyway.
"""

from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent

DATA_RAW = REPO_ROOT / "data" / "raw"
DATA_INTERIM = REPO_ROOT / "data" / "interim"
FIGURES = REPO_ROOT / "figures"
CODEBOOKS = REPO_ROOT / "codebooks"


def raw(filename):
    """Path to a file in data/raw."""
    return DATA_RAW / filename


def interim(filename):
    """Path to a file in data/interim."""
    return DATA_INTERIM / filename
