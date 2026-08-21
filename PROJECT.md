# __PROJECT_NAME__ — project tracker

> **Resume here** when starting a new session. Keep this file current when you stop work.
> Optional Grok-Context thread: `C:\Repos\Grok-Context\threads\__PROJECT_NAME__\`

| Field | Value |
|-------|--------|
| **Local path** | `C:\Repos\__PROJECT_NAME__` |
| **GitHub** | `__GITHUB_OWNER__/__PROJECT_NAME__` |
| **Branch** | `main` |
| **Last commit** | Run `git log -1 --oneline` |
| **Remote** | `origin` → https://github.com/__GITHUB_OWNER__/__PROJECT_NAME__.git |
| **Status** | Scaffold from `repo-template` — not started |
| **Updated** | __TODAY__ |

---

## Goal

<!-- One paragraph: what this ships, for whom, and the hard constraint (offline, Windows-only, etc.). -->

__PROJECT_DESCRIPTION__

---

## Stopped at

1. Created from `lundgren-greg/repo-template`.
2. Ran `Initialize-Repo.ps1` (or still need to).
3. Next: fill **Why this project**, implement the first slice, and keep CI green.

---

## Next steps (ordered)

1. Replace any leftover template tokens if a scan still finds them.
2. Write the first working slice + tests.
3. Update README architecture / usage with real commands.

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
__PROJECT_NAME__/
  PROJECT.md
  README.md, LICENSE, SECURITY.md, CODEOWNERS, AGENTS.md
  .editorconfig, .gitattributes, .gitignore
  .github/workflows/ci.yml
  .github/copilot-instructions.md
  src/
  tests/
  scripts/
  docs/
  samples/
```

### Commands

```powershell
cd C:\Repos\__PROJECT_NAME__
git status
git log -1 --oneline
```

---

## Roadmap (not done)

| Item | Notes |
|------|--------|
| First working slice | |
| Tests for the slice | |
| README usage that matches reality | |

---

## Decisions log

| Date | Decision |
|------|----------|
| __TODAY__ | Standard repo kit from `lundgren-greg/repo-template` (README, PROJECT.md, LICENSE, SECURITY, CODEOWNERS, CI, EditorConfig). |
| __TODAY__ | License MIT; CODEOWNERS `* @lundgren-greg`. |
| __TODAY__ | Default branch `main`. No force-push after the remote exists without asking. |

---

## Session resume checklist

When starting a new agent/chat session:

1. Read **this file** (`PROJECT.md`).
2. `git -C C:\Repos\__PROJECT_NAME__ status` and `git log -1 --oneline`.
3. `gh auth status`.
4. Update **Stopped at** / **Next steps** / **Open questions** before ending the session.
5. If a Grok-Context thread exists, refresh `brief.md` and point `NOW.md` at it.

---

## Do not

- Commit secrets, tokens, or real customer / production dumps (use `samples/private/` locally; gitignored).
- Add network upload / telemetry helpers without an explicit opt-in design and a SECURITY.md update.
- Force-push or rewrite history on `main` after the remote exists without asking.
