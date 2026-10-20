#!/usr/bin/env bash
set -euo pipefail

FILE="${1:-main.tex}"
JOB="${FILE%.tex}"

trap 'echo "Build failed. Check ${JOB}.log" >&2' ERR

pdflatex -interaction=nonstopmode -halt-on-error "$FILE"
bibtex "$JOB" || echo "warning: bibtex exited with an error" >&2
pdflatex -interaction=nonstopmode -halt-on-error "$FILE"
pdflatex -interaction=nonstopmode -halt-on-error "$FILE"

echo "Done: ${JOB}.pdf"
