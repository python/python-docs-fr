#!/usr/bin/env python
"""Measure line length in given files, run as:

    python line-length.py *.po

It does not count zero-width caracters from the Mn Unicode category
(Nonspacing Mark).

It returns 0 on success, 1 on failure.
"""

from unicodedata import category
import fileinput
import sys

SOFT_LIMIT = 80  # used for splitables lines (with spaces in them)
HARD_LIMIT = 88  # used for non-splitables lines (without spaces in them)


def clean(line):
    return "".join(char for char in line if category(char) != "Mn").rstrip("\n")


return_code = 0

for line in fileinput.input(encoding="utf-8"):
    line = clean(line)
    limit = SOFT_LIMIT if line.count(" ") > 1 else HARD_LIMIT
    if len(set(line)) <= 6:
        continue  # msgcat does not wraps the long line of dots in howto/perf_profiling.rst
    if len(line) > limit:
        print(
            f"{fileinput.filename()}:{fileinput.filelineno()} line too long "
            f"({len(line)} > {limit} characters)",
            file=sys.stderr,
        )
        return_code = 1


sys.exit(return_code)
