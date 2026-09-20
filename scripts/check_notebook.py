#!/usr/bin/env python3
"""Report whether an executed notebook is clean, and what it produced.

Used by `make execute`, which runs notebooks with --allow-errors so that one
parked notebook does not stop the rest. See Task 17 on the project board.
"""

import json
import sys
from collections import Counter

for path in sys.argv[1:]:
    nb = json.load(open(path))
    code = [c for c in nb["cells"] if c["cell_type"] == "code"]
    errors = Counter(
        o["ename"]
        for c in code
        for o in c.get("outputs", [])
        if o.get("output_type") == "error"
    )
    images = sum(
        1
        for c in code
        for o in c.get("outputs", [])
        if "image/png" in o.get("data", {})
    )
    if errors:
        detail = ", ".join(f"{n}x {e}" for e, n in errors.most_common())
        print(f"{sum(errors.values())} error(s): {detail}")
    else:
        print(f"clean  ({len(code)} cells, {images} figures)")
