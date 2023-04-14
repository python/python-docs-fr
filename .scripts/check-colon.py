#!/usr/bin/env python
"""Check consistency of colons at the end of entries.

It returns 0 if nothing was done, 1 if files were modified.
"""
import sys
import pathlib
import polib


def colon_is_visible(msg):
    if msg.endswith(": ::"):
        return True
    if msg.endswith(" ::"):
        return False
    if msg.endswith("::"):
        return True
    raise ValueError("Don't know if msg ends with a visible or an invisible colon.")


def fix_double_colon(filename, entry, check, verbose):
    fixed = entry.msgstr.rstrip(": \u202f\u00A0")
    if colon_is_visible(entry.msgid):
        fixed += "\u00A0::"
        message = r"Expected translation to end with: '\u00A0::'"
    else:
        fixed += " ::"
        message = "Expected translation to end with: ' ::'"
    if entry.msgstr != fixed:
        if check:
            print(f"{filename}:{entry.linenum}: {message}")
            if verbose:
                print(entry)
        else:
            entry.msgstr = fixed
        return True
    return False


def fix_simple_colon(filename, entry, check, verbose):
    fixed = entry.msgstr.rstrip(": \u202f\u00A0")
    fixed += "\u00A0:"
    if entry.msgstr != fixed:
        if check:
            print(
                rf"{filename}:{entry.linenum}: Expected translation to end with: '\u00A0:'"
            )
            if verbose:
                print(entry)
        else:
            entry.msgstr = fixed
        return True
    return False


def check(filename, check, verbose):
    try:
        pofile = polib.pofile(filename)
    except OSError:
        print(f"{filename} doesn't seem to be a .po file", file=sys.stderr)
        return True
    has_errors = False
    for entry in pofile:
        if not entry.msgstr:
            continue  # No need to check untranslated entries.
        if entry.msgid.endswith("::"):
            has_errors |= fix_double_colon(filename, entry, check, verbose)
        elif entry.msgid.endswith(":"):
            has_errors |= fix_simple_colon(filename, entry, check, verbose)

    if not check and has_errors:
        pofile.save()
    return has_errors


def parse_args():
    import argparse

    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--check",
        action="store_true",
        default=False,
        help="only display suspected entries, do not fix.",
    )
    parser.add_argument(
        "--verbose",
        action="store_true",
        default=False,
        help="display whole entry",
    )
    parser.add_argument("path", nargs="*")
    return parser.parse_args()


def main():
    has_errors = False
    args = parse_args()
    for filename in args.path:
        has_errors |= check(filename, args.check, args.verbose)
    sys.exit(has_errors)


if __name__ == "__main__":
    main()
