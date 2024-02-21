#!/usr/bin/env bash

read -r -d '' watched_files << EOM
tex/custom.cls
tex/tbidne_resume.tex
EOM

echo -e "$watched_files" | entr -s "./tools/build.sh"