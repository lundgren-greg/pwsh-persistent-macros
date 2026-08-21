# Contributing

This is a personal project (`lundgren-greg`). External PRs are welcome for bugs and
small fixes; larger changes should start as an issue.

## Before you start

1. Read [PROJECT.md](PROJECT.md).
2. Read [AGENTS.md](AGENTS.md) and [`.github/copilot-instructions.md`](.github/copilot-instructions.md).
3. Keep [SECURITY.md](SECURITY.md) in mind — no secrets, no unexpected network.

## Workflow

1. Branch from `main`.
2. Add or update tests with the behavior change.
3. Run the CI-equivalent commands locally.
4. Open a PR against `main`. Fill in the PR template.
5. Do not force-push `main`.

## PowerShell

Use approved verbs and `Verb-Noun` file names. Scripts that are meant to be invoked
directly should have `[CmdletBinding()]`.
