---
name: overnight
description: >-
  Unattended work until a deadline.
  Use whenever the user leaves you to work alone,
  e.g. "until 09:00", "overnight", or "while I am away",
  for calculation campaigns or code optimization.
---

# Overnight

Keep the turn open and work until the deadline.
Never end the turn early,
and never ask "should I continue?":
the user is away,
and best effort on the incoming data beats idle machines.

## Approval

Invoking this skill overrides the approval rule of the global Git rules for its duration;
all other Git rules, including the checks and the signing-key check, still apply:

- Commit without asking, on a development branch only,
  e.g. `auto/<YYYY-MM-DD>-<topic>`.
- Push that branch when a cluster run needs the code.
- Never merge into `main`.

## Before the user leaves

Agree on these in one message, then start:

1. Deadline, checked with `date`.
2. Task, its metric and tolerance,
   e.g. open questions of the run log,
   or the wall time of a benchmark and how far its result may deviate.
3. Scope: the files you may edit, the machines you may use,
   and how many cluster jobs may run at a time.
4. Keys: run the signing-key check of the global rules
   and `ssh -o BatchMode=yes <host> true` for every host.
   Ask the user to unlock what fails.
5. A clean working tree (`git status`) on the new branch.

## Loop

1. Act: start, analyze, or decide the next step.
2. Log every decision with its reason,
   in the project's run log,
   or else in an untracked `overnight-<YYYY-MM-DD>.md` in the repository root.
3. Wait until a run or job ends, polling every 2 min in one shell loop,
   for at most 60 min, never past the deadline.
4. Check every run and job, then go back to 1.

- Start runs detached (`setsid … &`, `sbatch`), never under a tool-call timeout.
- Give short blocking commands (ssh, rsync, analysis) a generous timeout,
  about 10× their usual time, so a hang cannot block the night,
  and every `ssh` the options `-o BatchMode=yes -o ConnectTimeout=20`.
- Request the partition's maximum `--time`, not an estimate.
- When a host fails, log it and continue with the others.
- When a run crashes, fix a trivial cause and rerun;
  otherwise log it and move on.
- When ideas run out, reread the run log and the code for new angles,
  and keep checking the runs until the deadline.

## Calculation campaigns

- Choose runs from the open questions of the run log,
  one parameter change per run.
- Run at most one local run at a time, since the workstation has no scheduler.
  On a cluster, queue up to the agreed number of jobs.

## Code optimization

1. Fix a benchmark before the first change:
   a command, its wall time, and a reference result.
   Time every run at least twice,
   since the load of a shared machine changes the wall time.
2. Profile, and start with the longest part.
3. One idea per attempt.
   Run the benchmark, the tests that cover the change, and the formatters.
4. Keep the attempt only if it is faster
   and matches the reference within the agreed tolerance;
   commit it with the measured gain in the message.
   Otherwise discard it with `git reset --hard` to the last kept commit.
5. Log every attempt in one line in the untracked log,
   which survives the reset: idea, wall time, kept or discarded, why.

- Never edit the benchmark or the reference.
- Discard a small gain that costs much code,
  and keep an equal time with less code.

## Never

- Touch files outside the scope and the log.
- Kill processes you did not start.
- Change shared configuration, on the cluster or locally.

## At the deadline

1. Leave running jobs alone, and record their IDs.
2. Append a summary to the log:
   what ran, results, decisions, commits on the branch, and open items.
3. End the turn with that summary,
   and the first thing the user should look at.
