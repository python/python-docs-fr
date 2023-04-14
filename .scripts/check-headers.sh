#!/bin/sh

if [ -z "$*" ]
then
    exit 0
fi

grep -L '^# Copyright (C) [0-9-]*, Python Software Foundation' $* | while read -r file
do
    echo "Please update the po comment in $file"
done
grep -L '^"Project-Id-Version: Python 3\\n"$' $* | while read -r file
do
    echo "Please update the 'Project-Id-Version' header in $file"
done
grep -L '^"Language: fr\\n"$' $* | while read -r file
do
    echo "Please update the 'Language' header in $file"
done
grep -L '^"Language-Team: FRENCH <traductions@lists.afpy.org>\\n"' $* | while read -r file
do
    echo "Please update the 'Language-Team' header in $file"
done
