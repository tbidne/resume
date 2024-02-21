#!/usr/bin/env bash

#read -r -d '' watched_files << EOM
#tbidne_resume.tex
#EOM

read -r -d '' watched_files << EOM
altacv.cls
tbidne_resume.tex
EOM

echo -e "$watched_files" | entr -s "./tools/build.sh"