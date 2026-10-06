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
  section.title { position: relative; padding: 45px 126px 0 69px; justify-content: flex-start; text-align: left; color: #000; font-family: Arial, "Liberation Sans", Helvetica, sans-serif; }
  section.title h1 { font-size: 38px; font-weight: normal; line-height: 1.2; color: #000; margin: 0 0 6px; }
  section.title h3 { font-size: 27px; font-weight: normal; line-height: 1.2; color: #000; margin: 0; }
  section.title p { font-size: 21px; line-height: 1.2; margin: 0 0 28px; }
  section.title p:first-of-type { margin: 0; }
  section.title p:nth-of-type(2) { margin-top: 36px; }
  section.title img { position: absolute; top: 6px; left: 11px; }
---

<!-- _class: title -->
<!-- _paginate: false -->

# $(meta title)

![w:757](img/EU_MSMT_en_col.png)

$(s=$(meta subtitle); [ -n "$s" ] && echo "### $s")

$(meta author)\\
$(meta institute)

$(meta date)

$(meta venue)

EOF
    # body: everything after the closing `---` of the YAML block
    awk 'n>=2 {print; next} /^---$/ {n++}' "$SRC"
} > "$TMP"

marp "$TMP" --pdf --allow-local-files -o "$OUT"
