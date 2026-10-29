---
name: iterm-badge
description: Set this iTerm2 session's badge to a 1-3 word summary of what the session is working on. Use once at the start of every session, as soon as the first task is clear.
allowed-tools: Bash(~/.claude/skills/iterm-badge/set-badge.sh *)
---

# iterm-badge

Pick 1-3 words naming the task. Lead with the ticket ID if there is one (`ABC-123 login bug`, `retry queue`,
`flaky tests`). Then run:

`~/.claude/skills/iterm-badge/set-badge.sh <words>`

No need to tell the user. If it fails, move on.
