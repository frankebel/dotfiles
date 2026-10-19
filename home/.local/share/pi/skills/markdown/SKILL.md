---
name: markdown
description: >-
  Markdown conventions.
  Use whenever writing or editing Markdown, including commit and pull request bodies.
---

# Markdown

- Run `prettier` as a formatter on Markdown files.
  It does not check line breaks,
  because `proseWrap` defaults to `preserve`,
  so a clean `prettier` run says nothing about the two rules below.
  Never set `proseWrap: always`,
  which reflows to a fixed width and destroys the semantic breaks.
- Break lines at logical locations
  (commas, brackets, sentence ends)
  rather than in the middle of words or arbitrary positions.
  Start a new sentence on a new line.
  Take this file as a reference.
- Keep lines under ~100 characters
  (URLs, LaTeX, code blocks, and tables may exceed this when longer lines read better).
- Verify both rules on every Markdown file you touch,
  including files outside the repository such as commit or pull request bodies:

  ```sh
  # sentence not on a new line, ignoring list markers and e.g./i.e.
  grep -nE '[^0-9]\. [A-Z`]' FILE.md | grep -vE '\b[ei]\.[ge]\. '
  # too long, ignoring URLs
  awk 'length>100 && !/http/ {print FNR": "length}' FILE.md
  ```

  Then read every line ending:
  it should fall on punctuation or a phrase boundary,
  never split a subject from its verb or a noun from its modifier.

- Sort sections alphabetically in `AGENTS.md` files.
  The global `AGENTS.md` serves as a reference.
