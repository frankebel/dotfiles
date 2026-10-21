---
name: git
description: >-
  Git conventions.
  Use whenever writing a commit message or pull request, rebasing, tagging,
  or checking that a test fails without a fix.
---

# Git

`CONTRIBUTING.md` in the repository root wins where it conflicts with these rules.

## Baseline for a fix

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

## Rebase and tags

- Set `GIT_SEQUENCE_EDITOR` and `GIT_EDITOR` when scripting `rebase -i`,
  and pass `-m` to `git tag`,
  which `tag.gpgsign` makes annotated and therefore editor-opening.
  `GIT_EDITOR=true` writes an empty message, which git rejects.
- Do not create backup tags or branches before a rebase:
  `ORIG_HEAD` and the reflog already hold the old state,
  and `rebase.updateRefs` would move a backup branch along with the rebase.

## Commit messages and pull requests

- Follow [Conventional Commits](https://www.conventionalcommits.org):
  `type(scope): subject`.
  In a Julia package, the scope is the submodule the change lives in,
  spelled like the module (`Solvers`, not `solvers`);
  leave it out for the top-level module,
  and never use a file name.
- Put code names (functions, types, variables, operators) in backticks,
  in commit headers and bodies alike:
  ``fix: handle empty input in `parse` ``.
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
- Break commit and pull request bodies like Markdown:
  one sentence per line, broken at commas or phrase boundaries,
  never wrapped at a fixed column such as 72.
  Run the two checks of the markdown skill on the message file before committing.
- Title a pull request like a commit header.
  Keep its body short:
  one or two sentences on what was wrong or missing,
  then at most three bullets on what changed.
  Leave out what the commit list already shows,
  such as refactors, helper fixes, or benchmarks,
  unless a reviewer needs it to judge the change.
