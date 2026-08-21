# Security Policy

## Scope

**__PROJECT_NAME__** is a local project. Treat inputs, outputs, and config as potentially
sensitive. Prefer an offline / local-first design: no telemetry and no upload of user
data unless a future feature is explicitly opt-in and documented here.

## Supported Versions

| Version | Supported |
|---------|-----------|
| 0.x     | Yes (active development) |

## Reporting a Vulnerability

If you discover a security issue, please **do not** open a public GitHub issue.

Use [GitHub private vulnerability reporting](https://github.com/__GITHUB_OWNER__/__PROJECT_NAME__/security/advisories/new)
when available, or contact the maintainer directly.

We will acknowledge receipt within 72 hours.

## Security Considerations

- **No network access by default.** Keep it that way unless a feature is explicitly
  opt-in and documented.
- **Confidential inputs.** Outputs inherit the same sensitivity — store them accordingly.
- **Path handling.** Only open files the user selects, drops, or configures. Do not
  follow untrusted hyperlinks inside documents.
- **Dependencies.** Prefer well-known packages and keep them updated.
- **No secrets in repo.** Do not commit tokens, `.env` files, or real production /
  customer dumps. Use synthetic samples under `samples/`. Local confidential fixtures
  belong in `samples/private/` (gitignored).
