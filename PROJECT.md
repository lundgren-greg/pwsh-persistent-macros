# pwsh-persistent-macros — project tracker

> **Resume here** when starting a new session. Keep this file current when you stop work.
> Optional Grok-Context thread: `C:\Repos\Grok-Context\threads\pwsh-persistent-macros\`

| Field | Value |
|-------|--------|
| **Local path** | `C:\Repos\pwsh-persistent-macros` |
| **GitHub** | `lundgren-greg/pwsh-persistent-macros` |
| **Branch** | `main` |
| **Last commit** | Run `git log -1 --oneline` |
| **Remote** | `origin` → https://github.com/lundgren-greg/pwsh-persistent-macros.git |
| **Status** | First slice: drop-in `Register-PersistentMacros.ps1` + Pester smoke tests |
| **Updated** | 2026-08-20 |

---

## Goal

Nine numbered PowerShell command slots (`sm` / `rm` / `wm`) that persist across sessions. Dot-sourced from `$PROFILE`. Local JSON only — no network.

---

## Stopped at

1. Public repo live. `$PROFILE` on this machine dots `Register-PersistentMacros.ps1`.
2. GitHub profile README points at this repo instead of inlining the script.

---

## Next steps (ordered)

1. Confirm GitHub Actions CI is green on `main`.
2. No further slice planned.

---

## Blockers

| Blocker | Detail | Unblock |
|---------|--------|---------|
| None yet | | |

---

## Open questions (for user)

| # | Question | Why it matters | Answer |
|---|----------|----------------|--------|
| 1 | | | |

---

## What’s implemented

### Layout

```
pwsh-persistent-macros/
  Register-PersistentMacros.ps1
  tests/Register-PersistentMacros.Tests.ps1
  README.md, LICENSE, SECURITY.md, PROJECT.md
  .github/workflows/ci.yml
```

### Commands

```powershell
cd C:\Repos\pwsh-persistent-macros
Invoke-Pester ./tests
```

---

## Roadmap (not done)

| Item | Notes |
|------|--------|
| Named slots / list helper | Out of scope unless it gets painful |
| PowerShell module / PSGallery | Not needed for a profile drop-in |

---

## Decisions log

| Date | Decision |
|------|----------|
| 2026-08-20 | Standard repo kit from `lundgren-greg/repo-template`. |
| 2026-08-20 | License MIT; CODEOWNERS `* @lundgren-greg`. |
| 2026-08-20 | Default branch `main`. |
| 2026-08-20 | Single `.ps1` dotted from `$PROFILE`, not a module. `$PersistentMacrosFile` is the path override. |
| 2026-08-20 | `rmN` uses `Invoke-Expression` of commands the user saved. Documented in SECURITY.md. |

---

## Session resume checklist

When starting a new agent/chat session:

1. Read **this file** (`PROJECT.md`).
2. `git -C C:\Repos\pwsh-persistent-macros status` and `git log -1 --oneline`.
3. `gh auth status`.
4. Update **Stopped at** / **Next steps** / **Open questions** before ending the session.
5. If a Grok-Context thread exists, refresh `brief.md` and point `NOW.md` at it.

---

## Do not

- Commit secrets, tokens, or a live `macros.json`.
- Add network upload / telemetry helpers without an explicit opt-in design and a SECURITY.md update.
- Force-push or rewrite history on `main` after the remote exists without asking.
- Put `Set-StrictMode` or `$ErrorActionPreference` in `Register-PersistentMacros.ps1` (it is dotted into the user’s session).
