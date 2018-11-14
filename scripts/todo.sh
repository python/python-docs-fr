#!/usr/bin/env bash

for file in *.po */*.po
    do echo $(msgattrib --untranslated $file | grep ^msgid | sed 1d | wc -l ) $file
done | grep -v ^0 | sort -gr
