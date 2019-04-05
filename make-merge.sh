#!/usr/bin/env bash
rm -rf /tmp/cpython
git clone --depth 1 --branch 3.7 --single-branch https://github.com/python/cpython /tmp/cpython

CPYTHON_LATEST_SHA=$(git -C /tmp/cpython rev-parse --short HEAD)

git checkout -b make-merge-$CPYTHON_LATEST_SHA

sed -i "s/COMMIT=[a-z0-9]*/COMMIT=$CPYTHON_LATEST_SHA/" .travis.yml

make merge

pip install pyhub-pr

git add -A

git commit -m "merge pot files."

git push --set-upstream origin make-merge-$CPYTHON_LATEST_SHA

pyhub_pr --organisation python --repo python-docs-fr --token $GITHUB_TOKEN --title "Merge from upstream doc" --body "This PR was created from the command line with pyhub-pr." --head $TOKEN_OWNER_USERNAME:make-merge-$(git rev-parse --short HEAD)
