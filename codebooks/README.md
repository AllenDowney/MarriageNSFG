# Cached NSFG documentation

Text extracted from the NCHS codebooks and recode specifications, so variable codings can be looked up with `grep` instead of opening a 13 MB PDF.

Fetched and refreshed by `scripts/fetch_codebooks.py`. Only the text is kept here; the PDFs are downloaded to a scratch directory and discarded.

```bash
python scripts/fetch_codebooks.py            # fetch anything missing
python scripts/fetch_codebooks.py --refresh  # re-fetch everything
python scripts/fetch_codebooks.py --list     # show what is cached
```

## Looking something up

Variable entries start at column 0, so anchoring the pattern finds the definition rather than every mention:

```bash
grep -A16 '^HIEDUC$' codebooks/2022-2023-FemResp-Codebook.txt
```

The recode specs explain how a derived variable was constructed, which the codebook does not:

```bash
grep -B2 -A30 'HIEDUC' codebooks/2022-2023-FemResp-RecodeSpecs.txt
```

`pdftotext -layout` is used so the value/frequency columns stay aligned.

## Why this is in the repo when the data is not

NSFG public-use microdata may not be redistributed, and Task 4 removes it from this repo and its history. NCHS documentation is a different matter: it is a US government work in the public domain. Caching it costs 3.5 MB and removes the most common reason to go looking outside the repo.

## Coverage

Currently 2022–2023 (cycle 12) only — the cycle that prompted this. Extending to 2002–2019 is part of Task 10 on the project board.
