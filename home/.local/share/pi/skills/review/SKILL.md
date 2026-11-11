---
name: review
description: >-
  Review of a change before it is presented.
  Use whenever a non-trivial change is ready for the user,
  whatever it changes (code, math, or text).
  Trivial means typos, formatting, or whitespace only;
  a sign, a claim, or a derivation step is never trivial.
---

# Review

Review every change in layers before presenting it.
No layer finds everything,
and the layers overlap little.

## 1. Self-review

- Walk through the diff line by line.
- Back every claim about other code (Base, libraries, callers)
  with a source line or a command and its output.
  Never state from memory how other code behaves.
- For each line, check that removing or simplifying it changes the result;
  if it does not, drop it.
- Break the code on purpose for each new test,
  and check that the test fails.
- Look for a simpler idiom in the standard library for each construct.
- Name every new argument, variable and symbol
  like the existing code that plays the same role,
  and grep for that role before taking a name from a spec or handoff:
  the codebase wins over the spec.

## 2. Scenario scripts

Where a reference behaviour exists (Base, an earlier version, a dense solver),
write a script under `/tmp` that compares the change against it
on realistic sizes and edge cases,
and report the mismatch count.

## 3. Second reviewer

Run one review round with Fable,
unless the diff, new files included, has under 10 changed lines
and touches no signs, numerics, threading,
or design choices the user has not seen yet.
Skip it also for a standalone analysis or plot script
whose output the user inspects.
When skipping, name the reason in the report,
e.g. `skipped (+3/−1, rename)`.
Start it after layers 1 and 2 and the checks, on the final diff,
so it reviews what the user will see.
Before starting it, write the confirmed findings of those layers
to `/tmp/review-BRANCH-own.md`, one line each.

1. Check out the change in a detached worktree,
   so the reviewer cannot touch the working tree:

   ```sh
   git worktree add --detach /tmp/review-BRANCH "$(git merge-base main HEAD)"
   git diff --binary "$(git merge-base main HEAD)" |
       git -C /tmp/review-BRANCH apply --allow-empty
   ```

   Copy new untracked files of the change,
   and untracked files the checks need, such as `test/Manifest.toml`.
   Then make them visible to the reviewer's `git diff`,
   and save the diff for step 3:

   ```sh
   git -C /tmp/review-BRANCH add -N .
   git -C /tmp/review-BRANCH diff --binary > /tmp/review-BRANCH.diff
   ```

2. Fill in [`reviewer-prompt.md`](reviewer-prompt.md)
   with the user's requirements, the test command and the branch name,
   and run it from the worktree,
   in its own process group and with its PID recorded:

   ```sh
   cd /tmp/review-BRANCH
   setsid pi -p --no-session --no-mcp --tools read,bash \
       --model claude-bridge/fable:high \
       "$(cat /tmp/review-BRANCH-prompt.md)" > /tmp/review-BRANCH.md &
   echo $! > /tmp/review-BRANCH.pid
   ```

   It has finished once `kill -0 "$(cat /tmp/review-BRANCH.pid)"` fails;
   the output file exists from the start, so read it only then.
   To stop it, kill the whole group,
   `kill -- -"$(cat /tmp/review-BRANCH.pid)"`:
   killing only `pi` leaves its `claude` child running.

3. Check that the worktree diff is unchanged,
   then remove the worktree
   (it holds the applied change, so plain `remove` refuses):

   ```sh
   git -C /tmp/review-BRANCH diff --binary | cmp - /tmp/review-BRANCH.diff
   git worktree remove --force /tmp/review-BRANCH
   ```

- One round only.
  Never loop between writer and reviewer until they agree:
  agreement is not correctness,
  and every round adds code.
- Do not use a provider other than `claude-bridge` without asking:
  it sends the code to another service.

## 4. Verify the findings

- Check every reviewer finding yourself, with a command or a source line,
  before it reaches the user.
- Report the confirmed findings,
  and the rejected ones in one line each, with the reason.
- Report what the self-review corrected,
  so the user does not find it by asking.
