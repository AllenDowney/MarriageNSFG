#!/usr/bin/env python3
"""Download the NSFG public-use files this project reads.

The survey data is not in this repository and may not be redistributed, so it
has to be fetched from NCHS. This script does that, and does the small amount of
reshaping the readers expect.

    python scripts/download_nsfg.py --i-accept-nchs-terms
    python scripts/download_nsfg.py --i-accept-nchs-terms --cycle 2022-2023
    python scripts/download_nsfg.py --check          # what is present, no network

NCHS distributes these files under a data user agreement. Read and accept it
before running this:

    https://www.cdc.gov/nchs/nsfg/index.htm

The agreement is a click-through on the NSFG download pages; the FTP paths used
here serve without one. That is a technical detail, not permission -- the
obligation is yours either way, which is why this script will not run without
--i-accept-nchs-terms.

Two things the readers expect that NCHS does not provide directly:

* NCHS serves uncompressed .dat; the readers expect .dat.gz. Files are
  compressed after download.
* 1988FemRespDataLines.dat.gz does not exist upstream. The 1988 file has no line
  breaks at all -- it is one 30,022,850-byte run of 8,450 records of 3,553 bytes.
  ReadFemResp1988 reads the line-delimited form, so it is derived here.

CPS and IPUMS extracts (cps_*.dta.gz, usa_*.csv.gz, jun24pub.csv) are NOT
covered. Those are user-specific extracts that have to be requested from
IPUMS and the Census Bureau; see codebooks/README.md and the notebooks that
use them.
"""

import argparse
import gzip
import shutil
import sys
import tempfile
import urllib.request
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
DATA_RAW = REPO_ROOT / "data" / "raw"

FTP = "https://ftp.cdc.gov/pub/Health_Statistics/NCHS"
DATASETS = f"{FTP}/Datasets/NSFG"
STATA = f"{DATASETS}/stata"
PUF = f"{FTP}/NSFG"

# cycle -> (files served as-is, .dat files that need compressing, .dct files)
CYCLES = {
    "1982": ([], ["1982NSFGData.dat"], []),
    "1988": ([], ["1988FemRespData.dat"], []),
    "1995": ([], ["1995FemRespData.dat"], []),
    "2002": ([], ["2002FemResp.dat", "2002Male.dat"],
             ["2002FemResp.dct", "2002Male.dct"]),
    "2006-2010": ([], ["2006_2010_FemResp.dat", "2006_2010_Male.dat"],
                  ["2006_2010_FemRespSetup.dct", "2006_2010_MaleSetup.dct"]),
    "2011-2013": ([], ["2011_2013_FemRespData.dat", "2011_2013_MaleData.dat"],
                  ["2011_2013_FemRespSetup.dct", "2011_2013_MaleSetup.dct"]),
    "2013-2015": ([], ["2013_2015_FemRespData.dat", "2013_2015_MaleData.dat"],
                  ["2013_2015_FemRespSetup.dct", "2013_2015_MaleSetup.dct"]),
    "2015-2017": ([], ["2015_2017_FemRespData.dat", "2015_2017_MaleData.dat",
                       "2015_2017_FemPregData.dat"],
                  ["2015_2017_FemRespSetup.dct", "2015_2017_MaleSetup.dct",
                   "2015_2017_FemPregSetup.dct"]),
    "2017-2019": ([], ["2017_2019_FemRespData.dat", "2017_2019_MaleData.dat"],
                  ["2017_2019_FemRespSetup.dct", "2017_2019_MaleSetup.dct"]),
    "2022-2023": (["NSFG-2022-2023-FemRespPUFData.sas7bdat",
                   "NSFG-2022-2023-MaleRespPUFData.sas7bdat"], [], []),
}

# 1988 is stored as one unbroken run of fixed-width records
RECORD_LEN_1988 = 3553

TERMS = """
The National Survey of Family Growth public-use files are distributed by NCHS
under a data user agreement. Among other things, it does not permit
redistribution -- which is why this repository contains no survey data.

Read the agreement before downloading:

    https://www.cdc.gov/nchs/nsfg/index.htm

If you have read and accepted it, re-run with:

    --i-accept-nchs-terms
"""


def fetch(url, dest):
    dest.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(delete=False, dir=dest.parent) as tmp:
        urllib.request.urlretrieve(url, tmp.name)
        Path(tmp.name).replace(dest)


def fetch_gzipped(url, dest):
    """Download an uncompressed file and store it gzipped."""
    dest.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory() as tmp:
        plain = Path(tmp) / dest.stem
        urllib.request.urlretrieve(url, plain)
        with open(plain, "rb") as src, gzip.open(dest, "wb") as out:
            shutil.copyfileobj(src, out)


def derive_1988_lines():
    """Write 1988FemRespDataLines.dat.gz, which NCHS does not publish."""
    src = DATA_RAW / "1988FemRespData.dat.gz"
    dest = DATA_RAW / "1988FemRespDataLines.dat.gz"
    if not src.exists():
        print("  1988FemRespDataLines.dat.gz  SKIPPED (source not present)")
        return
    with gzip.open(src, "rb") as f:
        raw = f.read()
    n, rem = divmod(len(raw), RECORD_LEN_1988)
    if rem:
        print(f"  WARNING: 1988 file is not a whole number of "
              f"{RECORD_LEN_1988}-byte records ({rem} bytes over)")
    with gzip.open(dest, "wb") as out:
        for i in range(n):
            out.write(raw[i * RECORD_LEN_1988:(i + 1) * RECORD_LEN_1988] + b"\n")
    print(f"  1988FemRespDataLines.dat.gz  derived ({n} records)")


def wanted(cycle_filter):
    for cycle, spec in CYCLES.items():
        if cycle_filter and cycle != cycle_filter:
            continue
        yield cycle, spec


def do_check(cycle_filter):
    missing = 0
    for cycle, (asis, dats, dcts) in wanted(cycle_filter):
        names = list(asis) + [d + ".gz" for d in dats] + list(dcts)
        if cycle == "1988":
            names.append("1988FemRespDataLines.dat.gz")
        have = [n for n in names if (DATA_RAW / n).exists()]
        missing += len(names) - len(have)
        mark = "ok" if len(have) == len(names) else f"{len(have)}/{len(names)}"
        print(f"  {cycle:12s} {mark}")
    print(f"\n{'all present' if not missing else f'{missing} file(s) missing'}")
    return 0 if not missing else 1


def main():
    p = argparse.ArgumentParser(description=__doc__,
                                formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--i-accept-nchs-terms", action="store_true",
                   help="confirm you have read and accepted the NCHS data user agreement")
    p.add_argument("--cycle", choices=sorted(CYCLES), help="fetch one cycle only")
    p.add_argument("--check", action="store_true",
                   help="report which files are present; no network access")
    p.add_argument("--force", action="store_true", help="re-download files already present")
    args = p.parse_args()

    if args.check:
        print(f"Checking {DATA_RAW}\n")
        return do_check(args.cycle)

    if not args.i_accept_nchs_terms:
        print(TERMS)
        return 2

    DATA_RAW.mkdir(parents=True, exist_ok=True)
    for cycle, (asis, dats, dcts) in wanted(args.cycle):
        print(f"\n{cycle}")
        for name in asis:
            dest = DATA_RAW / name
            if dest.exists() and not args.force:
                print(f"  {name}  present")
                continue
            print(f"  {name}  downloading...", flush=True)
            fetch(f"{PUF}/{name}", dest)
        for name in dats:
            dest = DATA_RAW / (name + ".gz")
            if dest.exists() and not args.force:
                print(f"  {dest.name}  present")
                continue
            print(f"  {dest.name}  downloading and compressing...", flush=True)
            fetch_gzipped(f"{DATASETS}/{name}", dest)
        for name in dcts:
            dest = DATA_RAW / name
            if dest.exists() and not args.force:
                print(f"  {name}  present")
                continue
            print(f"  {name}  downloading...", flush=True)
            fetch(f"{STATA}/{name}", dest)
        if cycle == "1988":
            dest = DATA_RAW / "1988FemRespDataLines.dat.gz"
            if dest.exists() and not args.force:
                print(f"  {dest.name}  present")
            else:
                derive_1988_lines()

    print("\nDone. CPS and IPUMS extracts are not covered by this script.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
