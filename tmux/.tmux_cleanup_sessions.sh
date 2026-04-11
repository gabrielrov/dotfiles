#!/usr/bin/env bash

REGEX=$(tmux show-option -gv @cleanup_regex 2>/dev/null)

[[ -z "$REGEX" ]] && exit 0

sessions=$(tmux list-sessions -F '#{session_name}' 2>/dev/null) || exit 0

[[ -z "$sessions" ]] && exit 0

while IFS= read -r name; do
  if [[ ! "$name" =~ $REGEX ]]; then
    exit 0
  fi
done <<< "$sessions"

tmux detach-client 2>/dev/null
tmux kill-server
