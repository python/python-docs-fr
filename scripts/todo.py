#!/bin/python3

import statistics

from pathlib import Path

try:
    import polib
    import requests
except ImportError:
    print("You need to install polib and requests to be able to run make todo.")
    exit(1)


def main():
    issues = requests.get(
        "https://api.github.com/repos/python/python-docs-fr/issues"
    ).json()
    reservations = {
        issue["title"].split()[-1]: issue["user"]["login"] for issue in issues
    }

    po_files = list(Path(".").glob("**/*.po"))

    po_files_per_directory = {
        path.parent.name: set(path.parent.glob("*.po")) for path in po_files
    }

    for directory, po_files in sorted(po_files_per_directory.items()):
        print("\n\n# " + directory)
        folder_stats = []
        for po_file in sorted(po_files):
            stats = polib.pofile(po_file)
            po_file_stat = stats.percent_translated()
            if po_file_stat == 100:
                folder_stats.append(po_file_stat)
                continue
            print(
                f"{po_file.name:<30}",
                f"{len(stats.translated_entries()):3d} / {len(stats):3d}",
                f"({po_file_stat:5.1f}% translated)",
                f"{len(stats.fuzzy_entries())} fuzzy" if stats.fuzzy_entries() else "",
                f"Réservé par {reservations[str(po_file)]}"
                if str(po_file) in reservations
                else "",
            )
            folder_stats.append(po_file_stat)
        # TODO: Have the percentage printed next to the folder name
        print("\n{}% done.".format(round(statistics.mean(folder_stats), 2)))


if __name__ == '__main__':
    # TODO: Add PR handling
    # TODO: Add total from all folders
    main()
