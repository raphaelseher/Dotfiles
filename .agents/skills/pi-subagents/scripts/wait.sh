#!/usr/bin/env bash
# Wait until all given subagents are done, then print their results.
# Usage: wait.sh <n> [<n>...]   (env TIMEOUT=seconds, default 1500)
# Exit codes: 0 all done, 2 a subagent exited without signalling done, 3 timeout.
set -uo pipefail
timeout=${TIMEOUT:-1500}
root=/tmp/pi-sub

elapsed=0
while :; do
  pending=()
  for n in "$@"; do
    dir=$root/$n
    [ -f "$dir/done" ] && continue
    wid=$(cat "$dir/window")
    dead=$(tmux display-message -p -t "$wid" '#{pane_dead}' 2>/dev/null || echo gone)
    if [ "$dead" != "0" ]; then
      echo "=== pi-sub-$n EXITED without done ($dead). Last output:"
      tmux capture-pane -p -t "$wid" -S -60 2>/dev/null
      exit 2
    fi
    pending+=("$n")
  done
  [ ${#pending[@]} -eq 0 ] && break
  if [ "$elapsed" -ge "$timeout" ]; then
    for n in "${pending[@]}"; do
      echo "=== pi-sub-$n TIMEOUT. Last screen:"
      tmux capture-pane -p -t "$(cat "$root/$n/window")" | tail -40
    done
    exit 3
  fi
  sleep 5; elapsed=$((elapsed + 5))
done

for n in "$@"; do
  echo "=== pi-sub-$n result ($root/$n/result.md):"
  cat "$root/$n/result.md" 2>/dev/null || echo "(no result.md)"
done
