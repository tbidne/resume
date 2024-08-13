#!/usr/bin/env bash

raw_results=$(
  aspell  \
    -d $SPELL_DICT \
    --mode=tex \
    --add-wordlists tools/extra_words.txt \
    -a < tex/tbidne_resume.tex
  )

num_failed=0
while IFS= read -r line; do
  if [[ "$line" == "&"* ]]; then
    echo -e "$line\n"
    num_failed=$((num_failed + 1))
  fi
done <<< "$raw_results"

if [[ $num_failed -gt 0 ]]; then
  echo "Found ${num_failed} mis-spelling(s)."
  exit 1
else
  echo "No mis-spellings detected."
  exit 0
fi
