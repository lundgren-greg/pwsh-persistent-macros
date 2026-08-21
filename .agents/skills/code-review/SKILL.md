---
name: code-review
description: >
  Review uncommitted changes, a named branch, or a GitHub PR for bugs,
  regressions, and design problems. Use when the user asks to review, look
  over a diff, /review, or /code-review.
---

# Code review

Review the actual diff. Do not review files that did not change unless they are required to understand the change.

## Scope

- Uncommitted / local: `git status`, `git diff`, `git diff --staged`
- Branch: `git diff main...HEAD` (or the repo default branch)
- GitHub PR: `gh pr diff` and `gh pr view`

## What to look for (in order)

1. Incorrect behavior, missing edge cases, broken existing paths
2. Security: secrets, injection, path traversal, privilege
3. Regressions in shared state, APIs, or UI flows
4. Tests missing for the new behavior, or tests that cannot fail
5. Design: extra branches, wrong layer, duplicated helpers
6. Clarity only when it hides a real bug or will cause one

## Output

Lead with a one-line verdict: **ship**, **ship with nits**, or **block**.

Then list findings as:

- **Blocker** — must fix before merge
- **Should fix** — real defect or likely regression
- **Nit** — optional

Each finding: file/symbol, what is wrong, what to do instead. No style-only pile-on.

Do not approve a change that you did not actually inspect.
