#!/bin/sh

if [ -z "$*" ]
then
    exit 0
fi

grep -L '^# Copyright (C) [0-9-]*,\? Python Software Foundation' $* | while read -r file
do
    cat <<EOF

Please update the po comment in $file using:

    sed -i '1i # Copyright (C) $(date +%Y), Python Software Foundation' "$file"
EOF
done


grep -l '^# SOME DESCRIPTIVE TITLE' $* | while read -r file
do
    cat <<EOF

Please clean the po comment in $file using:

    sed -i '/^# SOME DESCRIPTIVE TITLE/d' "$file"

EOF
done


grep -l '^# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.' $* | while read -r file
do
    cat <<EOF

Please clean the po comment in $file using:

    sed -i '/^# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR./d' "$file"

EOF
done


grep -L '^"Project-Id-Version: Python 3\\n"$' $* | while read -r file
do
    cat <<EOF

Please update the 'Project-Id-Version' header in $file using:

    sed -i 's/^"Project-Id-Version:.*"$/"Project-Id-Version: Python 3\\\\n"/' $file

EOF


done
grep -L '^"Language: fr\\n"$' $* | while read -r file
do
    cat <<EOF
Please update the 'Language' header in $file using:

    sed -i 's/^.Language-Team.*/\\0\\n"Language: fr\\\\n"/' $file

EOF
done
grep -L '^"Language-Team: FRENCH <traductions@lists.afpy.org>\\n"' $* | while read -r file
do
    cat <<EOF
Please update the 'Language-Team' header in $file using:

    sed -i 's/"Language-Team: LANGUAGE <LL@li.org>\\\\n"/"Language-Team: FRENCH <traductions@lists.afpy.org>\\\\n"/' $file

EOF
done
