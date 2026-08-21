# How to use this template

This repository is the standard kit for new `lundgren-greg` projects. It is marked
as a **GitHub template**.

It encodes the files we keep copying from **pathfix-cli**, **diagnostic-recording**,
and **CopilotDocConverter**:

| File | Role |
|------|------|
| `README.md` | Why, features, architecture, build/test, security, roadmap, MIT |
| `PROJECT.md` | Session tracker — resume here |
| `LICENSE` | MIT |
| `SECURITY.md` | Scope, private reporting, 72h ack, no secrets, local-first |
| `CODEOWNERS` | `* @lundgren-greg` |
| `.github/workflows/ci.yml` | Windows-first GitHub Actions |
| `.editorconfig` | Spaces, CRLF, 4-wide (2 for YAML/JSON/JS) |
| `.github/copilot-instructions.md` | Agent / Copilot context |
| `AGENTS.md` | Short agent rules |
| `.agents/skills/` | Starter Agent Skills (Copilot, Claude, Codex, Cursor, Grok) |

## Create a new repo

```powershell
gh repo create my-project --template lundgren-greg/repo-template --private --clone
cd my-project
.\scripts\Initialize-Repo.ps1 -Name my-project -Description "One-line pitch" -Stack DotNet
```

Stacks: `DotNet`, `PowerShell`, `Python`, `Node`, `Rust`, `Generic`.

`Initialize-Repo.ps1` will:

1. Replace `__PROJECT_NAME__`, `__PROJECT_DESCRIPTION__`, `__GITHUB_OWNER__`, `__YEAR__`, `__TODAY__`
2. Strip the template intro from `README.md`
3. Install `templates/ci/<stack>.yml` as `.github/workflows/ci.yml`
4. Delete this `TEMPLATE.md`
5. Create a Grok-Context thread under `C:\Repos\Grok-Context\threads\<name>\` if that repo exists

Then commit and push. `Initialize-Repo.ps1` stays in the new repo — it is harmless after the first run.

## After init

1. Fill **Why this project** and **Goal**
2. Put code in `src/`, tests in `tests/`
3. Keep `PROJECT.md` current when you stop work
4. Keep CI green
