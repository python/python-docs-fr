#!/usr/bin/env python
"""Measure line length in given files, run as:

    python line-length.py *.po

It does not count zero-width caracters from the Mn Unicode category
(Nonspacing Mark).

It returns 0 on success, 1 on failure.
"""

import fileinput
import sys
from unicodedata import category

MAX_LINE_LENGTH = 80

def clean(line):
    """Prepare the line to be measured.

    See https://lists.gnu.org/archive/html/bug-gettext/2025-10/msg00010.html
    about hiding spaces before colon.
    """
    line =  "".join(char for char in line if category(char) != "Mn").rstrip("\n")
    line = line.replace(" :", " :")  # It's not allowed to split a line before `:`
    return line


return_code = 0

for line in fileinput.input(encoding="utf-8"):
    line = clean(line)

    if line.count(" ") <= 2:
        continue  # Could be hard to break.
    if len(line) > MAX_LINE_LENGTH:
        print(
            f"{fileinput.filename()}:{fileinput.filelineno()} line too long "
            f"({len(line)} > {MAX_LINE_LENGTH} characters)",
            file=sys.stderr,
        )
        return_code = 1


sys.exit(return_code)
