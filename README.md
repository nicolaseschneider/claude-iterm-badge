# claude-iterm-badge

A [Claude Code](https://claude.com/claude-code) skill that sets the iTerm2 badge (the large watermark text in the
top-right of the pane) to a 1-3 word summary of what the session is working on, so you can tell your Claude tabs
apart at a glance.

No-op outside iTerm2.

## Install

1. Copy the skill into your user skills dir:

   ```sh
   git clone https://github.com/nicolaseschneider/claude-iterm-badge.git
   mkdir -p ~/.claude/skills
   cp -R claude-iterm-badge/iterm-badge ~/.claude/skills/
   chmod +x ~/.claude/skills/iterm-badge/set-badge.sh
   ```

2. Make it run at the start of every session by adding a `SessionStart` hook to `~/.claude/settings.json`
   (merge into your existing `hooks` block if you have one):

   ```json
   {
     "hooks": {
       "SessionStart": [
         {
           "matcher": "startup|resume|clear",
           "hooks": [
             {
               "type": "command",
               "command": "echo 'Invoke the iterm-badge skill as soon as the first task is clear.'"
             }
           ]
         }
       ]
     }
   }
   ```

   A `SessionStart` hook's stdout is added to Claude's context, so this nudges Claude to set the badge once it
   knows what you're working on (the badge needs the task, so it can't be set before your first message).

3. Start a new `claude` session and give it a task. The badge appears after Claude's first turn.

## Manual use

```sh
~/.claude/skills/iterm-badge/set-badge.sh my task
```

Or type `/iterm-badge` in a session to re-run it when the task changes.

## How it works

`set-badge.sh` writes iTerm2's `SetBadgeFormat` escape sequence. Claude's Bash tool runs without a controlling
tty, so the script walks up the process tree to the nearest ancestor that has one (the `claude` process) and
writes the sequence there.
