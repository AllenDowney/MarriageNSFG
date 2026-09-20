#!/usr/bin/env python3
"""Fetch NSFG codebooks and recode specs from NCHS and cache them as text.

The PDFs are large (13 MB for one codebook) and cannot be grepped. This
downloads them, extracts the text with `pdftotext -layout`, and writes the
result to codebooks/. Only the text is kept in the repo; the PDFs land in a
scratch directory and are not committed.

NCHS documentation is a US government work and is in the public domain, so
unlike the survey microdata it can be redistributed. See scripts/download_nsfg.py
for the data itself, which cannot.

Usage:
    python scripts/fetch_codebooks.py              # fetch anything missing
    python scripts/fetch_codebooks.py --refresh    # re-fetch everything
    python scripts/fetch_codebooks.py --list       # show what is cached
"""

import argparse
import shutil
import subprocess
import sys
import tempfile
import urllib.request
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
CODEBOOKS = REPO_ROOT / "codebooks"

BASE = "https://www.cdc.gov/nchs/data/nsfg"

# name in codebooks/  ->  URL
DOCS = {
    "2022-2023-FemResp-Codebook": f"{BASE}/codebooks/2022-2023-NSFG-FemRespPUFCodebook.pdf",
    "2022-2023-Male-Codebook": f"{BASE}/codebooks/2022-2023-NSFG-MalePUFCodebook.pdf",
    "2022-2023-FemPreg-Codebook": f"{BASE}/codebooks/2022-2023-NSFG-FemPregPUFCodebook.pdf",
    "2022-2023-FemResp-RecodeSpecs": f"{BASE}/recodespecs/2022-2023-NSFG-FemResp-RecodeSpecs.pdf",
    "2022-2023-Male-RecodeSpecs": f"{BASE}/recodespecs/2022-2023-NSFG-Male-RecodeSpecs.pdf",
}


def require_pdftotext():
    if shutil.which("pdftotext") is None:
        sys.exit(
            "pdftotext not found. It ships with poppler:\n"
            "    conda install -c conda-forge poppler\n"
            "    # or: apt install poppler-utils"
        )


def fetch_one(name, url, scratch):
    pdf = scratch / f"{name}.pdf"
    txt = CODEBOOKS / f"{name}.txt"

    print(f"  {name} ... ", end="", flush=True)
    urllib.request.urlretrieve(url, pdf)

    # -layout preserves the column alignment the value tables depend on
    subprocess.run(["pdftotext", "-layout", str(pdf), str(txt)], check=True)

    size_mb = pdf.stat().st_size / 1e6
    lines = sum(1 for _ in txt.open(errors="replace"))
    print(f"{size_mb:.1f} MB PDF -> {lines:,} lines of text")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--refresh", action="store_true", help="re-fetch documents already cached"
    )
    parser.add_argument(
        "--list", action="store_true", help="list cached documents and exit"
    )
    args = parser.parse_args()

    CODEBOOKS.mkdir(exist_ok=True)

    if args.list:
        for name in sorted(DOCS):
            txt = CODEBOOKS / f"{name}.txt"
            mark = "cached" if txt.exists() else "missing"
            print(f"  [{mark:>7}] {name}")
        return

    require_pdftotext()

    todo = {
        name: url
        for name, url in DOCS.items()
        if args.refresh or not (CODEBOOKS / f"{name}.txt").exists()
    }
    if not todo:
        print("Everything is cached. Use --refresh to re-fetch.")
        return

    print(f"Fetching {len(todo)} document(s) from {BASE}")
    with tempfile.TemporaryDirectory() as tmp:
        for name, url in sorted(todo.items()):
            fetch_one(name, url, Path(tmp))


if __name__ == "__main__":
    main()
