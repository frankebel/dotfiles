You are reviewing an uncommitted change.
The repository is your current working directory, a git worktree.
Run `git diff` to see the change.

## Requirements the change must meet (from the code owner)

REQUIREMENTS

## What to report

- Bugs, and deviations from the requirements
  or from the reference behaviour named in them.
- Lines that can be deleted or replaced by something simpler with the same output.
- Gaps in the tests: behaviour the tests would not catch if it broke.

## Rules

- Every finding needs evidence:
  a command you ran and its output,
  a line of the source it depends on,
  or a test that fails.
  Drop any finding you cannot back with evidence.
- Run the tests with `TEST_COMMAND`.
- Do not edit, create or delete files in the repository,
  and do not run git commands that write
  (commit, checkout, branch, stash, reset, worktree).
  Scratch files go under `/tmp/review-BRANCH-scratch/` only.
- Do not read `/tmp/review-BRANCH-own.md`:
  it holds the author's findings, and this review must be independent of them.
- Report only issues that affect correctness, the requirements, or code size.
  Do not report style preferences.
  "No issues found" is a valid result.

## Output format

A Markdown list of findings, most important first.
For each:
severity (bug / simplification / test gap), the lines,
one or two sentences,
and the evidence (command and output, or source line).
