#!/usr/bin/env bash
# Spawn a pi subagent in a tmux window named "pi-sub-<n>: <description>".
# Usage: spawn.sh "<short description>" <task-file> [workdir]
# Prints the subagent id <n>. Its files live in /tmp/pi-sub/<n>/.
set -euo pipefail

desc=${1:?description required}
task_file=${2:?task file required}
workdir=${3:-$PWD}
[ -f "$task_file" ] || { echo "task file not found: $task_file" >&2; exit 1; }

root=/tmp/pi-sub
mkdir -p "$root"
n=1
while ! mkdir "$root/$n" 2>/dev/null; do n=$((n + 1)); done
dir=$root/$n
cp "$task_file" "$dir/task.md"

cat > "$dir/prompt.md" <<EOF
You are subagent pi-sub-$n, started by another pi agent.
Your task is in $dir/task.md. Read it and do it.

When you are finished:
1. Write your final result to $dir/result.md. Make it self-contained, because the parent agent only reads this file.
2. Then run: touch $dir/done

If you cannot finish the task, still write result.md explaining what blocked you, then touch done.
Do not spawn further subagents.
EOF

name="pi-sub-$n: $desc"
cmd=(pi "Read $dir/prompt.md and follow its instructions.")

# Target windows by ID, not by name, because the colon in the name conflicts with tmux's session:window syntax.
if [ -n "${TMUX:-}" ]; then
  session=$(tmux display-message -p -t "${TMUX_PANE:-}" '#{session_id}')
  wid=$(tmux new-window -d -t "$session:" -n "$name" -c "$workdir" -e PI_SUBAGENT=1 -P -F '#{window_id}' -- "${cmd[@]}")
elif tmux has-session -t pi-sub 2>/dev/null; then
  wid=$(tmux new-window -d -t "pi-sub:" -n "$name" -c "$workdir" -e PI_SUBAGENT=1 -P -F '#{window_id}' -- "${cmd[@]}")
else
  wid=$(tmux new-session -d -s pi-sub -n "$name" -c "$workdir" -e PI_SUBAGENT=1 -P -F '#{window_id}' -- "${cmd[@]}")
  echo "note: not inside tmux; created detached session 'pi-sub' (watch with: tmux attach -t pi-sub)" >&2
fi

# Keep the pane open if pi exits or crashes, so its output can still be inspected.
tmux set-option -w -t "$wid" remain-on-exit on >/dev/null
echo "$wid" > "$dir/window"
echo "$n"
