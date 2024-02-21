#!/usr/bin/env bash

#read -r -d '' watched_files << EOM
#main-two-col.tex
#EOM

read -r -d '' watched_files << EOM
altacv.cls
main-two-col.tex
EOM

echo -e "$watched_files" | entr -s "./tools/build.sh"