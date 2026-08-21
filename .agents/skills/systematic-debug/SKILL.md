---
name: systematic-debug
description: >
  Debug by forming a hypothesis, gathering evidence, and confirming the root
  cause before changing code. Use when something is broken, a test fails, a
  script errors, or the user runs /debug or /systematic-debug.
---

# Systematic debug

Do not start by editing code. Find the cause first.

## Loop

1. **Reproduce.** Capture the exact command, input, and failure (exit code, exception, screenshot, log line). If you cannot reproduce, say what is missing.
2. **Hypothesize.** State one specific, testable cause. Example: "the watcher skips the sample because `LastWriteTime` is older than state."
3. **Instrument.** Add the smallest check that would prove or kill that hypothesis (existing log, a one-off command, a failing test). Do not spray `Write-Host` everywhere.
4. **Confirm.** Keep the evidence. Only then change code.
5. **Prove the fix.** Re-run the original reproduction. If a test can lock it in, add that test.

## Rules

- One hypothesis at a time. If evidence kills it, write the next one; do not shotgun-fix.
- Prefer reading logs, traces, and git history of the failing area over rewriting the module.
- If the bug is environmental (PATH, execution policy, service identity), say so and stop treating it as application logic.
- Do not claim "fixed" without the original failing path now passing.
