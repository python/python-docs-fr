#!/bin/python3

import os
from glob import glob

try:
    import polib
except ImportError:
    print("Sorry, you need to install `polib` to be able to run make todo.")
    exit(1)

working_dir = os.path.dirname(os.path.realpath(__file__))

po_files = []
for po_file in glob("**/*.po"):
    po_files.append(po_file)
for po_file in glob("*.po"):
    po_files.append(po_file)


all_po_files = {
    'c-api/': [entry for entry in po_files if 'c-api/' in entry],
    'distributing/': [entry for entry in po_files if 'distributing/' in entry],
    'distutils/': [entry for entry in po_files if 'distutils/' in entry],
    'extending/': [entry for entry in po_files if 'extending/' in entry],
    'faq/': [entry for entry in po_files if 'faq/' in entry],
    'howto/': [entry for entry in po_files if 'howto/' in entry],
    'install/': [entry for entry in po_files if 'install/' in entry],
    'installing/': [entry for entry in po_files if 'installing/' in entry],
    'library/': [entry for entry in po_files if 'library/' in entry],
    'reference/': [entry for entry in po_files if 'reference/' in entry],
    'tutorial/': [entry for entry in po_files if 'tutorial/' in entry],
    'using/': [entry for entry in po_files if 'using/' in entry],
    'whatsnew/': [entry for entry in po_files if 'whatsnew/' in entry],
    '.': [entry for entry in po_files if '/' not in entry]
}

unfinished_po_files = {
    'c-api/': [[entry, polib.pofile(entry).percent_translated(), len(polib.pofile(entry).untranslated_entries()), len(polib.pofile(entry).translated_entries()), len(polib.pofile(entry).fuzzy_entries())] for entry in all_po_files['c-api/'] if polib.pofile(entry).percent_translated() is not 100],
    'distributing/': [[entry, polib.pofile(entry).percent_translated(), len(polib.pofile(entry).untranslated_entries()), len(polib.pofile(entry).translated_entries()), len(polib.pofile(entry).fuzzy_entries())] for entry in all_po_files['distributing/'] if polib.pofile(entry).percent_translated() is not 100],
    'distutils/': [[entry, polib.pofile(entry).percent_translated(), len(polib.pofile(entry).untranslated_entries()), len(polib.pofile(entry).translated_entries()), len(polib.pofile(entry).fuzzy_entries())] for entry in all_po_files['distutils/'] if polib.pofile(entry).percent_translated() is not 100],
    'extending/': [[entry, polib.pofile(entry).percent_translated(), len(polib.pofile(entry).untranslated_entries()), len(polib.pofile(entry).translated_entries()), len(polib.pofile(entry).fuzzy_entries())] for entry in all_po_files['extending/'] if polib.pofile(entry).percent_translated() is not 100],
    'faq/': [[entry, polib.pofile(entry).percent_translated(), len(polib.pofile(entry).untranslated_entries()), len(polib.pofile(entry).translated_entries()), len(polib.pofile(entry).fuzzy_entries())] for entry in all_po_files['faq/'] if polib.pofile(entry).percent_translated() is not 100],
    'howto/': [[entry, polib.pofile(entry).percent_translated(), len(polib.pofile(entry).untranslated_entries()), len(polib.pofile(entry).translated_entries()), len(polib.pofile(entry).fuzzy_entries())] for entry in all_po_files['howto/'] if polib.pofile(entry).percent_translated() is not 100],
    'install/': [[entry, polib.pofile(entry).percent_translated(), len(polib.pofile(entry).untranslated_entries()), len(polib.pofile(entry).translated_entries()), len(polib.pofile(entry).fuzzy_entries())] for entry in all_po_files['install/'] if polib.pofile(entry).percent_translated() is not 100],
    'installing/': [[entry, polib.pofile(entry).percent_translated(), len(polib.pofile(entry).untranslated_entries()), len(polib.pofile(entry).translated_entries()), len(polib.pofile(entry).fuzzy_entries())] for entry in all_po_files['installing/'] if polib.pofile(entry).percent_translated() is not 100],
    'library/': [[entry, polib.pofile(entry).percent_translated(), len(polib.pofile(entry).untranslated_entries()), len(polib.pofile(entry).translated_entries()), len(polib.pofile(entry).fuzzy_entries())] for entry in all_po_files['library/'] if polib.pofile(entry).percent_translated() is not 100],
    'reference/': [[entry, polib.pofile(entry).percent_translated(), len(polib.pofile(entry).untranslated_entries()), len(polib.pofile(entry).translated_entries()), len(polib.pofile(entry).fuzzy_entries())] for entry in all_po_files['reference/'] if polib.pofile(entry).percent_translated() is not 100],
    'tutorial/': [[entry, polib.pofile(entry).percent_translated(), len(polib.pofile(entry).untranslated_entries()), len(polib.pofile(entry).translated_entries()), len(polib.pofile(entry).fuzzy_entries())] for entry in all_po_files['tutorial/'] if polib.pofile(entry).percent_translated() is not 100],
    'using/': [[entry, polib.pofile(entry).percent_translated(),w len(polib.pofile(entry).untranslated_entries()), len(polib.pofile(entry).translated_entries()), len(polib.pofile(entry).fuzzy_entries())] for entry in all_po_files['using/'] if polib.pofile(entry).percent_translated() is not 100],
    'whatsnew/': [[entry, polib.pofile(entry).percent_translated(), len(polib.pofile(entry).untranslated_entries()), len(polib.pofile(entry).translated_entries()), len(polib.pofile(entry).fuzzy_entries())] for entry in all_po_files['whatsnew/'] if polib.pofile(entry).percent_translated() is not 100],
    '.': [[entry, polib.pofile(entry).percent_translated(), len(polib.pofile(entry).untranslated_entries()), len(polib.pofile(entry).translated_entries()), len(polib.pofile(entry).fuzzy_entries())] for entry in all_po_files['.'] if polib.pofile(entry).percent_translated() is not 100],
}

for key, content in unfinished_po_files.items():
    if content:
        print("\n\n" + key)
        for item in content:
            print(f"{item[0]:<35} -> {item[1]:5.1f}% translated, {item[2]} entries are not translated,"
                  f" {item[3]:5.1f} entries are translated, {item[4]:5.1f} entries are Fuzzy.".format())
