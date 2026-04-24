#!/usr/bin/env bash

sessions=$(tmux list-sessions -F '#{session_name}' 2>/dev/null) || exit 0
[[ -z "$sessions" ]] && exit 0

blacklisted=$(sesh list -bt 2>/dev/null)
[[ -z "$blacklisted" ]] && exit 0

while IFS= read -r session; do
  if ! grep -qxF "$session" <<< "$blacklisted"; then
    exit 0
  fi
done <<< "$sessions"

tmux detach-client 2>/dev/null
tmux kill-server
