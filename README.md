# __PROJECT_NAME__

[![CI](https://github.com/__GITHUB_OWNER__/__PROJECT_NAME__/actions/workflows/ci.yml/badge.svg)](https://github.com/__GITHUB_OWNER__/__PROJECT_NAME__/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

<!-- TEMPLATE-INTRO:START -->
> **This is a GitHub template** (`lundgren-greg/repo-template`).
> Create a new repo from it, then run:
>
> ```powershell
> .\scripts\Initialize-Repo.ps1 -Name my-project -Description "One-line pitch" -Stack DotNet
> ```
>
> That replaces placeholders, installs the matching CI workflow, and rewrites this intro
> into a project README. Stack options: `DotNet`, `PowerShell`, `Python`, `Node`, `Rust`, `Generic`.
>
> Kit source: the files we keep repeating — README, PROJECT.md, LICENSE, SECURITY, CODEOWNERS,
> CI, EditorConfig, Copilot/agent instructions — as used in pathfix-cli, diagnostic-recording,
> and CopilotDocConverter.
<!-- TEMPLATE-INTRO:END -->

__PROJECT_DESCRIPTION__

## Why this project

<!-- One short paragraph: the problem and why a local tool (not a web service) is the right shape. -->

## Key features

- Feature one
- Feature two
- Feature three

## Architecture

```text
__PROJECT_NAME__/
  src/          # Application / library code
  tests/        # Automated tests
  scripts/      # PowerShell helpers (setup, build, launch)
  docs/         # Design notes and longer-form docs
  samples/      # Synthetic samples only — never real confidential data
```

Keep business logic in a core library. Keep UI / CLI shells thin.

## Requirements

- Windows 10/11 (primary)
- PowerShell 7+ (`pwsh`)
- <!-- stack tools, e.g. .NET 9 SDK / Node 20 / Python 3.12 / Rust stable -->

## Build and test

```powershell
# After you pick a stack, replace these with the real commands.
# DotNet:    dotnet restore; dotnet build -c Release; dotnet test -c Release
# PowerShell: Invoke-Pester ./tests
# Python:    python -m pip install -e ".[dev]"; pytest
# Node:      npm ci; npm test
# Rust:      cargo test --workspace
```

## Usage

```powershell
# Show the first useful command here.
```

## Security and privacy

- Prefer **offline / local-first**. No telemetry and no upload helpers unless a feature is
  explicitly opt-in and documented in [SECURITY.md](SECURITY.md).
- Do not commit secrets, tokens, or real customer / production data.
- Put confidential local fixtures in `samples/private/` (gitignored).

## Contribution and development notes

- Read [PROJECT.md](PROJECT.md) first for current status and the session resume checklist.
- Keep [PROJECT.md](PROJECT.md) current when you stop work.
- Add or update tests for behavior changes.
- Keep CI (`.github/workflows/ci.yml`) green.
- No force-push or history rewrite on `main` without asking.

## Roadmap (high level)

| Item | Status |
|------|--------|
| Standard repo kit | Done (this template) |
| First working slice | Not started |

## License

MIT. See [LICENSE](LICENSE).
