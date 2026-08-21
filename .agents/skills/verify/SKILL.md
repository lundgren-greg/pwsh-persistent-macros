---
name: verify
description: >
  Prove a change works with the project's real test or run commands before
  claiming it is done. Use when finishing a task, after a fix, or the user
  runs /verify.
---

# Verify

Do not say "done", "fixed", or "tested" unless a command you ran supports it.

## Steps

1. Identify the repo's real check: `dotnet test`, `Invoke-Pester`, `pytest`, `cargo test`, `npm test`, or the script's own `-WhatIf` / dry-run.
2. Run the smallest command that covers the change. Then run the broader suite if one exists and is cheap.
3. For UI or tray tools, exercise the actual path a user takes — not only a unit test of a helper.
4. For scripts that change the machine, prefer `-WhatIf` / `-PollOnce` / a temp directory over a live system change.
5. Report:
   - command
   - result (pass/fail)
   - what you did **not** run

If you cannot run the check (missing SDK, needs elevation, needs a game running), say that and stop short of claiming success.
