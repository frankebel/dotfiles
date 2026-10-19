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
- Re-read a file right before changing it,
  and change it with targeted edits instead of rewriting it whole,
  so edits I made since you last read it survive.
  Rewrite a whole file only when it is new or I ask for it.
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

1. Read `CONTRIBUTING.md` in the repository root, if it exists, and follow it;
   where it conflicts with these rules, it wins.
2. Open a branch.
3. Implement one fix or feature, with its tests.
4. Run the checks that apply (tests, `runic`, `jetls`, formatters).
5. Create the pull request.
6. Update the changelog if the change is user-visible.
7. Wait for the pipelines to pass.
8. Stop there.
   Merging is the code owner's decision:
   I merge to `main` locally and push on repositories I own,
   and on someone else's repository the pull request is where my work ends.

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
- Check the repository state (`git status`, `git log`) before describing it,
  instead of carrying it over from an earlier turn:
  I may have committed, merged, or pushed in the meantime.
- Before committing or tagging, check that the signing key is unlocked,
  without triggering a passphrase prompt:

  ```sh
  gpg --batch --pinentry-mode error --local-user "$(git config user.signingkey)" \
      --sign < /dev/null > /dev/null
  ```

  If it fails, ask me to unlock the key instead of committing,
  and never fall back to `--no-gpg-sign`.

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

- Delete files and directories with `trash` instead of `rm`,
  so that a deletion can be undone with `trash-restore`.
  Fall back to `rm` only where `trash` is not installed.

## Style

- Keep responses concise.
- Insert a space between a number and its unit prefix
  (per BIPM's official guideline:
  "25 M", "3 kg", "5 km", not "25M", "3kg", "5km").
- Draw structures and operations (trees, pointers, bit patterns, data flow)
  as ASCII art in a code block instead of describing them in prose
  or as an indented list.
  Pick the form that fits the content, e.g. a tree for nested structures

  ```
        root
       /    \
      A      B
     / \      \
    1   2      3
  ```

  and aligned columns for bit operations:

  ```
  site       3 2 1 0
  s          1 1 0 1
  mask       0 0 1 1
  ------------------
  s & mask   0 0 0 1
  ```

## Tests

- Run the tests that cover your change,
  preferring the targeted subset over the full suite,
  before reporting it done.
