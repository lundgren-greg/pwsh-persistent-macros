---
name: powershell-script
description: >
  Author or edit PowerShell using Verb-Noun names, CmdletBinding, and this
  machine's Scripts conventions. Use when writing or reviewing .ps1 files,
  modules, scheduled-task hosts, or the user runs /powershell or /powershell-script.
---

# PowerShell script

Follow `script-naming-standard.md` in `C:\Repos\Scripts` when that file exists.

## File and command shape

- Name: `{Verb}-{Noun}[-Qualifier].ps1` with approved verbs and PascalCase.
- Start with `[CmdletBinding()]` (add `SupportsShouldProcess` when the script changes system state).
- `Set-StrictMode -Version Latest` and `$ErrorActionPreference = 'Stop'` unless there is a specific reason not to.
- 4-space indent. Comment-based help for anything a human will run more than once.

## Behavior

- Parameters are typed and validated. No `$args` bag for public scripts.
- Shared helpers live in a `*.Shared.ps1` and are dot-sourced; do not copy-paste.
- Config is JSON next to the script. Never hard-code machine-specific paths when a config key will do.
- Changing the system requires `-WhatIf` / `ShouldProcess` when practical.
- Scheduled-task or tray hosts stay thin; logic goes in the shared script so it can be tested with `-PollOnce` (or equivalent).

## Safety

- Quote paths. Use `-LiteralPath` when the path may contain `[` or wildcards.
- Do not set `ExecutionPolicy Unrestricted` globally. Bypass only on a single `powershell.exe -File` invocation you own.
- Do not log secrets. Redact tokens in verbose output.

## Tests

Prefer Pester when the repo already has it. Tests use temp directories and clean up in `finally`.
