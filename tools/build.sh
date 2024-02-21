#!/usr/bin/env bash

mkdir -p build

cd tex

pdflatex -halt-on-error -output-directory ../build tbidne_resume.tex

cd ../