<div align="center">

# Resume

[![ci](http://img.shields.io/github/actions/workflow/status/tbidne/resume/ci.yaml?branch=main)](https://github.com/tbidne/resume/actions/workflows/ci.yaml)

</div>

# Intro

This is a flake for building my resume, based on [AltaCV](https://github.com/liantze/AltaCV).

# Building

## Interactively

###### Prerequisites

- `entr`
- `pdflatex`

Assuming we have the dependencies (provided by `nix develop`), we can run the following scripts:

```
# builds the pdf to ./build
./tools/build.sh

# builds the pdf upon changes to altacv.cls and tbidne_resume.tex
./tools/watch.sh
```

## Nix

###### Prerequisites

- `nix`

We can also build the pdf directly with `nix build`.