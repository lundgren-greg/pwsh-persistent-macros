---
name: plan
description: >
  Write a short implementation plan before coding when the approach is unclear.
  Use when the user asks how to build something, wants a design, or runs /plan.
---

# Plan

Do not start implementing until the user accepts the plan, unless they explicitly said to skip planning.

## Produce

1. **Goal** — one sentence.
2. **Constraints** — OS, offline/local-first, existing files, APIs you must not break.
3. **Approach** — the chosen path and why, plus one alternative you rejected.
4. **Steps** — ordered, each with:
   - files you will touch
   - what "done" looks like
   - how you will verify (test command, repro, or UI path)
5. **Risks** — the two or three ways this can go wrong.

Keep it short enough to read in one pass. No architecture theater.

## Rules

- Inspect the repo before planning. Plans that ignore existing helpers are wrong.
- If a decision is still blocked on a user choice, ask that one question instead of padding the plan with options.
- After approval, implement the plan in order. If reality invalidates a step, stop and update the plan.
