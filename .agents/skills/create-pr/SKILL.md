---
name: create-pr
description: >
  Open a GitHub pull request with a short summary of what changed and why. Use
  when the user wants a PR, pull request, /pr, /create-pr, or "open a PR".
---

# Create PR

Use `gh`. Do not open a PR until the work is committed on a branch.

## Steps

1. `git status -sb`, `git log --oneline @{u}..HEAD` (or `main..HEAD` if no upstream), and `git diff main...HEAD` (or the repo's default branch).
2. If still on `main` with uncommitted work, stop and ask whether to branch first. Do not open a PR from a dirty `main` unless the user insists.
3. Push the branch with `git push -u origin HEAD` if it has no upstream.
4. Create the PR:
   ```powershell
   gh pr create --title "<title>" --body "<body>"
   ```
5. Title: imperative, specific, ≤72 characters.
6. Body, in this order:
   - What changed
   - Why
   - How to verify
   - Anything the reviewer must not miss
7. Print the PR URL.

## Do not

- Force-push.
- Add reviewers or labels unless the user asked.
- Paste the entire diff into the body.
