---
name: commit
description: >
  Create a focused git commit from the current working tree. Use when the user
  wants to commit, stage changes, write a commit message, or runs /commit.
---

# Commit

Commit only what the user asked to land. Leave unrelated dirty files alone.

## Steps

1. Run `git status -sb` and `git diff` (plus `git diff --staged` if anything is already staged).
2. If the branch is behind origin and the user asked to push later, say so; do not rebase unless they asked.
3. Stage only the files that belong to this change. Never `git add -A` or `git add .` when unrelated files are dirty.
4. Write a commit message that states **why**, not a file list.
   - Preferred: `Fix HWMonitor F5 logging for fullscreen games.`
   - Conventional prefix is fine when the repo already uses it: `fix:`, `feat:`, `docs:`, `chore:`.
5. Commit with a heredoc or `-m`. Do not add `Co-authored-by` or AI trailer lines unless the repo already requires them.
6. Show `git status -sb` after the commit. Do not push unless the user asked.

## Do not

- Commit secrets, tokens, local config with machine paths, or `samples/private/`.
- Amend or rewrite history on `main` unless the user explicitly asked.
- Include files you did not inspect.
