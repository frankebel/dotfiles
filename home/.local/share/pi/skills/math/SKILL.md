---
name: math
description: >-
  Math conventions.
  Use whenever writing math or a derivation,
  in LaTeX, Markdown, docstrings, or code comments.
---

# Math

## Derivations

- Show every intermediate step of a derivation in the document,
  one manipulation per line in an `align` block,
  and number every line as a sub-equation of one parent
  (`1.1`, `1.2`, ...),
  so that a single step can be referenced.
  In LaTeX, wrap the `align` in `subequations`,
  patch `\theequation` to `\theparentequation.\arabic{equation}`,
  and put the label of the derivation on the `subequations` environment.
  Name the step in words next to it when it is not obvious:
  what was inserted, which identity was used, which terms were regrouped.
- Insert definitions explicitly before simplifying,
  and mark a term that vanishes with the reason
  (an underbrace with the equation number, or a sentence).
- Never collapse a product, sum, or average of several terms
  into a regrouped form in one step.
  Expand first, reorder second, regroup third, each on its own line.
- This applies to LaTeX, Markdown, and docstrings alike.

## LaTeX

- Use upright forms for mathematical constants.
  Examples: `\mathrm{i}` for imaginary unit,
  `\mathrm{e}` for Euler's constant.

## Math in Comments

- Write math in code comments and plain-text docstrings in LaTeX-like notation
  that matches the accompanying document or docstring.
- Brace subscripts and superscripts of more than one character
  (`M_{cc,k}`, `ϵ_{mf}`, `G_{imp}^{-1}`),
  and leave single characters unbraced (`δ_k`, `X_k`, `B_k^†`).
