---
name: security-review
description: >
  Review code or a diff for secrets, injection, path traversal, privilege
  issues, and unsafe defaults. Use when the user asks for a security review,
  threat model, /security, or /security-review.
---

# Security review

Review the change (or named paths) as if it will run on a Windows workstation with real files and credentials.

## Checklist

1. **Secrets** — tokens, connection strings, API keys, private keys, customer data. Never commit them. Flag files that look like live config.
2. **Untrusted input** — paths, URLs, process arguments, SQL/KQL, HTML, shell strings. Look for interpolation into commands or queries.
3. **Path traversal** — `Join-Path` / file APIs that take caller-controlled segments without resolving under a root.
4. **Privilege** — elevation, world-writable install dirs, services running as SYSTEM, scheduled tasks with unnecessary `Highest`.
5. **Network** — unexpected egress, disabled TLS checks, `RejectUnauthorized` off, download-and-execute.
6. **Deserialization / files** — unpacking zips, executing extracted content, loading scripts from Downloads.
7. **AuthZ** — any "act as the user" or cross-agent queue must authenticate and authorize; do not trust the next process blindly.

## Output

- **Blocker** / **Should fix** / **Acceptable risk**
- Attack, affected code, fix

If nothing material is wrong, say that. Do not invent findings.

This repo family is local-first: no telemetry and no upload helpers without an explicit design and a `SECURITY.md` update.
