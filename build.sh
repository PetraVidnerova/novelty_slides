#!/usr/bin/env bash
# Build the talk slides (Beamer) from slides.md.
# mainfont override: the default Latin Modern font lacks glyphs for ρ, ≈, ≠ and xelatex drops them silently.
set -euo pipefail
cd "$(dirname "$0")"

pandoc slides.md -t beamer --slide-level=2 -o slides.pdf \
    --pdf-engine=xelatex -V mainfont="DejaVu Serif"
