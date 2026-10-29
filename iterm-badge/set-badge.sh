#!/bin/sh
[ "$TERM_PROGRAM" = iTerm.app ] || exit 0
# Bash-tool shells have no controlling tty; write to the nearest ancestor's (the claude process).
pid=$$
while [ "$pid" -gt 1 ]; do
  tty=$(ps -o tty= -p "$pid" | tr -d ' ')
  case "$tty" in ''|'??') pid=$(ps -o ppid= -p "$pid" | tr -d ' ') ;; *) break ;; esac
done
[ "$pid" -gt 1 ] || { echo "no tty found" >&2; exit 1; }
printf '\033]1337;SetBadgeFormat=%s\a' "$(printf %s "$*" | base64)" > "/dev/$tty"
