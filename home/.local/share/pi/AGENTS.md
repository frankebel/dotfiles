# Global Instructions

## Corrections

- When my statement conflicts with an earlier assumption of yours,
  my statement wins.
  Do not look for a reading that saves the assumption,
  and reread what I wrote instead of rechecking your own interpretation.
- A direct edit of the working tree is deliberate,
  even a small change inside a file I just wrote.
  An unexpected difference from what I last showed you
  is your edit, not corruption or a race:
  never revert it, "repair" it, or claim it without asking.
- Before staging, re-check the working tree
  against the diff I presented for approval.
  If they diverge, stop and ask instead of committing.

## Date & Time

- When a question involves the current date or year,
  confirm it with `date` (or `date --utc`) first
  rather than assuming from context or prior messages.

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

## Environment

- Dotfiles (incl. shell env) are synced to the SLURM cluster,
  so environment variables are available on every host.
- When a developer tool is missing,
  tell me and name the official Arch package to install with `pacman`.
  Never install it yourself.

## Git

The workflow for a change:

1. Open a branch.
2. Implement one fix or feature, with its tests.
3. Run the checks that apply (tests, `runic`, `jetls`, formatters).
4. Create the pull request.
5. Update the changelog if the change is user-visible.
6. Wait for the pipelines to pass.
7. Stop there.
   Merging is the code owner's decision:
   I merge to `main` locally and push on repositories I own,
   and on someone else's repository the pull request is where my work ends.

- Take the baseline from the commit the branch started from,
  never from `HEAD` and never from `main`,
  when checking that a test fails without the fix:

  ```sh
  cp src/FILE.jl /tmp/FILE.jl
  git show "$(git merge-base main HEAD)":src/FILE.jl > src/FILE.jl
  # run the test, then
  cp /tmp/FILE.jl src/FILE.jl && diff -q src/FILE.jl /tmp/FILE.jl
  ```

  `HEAD` is the baseline only while the fix is unstaged,
  and silently becomes the fixed state once it is committed,
  which makes the check pass for the wrong reason.
  `main` moves on as other work merges,
  so it can carry changes to the same file.
  Copy the file instead of reaching for `git restore`,
  whose second call restores from the index
  and therefore destroys a fix that is not yet staged.

- Never stage (`git add`) or commit unless the user explicitly approves.
  Prepare the change (edits, checks) and present it for approval
  before staging or committing.
- Run every check that applies to the files a commit touches,
  and report what each one printed.
  A rule without a command is still a check:
  verify it instead of assuming it holds.
  Read the diff (`git show` or `git diff`)
  before describing what a change contains,
  and never infer the effect from the commands you ran:
  a sort applied to an already-sorted file changes nothing,
  so the description must come from the diff, not the action.
- Set `GIT_SEQUENCE_EDITOR` and `GIT_EDITOR` when scripting `rebase -i`,
  and pass `-m` to `git tag`,
  which `tag.gpgsign` makes annotated and therefore editor-opening.
  `GIT_EDITOR=true` writes an empty message, which git rejects.
- Follow [Conventional Commits](https://www.conventionalcommits.org):
  `type(scope): subject`.
- Keep commits atomic: one logical change per commit.
- Write the header only.
  Add a body when the diff alone would mislead:
  a breaking change,
  a non-obvious physics or numerics reason,
  or a fix whose cause is not visible in the changed lines.
  The body serves a future reader of `git log`,
  not the reviewer of the current conversation.
  Leave out what belongs in the pull request or the changelog.
- Tell the reader why (and add context),
  never restate what the diff already shows.
- Title a pull request like a commit header.
  Keep its body short:
  one or two sentences on what was wrong or missing,
  then at most three bullets on what changed.
  Leave out what the commit list already shows,
  such as refactors, helper fixes, or benchmarks,
  unless a reviewer needs it to judge the change.

## Julia

- Run `jetls check <file>` from the project root
  on the Julia files you edit.
- Never run `Pkg.develop`, or `Pkg.add` with a path or URL,
  in an environment whose `Project.toml` is tracked:
  they write a `[sources]` block of absolute local paths into it.
  `Pkg.instantiate` and `Pkg.resolve` leave `Project.toml` untouched
  once a `Manifest.toml` exists,
  so reach for those instead.
  Strip a `[sources]` block that appears anyway before staging,
  otherwise the machine's directory layout lands in the repository.
- Do not set up an environment that already resolves.
  Run the build or test command on its own first,
  and instantiate only once it fails on a missing dependency.
  A setup step in a CI workflow is not evidence that one is needed:
  it bootstraps a bare checkout,
  which a working tree is not.

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
  break after the opening parenthesis
  and end the last argument with a trailing comma.
  Give each argument its own line
  when they do not all fit on one continuation line.

### Tests

- Run the tests that cover your change,
  preferring the targeted subset over the full suite,
  before reporting it done.
- Prefer hardcoded expected numerical values
  over comparing the function to itself.

## KISS

Keep it simple, stupid.
Don't over-engineer stuff.

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
  # sentence not on a new line, ignoring list markers and e.g./i.e.
  grep -nE '[^0-9]\. [A-Z`]' FILE.md | grep -vE '\b[ei]\.[ge]\. '
  # too long, ignoring URLs
  awk 'length>100 && !/http/ {print FNR": "length}' FILE.md
  ```

  Then read every line ending:
  it should fall on punctuation or a phrase boundary,
  never split a subject from its verb or a noun from its modifier.

- Sort sections alphabetically in `AGENTS.md` files.
  This file serves as a reference.

## Pacing

- When I ask to go block by block, section by section, bullet by bullet,
  or one-by-one, show a single unit and stop.
  The unit is whatever I named.
- Applying a change does not end the unit,
  and neither does deciding or answering it.
  Show the same unit again afterwards and wait,
  and only move to the next one when I say so.

## Pi Config Location

The pi config directory is given by the `PI_CODING_AGENT_DIR` environment variable
(not `~/.pi/agent`).

## Shell

- Redirect a slow command to a file and inspect the file afterwards,
  instead of piping it straight into `tail` or `grep`.
  A summary that hides the detail forces a second run,
  which costs minutes and reveals nothing the first run did not already produce:

  ```sh
  julia --project=. runtests.jl > /tmp/suite.log 2>&1; echo "exit: $?"
  grep -A18 "Error During Test" /tmp/suite.log
  ```

- Label shell code with the most specific language that fits:
  `sh` / `#!/bin/sh` for POSIX shell,
  `bash` / `#!/bin/bash` only when bash-specific features are used.

## Style

- Keep responses concise.
- Insert a space between a number and its unit prefix
  (per BIPM's official guideline:
  "25 M", "3 kg", "5 km", not "25M", "3kg", "5km").
