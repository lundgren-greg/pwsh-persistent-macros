---
name: create-skill
description: >
  Create a new Agent Skill (SKILL.md) in the agentskills.io format for Copilot,
  Claude, Codex, Cursor, Grok, and other compatible agents. Use when the user
  wants a new skill, a slash command, or runs /create-skill.
---

# Create skill

A skill is a folder with a `SKILL.md`. Agents load only the name and description until the task matches.

## Location

- **This repo / shareable:** `<repo>/.agents/skills/<name>/SKILL.md`
- **This machine, every repo:** after writing the skill, run `.\Install-AgentSkills.ps1` from `C:\Repos\Scripts` (or copy the folder into `~/.agents/skills/<name>/`)

Also accepted by individual tools: `.github/skills/`, `.claude/skills/`, `~/.copilot/skills/`, `~/.claude/skills/`, `~/.codex/skills/`, `~/.cursor/skills/`, `~/.grok/skills/`. Prefer writing once under `.agents/skills/` and installing from there.

## Name

Lowercase letters, digits, hyphens. 2–64 characters. Must start and end with a letter or digit. One workflow per skill.

## SKILL.md

```markdown
---
name: example-name
description: >
  What it does in one or two sentences. Include trigger phrases and /example-name.
---

# Example name

## Steps
1. ...
```

`description` is the trigger. Put the verbs and slash command the user will say.

## Body rules

- Instructions the agent can follow, not documentation for humans.
- Concrete steps, repo-relative paths, real commands.
- One source of truth — do not copy the same rule into three skills.
- No filler. If a sentence does not change behavior, delete it.

After writing, tell the user the slash name (`/<name>`) and that they need `Install-AgentSkills.ps1` for other tools / other repos.
