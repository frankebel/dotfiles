# Global Instructions

## Date & Time

- When a question involves the current date or year,
  confirm it with `date` (or `date -u`) first
  rather than assuming from context or prior messages.

## Environment

- Dotfiles (incl. shell env) are synced to the SLURM cluster,
  so environment variables are available on every host.

## Git

- Never stage (`git add`) or commit unless the user explicitly approves.
  Prepare the change (edits, checks) and present it for approval
  before staging or committing.
- Run every check that applies to the files a commit touches,
  and report what each one printed.
  A rule without a command is still a check:
  verify it instead of assuming it holds.
- Set `GIT_SEQUENCE_EDITOR` and `GIT_EDITOR` when scripting `rebase -i`,
  and pass `-m` to `git tag`,
  which `tag.gpgsign` makes annotated and therefore editor-opening.
  `GIT_EDITOR=true` writes an empty message, which git rejects.
- Follow [Conventional Commits](https://www.conventionalcommits.org):
  `type(scope): subject`.
- Keep commits atomic: one logical change per commit.
- A header usually suffices;
  add a body only when the change is unclear without it.
- Tell the reader why (and add context),
  never restate what the diff already shows.

## Julia

- Run `jetls check <file>` from the project root
  on the Julia files you edit.
- `Pkg.resolve` and `Pkg.instantiate` write a `[sources]` block
  of absolute local paths into the tracked `Project.toml`.
  Strip it before staging,
  otherwise the machine's directory layout lands in the repository.

### Docstrings

- Follow the official Julia style guide
  ([Writing Documentation](https://docs.julialang.org/en/v1/manual/documentation/)).
- Use the short-form signature (no type annotations)
  for closely-related bindings
  (e.g. `evaluate_gaussian`/`evaluate_lorentzian`).
- Give a type the `Type <: Super` docstring signature
  and the outer constructor its own docstring (`Type(args)`)
  when it has meaningful behavior (e.g. defaults).

### File Structure

Within each file,
group the definitions in this order,
with functions sorted alphabetically inside each block:

- define the struct with potential inner creator

- outer creators

- methods using the struct

- `Base` functions using the struct

- other modules (e.g. `LinearAlgebra`) using the struct

### Formatting

- Run `runic --check` on every Julia file you edit
  and leave no formatting violations.
- Keep lines under 92 characters.
- When a function definition or call is too wide to fit in 92 characters,
  place each argument on its own line
  with a trailing comma after every argument (including the last).

### Tests

- Run the tests that cover your change,
  preferring the targeted subset over the full suite,
  before reporting it done.
- Prefer hardcoded expected numerical values
  over comparing the function to itself.

## KISS

Keep it simple, stupid. Don't over-engineer stuff.

## LaTeX

- Use upright forms for mathematical constants.
  Examples: `\mathrm{i}` for imaginary unit,
  `\mathrm{e}` for Euler's constant.

## Markdown

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
  grep -nE '\. [A-Z`]' FILE.md                               # sentence not on a new line
  awk 'length>100 && !/http/ {print FNR": "length}' FILE.md  # too long, ignoring URLs
  ```

  Then read every line ending:
  it should fall on punctuation or a phrase boundary,
  never split a subject from its verb or a noun from its modifier.

- Sort sections alphabetically in `AGENTS.md` files.
  This file serves as a reference.

## Pi Config Location

The pi config directory is given by the `PI_CODING_AGENT_DIR` environment variable
(not `~/.pi/agent`).

## Style

- Keep responses concise.
- Insert a space between a number and its unit prefix
  (per BIPM's official guideline:
  "25 M", "3 kg", "5 km", not "25M", "3kg", "5km").
- Label shell code with the most specific language that fits:
  `sh` / `#!/bin/sh` for POSIX shell,
  `bash` / `#!/bin/bash` only when bash-specific features are used.
