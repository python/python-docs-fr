#!/usr/bin/env bash

# TODO: venv ?
pip install pyhub-pr

git checkout -b make-merge-$(git rev-parse --short HEAD)

make merge

# TODO: Configure git with correct credentials + config file
git add -A

git commit -m "Merged upstream pot files into this branch"

git push --set-upstream origin make-merge-$(git rev-parse --short HEAD)

pyhub_pr --organisation python --repo python-docs-fr --token $GITHUB_TOKEN --title "Merge from upstream doc" --body "This PR was created from the command line with pyhub-pr." --head $TOKEN_OWNER_USERNAME:make-merge-$(git rev-parse --short HEAD)
