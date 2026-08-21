# Agent instructions — pwsh-persistent-macros

Read `PROJECT.md` first for current status, blockers, and the session resume checklist.
Keep it updated when you stop work.

Starter skills are in `.agents/skills/` (commit, PR, review, debug, TDD, plan, security, PowerShell, simplify, verify). Same pack is installed machine-wide from `C:\Repos\Scripts\Install-AgentSkills.ps1`.

## Product rules

- Windows-first unless the project later says otherwise.
- Local-first / offline by default. No telemetry. No upload helpers without an explicit
  design plus a `SECURITY.md` update.
- Never commit secrets, tokens, or real customer / production data.
- No force-push or history rewrite on `main` without asking.

## Layout

```text
Register-PersistentMacros.ps1   # Drop-in file dotted from $PROFILE
tests/                          # Pester 5
scripts/                        # Repo kit helpers
```

This is a single profile helper, not an app. Keep the loadable script at the repo root so the `$PROFILE` path stays short.

## Conventions

- PowerShell: approved verbs (`Verb-Noun`), PascalCase, `[CmdletBinding()]`, 4-space indent.
  See `C:\Repos\Scripts\script-naming-standard.md`.
- C#: 4-space indent, CRLF, logic in a Core project, tests in xUnit.
- JavaScript / JSON / YAML: 2-space indent.
- Markdown: do not trim trailing whitespace (EditorConfig).
- Tests create temp dirs/files and clean up in `finally` (or the language equivalent).

## Build, test, commit

Run the stack’s real test command before committing. Keep `.github/workflows/ci.yml` green.

Update `PROJECT.md` (`Stopped at`, `Next steps`, `Decisions log`) at the end of a session.
