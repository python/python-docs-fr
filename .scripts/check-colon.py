import sys
import pathlib
from itertools import chain

import polib


def check(file):
    check = '--check' in sys.argv
    pofile = polib.pofile(file)
    has_errors = False
    for entry in pofile:
        if not entry.msgstr:
            continue
        if entry.msgid.endswith(" ::"):
            fixed = entry.msgstr.rstrip(":  \u202f\u00A0") + " ::"
            if check and entry.msgstr != fixed:
                print(f"{file}:{entry.linenum}: Expected translation to end with: ' ::'")
                has_errors = True
            entry.msgstr = fixed
        elif entry.msgid.endswith("::"):
            fixed = entry.msgstr.rstrip(": ,. \u202f\u00A0") + "\u00A0::"
            if check and entry.msgstr != fixed:
                print(rf"{file}:{entry.linenum}: Expected translation to end with: '\u00A0::'")
                has_errors = True
            entry.msgstr = fixed
    if not check:
        pofile.save()
    return has_errors


has_errors = False
for file in chain(pathlib.Path(".").glob("*.po"), pathlib.Path(".").glob("*/*.po")):
    has_errors |= check(file)

sys.exit(has_errors)
