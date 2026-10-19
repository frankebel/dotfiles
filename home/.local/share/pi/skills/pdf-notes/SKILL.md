---
name: pdf-notes
description: >-
  Math notes as LaTeX PDFs.
  Use only when the user asks for a PDF or a tex file.
---

# PDF notes

Create a PDF only on request,
never on your own because an answer contains a derivation.

## Layout

All notes live in `pi-notes/` in the project root
(`git rev-parse --show-toplevel`, or the working directory outside a repository),
one subdirectory per topic, with a short `snake_case` name:

```
<project root>/
└── pi-notes/
    ├── .gitignore           contains `*`, so git ignores the directory, itself included
    └── <topic>/
        ├── <topic>.tex
        ├── <topic>.pdf
        └── <topic>.aux, .log …
```

Create or change nothing outside `pi-notes/`,
so that deleting `pi-notes/` removes every note and build file.
Create `pi-notes/.gitignore` with the single line `*` if it is missing.

## Write

Follow the "Derivations" and "LaTeX" rules of the global `AGENTS.md`.
Write the `.tex` file before compiling it,
in a separate step, never in parallel with the build.

## Build and open

Compile with `lualatex`, unless the user names another engine:

```sh
cd pi-notes/<topic>
latexmk -lualatex -interaction=nonstopmode -halt-on-error <topic>.tex > build.log 2>&1
echo "latexmk: $?"
grep -E '^!|Overfull|Underfull|undefined' <topic>.log
```

Fix every error and warning the `grep` prints, then open the PDF in the user's viewer:

```sh
(setsid "$READER" <topic>.pdf > /dev/null 2>&1 &)
```

## Update

A change to an existing topic edits the same `<topic>.tex` and recompiles it.
Do not open the viewer again: it reloads the PDF when the file changes.

## Clean up

Notes are temporary.
When the task the note belongs to is implemented or resolved,
propose deleting `pi-notes/<topic>` and do it only after the user confirms.
