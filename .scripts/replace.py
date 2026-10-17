#!/usr/bin/env python
"""Search and replace in msgstrs."""

import sys
from pathlib import Path

import polib


def replace(file: Path, from_str: str, to_str: str) -> None:
    try:
        pofile = polib.pofile(file)
    except OSError:
        print(f"{file} doesn't seem to be a .po file", file=sys.stderr)
        return
    for entry in pofile:
        entry.msgstr = entry.msgstr.replace(from_str, to_str)
    pofile.save()


def parse_args():
    import argparse

    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("from_str", help="Replace occurrences of this string")
    parser.add_argument(
        "to_str",
        help="with this string.",
    )
    parser.add_argument("path", nargs="*", type=Path)
    return parser.parse_args()


def main():
    args = parse_args()
    for filename in args.path:
        replace(filename, args.from_str, args.to_str)


if __name__ == "__main__":
    main()
