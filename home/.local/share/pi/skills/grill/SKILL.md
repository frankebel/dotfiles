---
name: grill
description: >-
  Relentless interview to sharpen a plan or design before acting on it.
disable-model-invocation: true
---

# Grill

Interview the user until you reach a shared understanding of the plan.
Write no code and edit no files until the session ends.
Map the plan as a design tree:
every decision branches into the decisions that hang off it.

## Rounds

Ask in rounds.
The frontier is every open decision whose prerequisites are settled.
Ask the whole frontier in one round.
A question whose answer depends on another question of the same round
belongs to a later round.

Number each question and give your recommended answer:

```
**Q1 – <title>**: <question, with the choices if there are any>

Recommended: <answer>

---

**Q2 – …**
```

Word each question so that "yes" accepts your recommendation.
Then wait for the answers,
recompute the frontier,
and ask the next round.

## Facts and decisions

Finding facts is your job:
look up in the code, files, or documentation
whatever you can, instead of asking the user.
Decisions are the user's:
put each one to them and wait,
never settle one yourself.

## End

The session ends when the frontier is empty:
every branch visited, nothing silently assumed.
List the decisions in one block,
and act on them only after the user confirms it.

Adapted from
[`grilling`](https://github.com/mattpocock/skills/blob/4ae2317ddb22b046e26455e4f9c9b3aaaf62212d/skills/productivity/grilling/SKILL.md)
in mattpocock/skills (MIT).
