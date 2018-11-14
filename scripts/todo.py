#!/bin/python3

import subprocess

p2 = subprocess.run(['scripts/todo.sh'], encoding='utf-8', shell=True, stdout=subprocess.PIPE)
output = p2.stdout.split('\n')

folders = {
    'c-api/': [entry for entry in output if 'c-api/' in entry],
    'distributing/': [entry for entry in output if 'distributing/' in entry],
    'distutils/': [entry for entry in output if 'distutils/' in entry],
    'extending/': [entry for entry in output if 'extending/' in entry],
    'faq/': [entry for entry in output if 'faq/' in entry],
    'howto/': [entry for entry in output if 'howto/' in entry],
    'install/': [entry for entry in output if 'install/' in entry],
    'installing/': [entry for entry in output if 'installing/' in entry],
    'library/': [entry for entry in output if 'library/' in entry],
    'reference/': [entry for entry in output if 'reference/' in entry],
    'tutorial/': [entry for entry in output if 'tutorial/' in entry],
    'using/': [entry for entry in output if 'using/' in entry],
    'whatsnew/': [entry for entry in output if 'whatsnew/' in entry],
    '/': [entry for entry in output if '/' not in entry]
}

for key, content in folders.items():
    if content:
        print("\n\n" + key)
        for item in content:
            print(item)
