read -r -d '' watched_files << EOM
altacv.cls
main-two-col.tex
EOM

echo -e "$watched_files" | entr -s "pdflatex main-two-col.tex"