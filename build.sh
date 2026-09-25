#!/usr/bin/env bash
# Build slides.pdf from slides.md with Marp.
# slides.md stays in pandoc/Beamer form (YAML title block, `# ` = section, `## ` = slide, no `---`
# separators); this script turns it into a temporary Marp deck: adds Marp front matter with
# headingDivider (new slide at every `#`/`##`) and a title slide built from the YAML block.
set -euo pipefail
cd "$(dirname "$0")"

SRC=slides.md
OUT=slides.pdf
TMP=.slides.marp.md
trap 'rm -f "$TMP"' EXIT

# value of a top-level key in the YAML block, surrounding quotes stripped
meta() { awk -v k="$1:" '/^---$/ {if (++n == 2) exit; next} n == 1 && $1 == k {sub(/^[^:]*:[ \t]*/, ""); gsub(/^"|"$/, ""); print}' "$SRC"; }

{
    cat <<EOF
---
marp: true
theme: default
paginate: true
math: katex
headingDivider: 2
title: $(meta title)
author: $(meta author)
style: |
  h2 { color: var(--h1-color); }
---

<!-- _paginate: false -->

# $(meta title)

$(meta author)

$(meta institute)

$(meta date)

EOF
    # body: everything after the closing `---` of the YAML block
    awk 'n>=2 {print; next} /^---$/ {n++}' "$SRC"
} > "$TMP"

marp "$TMP" --pdf --allow-local-files -o "$OUT"
