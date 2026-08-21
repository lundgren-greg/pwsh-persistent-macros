# Security Policy

## Scope

**pwsh-persistent-macros** is a local project. Treat inputs, outputs, and config as potentially
sensitive. Prefer an offline / local-first design: no telemetry and no upload of user
data unless a future feature is explicitly opt-in and documented here.

## Supported Versions

| Version | Supported |
|---------|-----------|
| 0.x     | Yes (active development) |

## Reporting a Vulnerability

If you discover a security issue, please **do not** open a public GitHub issue.

Use [GitHub private vulnerability reporting](https://github.com/lundgren-greg/pwsh-persistent-macros/security/advisories/new)
when available, or contact the maintainer directly.

We will acknowledge receipt within 72 hours.

## Security Considerations

- **No network access.** This script only reads and writes a local JSON file.
- **`rmN` is `Invoke-Expression`.** A slot stores a command line you already ran,
  then replays it. Treat `macros.json` as executable. Do not copy someone else’s
  file into `$PersistentMacrosFile`.
- **Path handling.** The JSON path is either the default `~/profile/macros.json`
  or a path the user set in `$PersistentMacrosFile` before dot-sourcing.
- **No secrets in repo.** Do not commit a live `macros.json`. Command lines can
  contain tokens, hostnames, or paths.
- **No telemetry.** Keep it that way.
