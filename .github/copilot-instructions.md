# Copilot instructions — __PROJECT_NAME__

Windows-first local project. Read `PROJECT.md` first for current status, blockers,
and the session resume checklist; keep it updated when you stop work.

Project skills are in `.agents/skills/`. Use them for commit, PR, review, debug,
TDD, planning, security review, and PowerShell.

## Architecture

```text
src/          # Application / library code — all business logic lives here
tests/        # Automated tests
scripts/      # PowerShell helpers
docs/         # Design notes
samples/      # Synthetic samples only
```

- Keep UI / CLI shells thin over a core library.
- New features go in core with tests, then get thin wiring in the shell.

## Hard rules

- **Offline / local-first.** No network calls, telemetry, or upload helpers unless a
  feature is explicitly opt-in and documented in `SECURITY.md` first.
- **Never commit secrets or real customer / production data.** Synthetic samples only
  under `samples/`; local confidential files belong in `samples/private/` (gitignored).
- No force-push / history rewrite on `main` without asking.

## Build, test, run

```powershell
# Replace with the stack commands after Initialize-Repo.ps1 -Stack ...
```

CI (`.github/workflows/ci.yml`) must stay green — run the full test suite before committing.

## Conventions

- PowerShell: approved verbs, `Verb-Noun`, `[CmdletBinding()]`, 4-space indent.
- Follow `.editorconfig`.
- Tests create temp dirs/files and clean up afterwards.
