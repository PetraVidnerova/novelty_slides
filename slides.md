---
title: Measuring Scientific Novelty through Conceptual Distance and Knowledge Recombination
author: Petra Vidnerová, Roman Neruda, Jiří Šejnoha
institute: Institute of Computer Science, The Czech Academy of Sciences
date: "October 8, 2026"
---

<!--
Skeleton for a 25-minute talk (~19 main slides + backup).
Build (Beamer):  pandoc slides.md -t beamer --slide-level=2 -o slides.pdf --pdf-engine=xelatex -V mainfont="DejaVu Serif"
Conventions: `# ` = section, `## ` = slide. [TODO] = content still to write, [FIG] = figure placeholder.
Time budget per section is given in the section comment; the total is 25 min.
-->

# Introduction

<!-- ~4 min, 3 slides -->

## Why measure novelty?

- [TODO: motivation: research assessment, funding, science of science]
- [TODO: novelty ≠ quality ≠ impact: set the vocabulary early]
- [FIG: optional teaser image]

## What does "novel" mean?

- [TODO: novelty as recombination of existing knowledge (Schumpeter → Uzzi et al. 2013)]
- [TODO: two intuitions: *what* is combined vs. *how far* the paper moves from it]

## Talk outline

1. Existing novelty indicators
2. The novelty challenge
3. Our indicators: conceptual distance & recombination
4. Results: correlations
5. Conclusions

# Existing indicators

<!-- ~3.5 min, 3 slides -->

## Combinatorial indicators

- [TODO: Uzzi et al. 2013: atypical journal-pair combinations (z-scores)]
- [TODO: Lee et al. 2015: commonness of journal pairs]
- [TODO: Wang et al. 2017: new journal pairs, weighted by distance]
- [TODO: Foster et al. 2015: [one-line description]]
- [FIG: schematic: paper → references → journal pairs]

## Limitations of the combinatorial approach

- [TODO: discrete co-occurrence, depends on journal category schemes]
- [TODO: needs a reference corpus/baseline; weak for papers with few references]
- [TODO: ignores the *content* of references]

## Embedding-based alternatives

- [TODO: semantic distance in a continuous space instead of pair rarity]
- [TODO: prior work using embeddings for novelty: citations]
- [TODO: gap: usually reported as a single number; the choice of facet is implicit]

# The novelty challenge

<!-- ~2.5 min, 2 slides -->

## The challenge

- [TODO: who organised it, goal, task definition]
- [TODO: what was provided / what was expected as output]

## Data

- [TODO: 100 000 papers: title, abstract, DOI, OpenAlex ID, journal, date]
- [TODO: field & year composition]
- 98 291 papers with usable references (1 455 without references, 254 without valid references, 4 051 scored from titles only)
- [FIG/TABLE: corpus description (T1)]

# Our indicators

<!-- ~5 min, 4 slides -->

## Pipeline

- SPECTER2 embeddings (`allenai/specter2_base` + `specter2` adapter) of title + abstract
- References retrieved from OpenAlex; titles-only fallback when no abstract is available
- [FIG: pipeline diagram: paper → OpenAlex refs → SPECTER2 → distances]

## Conceptual distance: `paper_ref`

- $\text{paper\_ref} = 1 - \frac{1}{n}\sum_i \cos(\mathbf{r}_i, \mathbf{p})$
- How far the paper departs from the knowledge base it cites
- [FIG: 2-D sketch: paper point vs. cloud of references]

## Knowledge recombination: `ref_ref` and `ref_spread`

- `ref_ref`: mean pairwise $1 - \cos(\mathbf{r}_i, \mathbf{r}_j)$ over references: heterogeneity of the material combined
- `ref_spread`: standard deviation of the same pairwise matrix
- [FIG: 2-D sketch: tight vs. dispersed reference cloud]

## Descriptive statistics

- `paper_ref`: mean 0.093 (sd 0.017)
- `ref_ref`: mean 0.108 (sd 0.020)
- `ref_spread`: mean 0.040
- Median number of references: 25
- [FIG: F1: distributions of the three facets]

# Results

<!-- ~7 min, 5 slides -->

## Are the facets distinct?

- [TODO: inter-facet correlation matrix]
- [FIG: F2: correlation heatmap]

## Comparison with established indicators

- [TODO: correlations with Uzzi / Lee / Foster / Wang (novelpy)]
- [FIG: F3]

## Journal standing: paper level

- [TODO: key message: `ref_ref` weakly positive, `paper_ref` ≈ 0]
- [TABLE: SJR, quartile, h-index, cites/doc, OpenAlex citedness × facets (§5.3)]
- [FIG: F4: heatmap facets × journal metrics]

## Journal standing: journal level

- [TODO: `ref_ref` vs. SJR / citedness at ≥1, ≥5, ≥20 papers per journal]
- [FIG: F6: journal-level scatter, mean facet vs. SJR (log)]
- [FIG: F5: facet by SJR quartile, boxplots]
- [TODO: ecological-fallacy caveat]

## Composite indices depend on normalization

- [TODO: `novelty_max = max(norm(paper_ref), norm(ref_ref))`]
- [TABLE: normalization vs. share won by `ref_ref` vs. ρ (§5.5)]
- [TODO: key message: the reported correlation varies about fivefold with the normalization choice]

# Conclusion

<!-- ~2 min, 2 slides -->

## Take-home messages

- [TODO: conceptual distance and recombination behave differently]
- [TODO: report facets separately; state the normalization]
- [TODO: small effects: direction and consistency, not prediction]

## Limitations & next steps

- [TODO: field controls, second embedding model, bootstrap CIs, journal matching]

## Thank you

- [TODO: contact, links (HF Space, datasets), acknowledgement]

# Backup

## Backup: full correlation table

- [TABLE: T2]

## Backup: `ref_spread`

- [TODO]
