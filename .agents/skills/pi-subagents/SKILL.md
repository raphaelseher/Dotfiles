---
name: pi-subagents
description: 'Delegate work to subagents, meaning separate pi instances that each run in their own tmux window named "pi-sub-<n>: <description>". Use whenever a task should be delegated, parallelized, or run with a fresh, isolated context (research, web search, scouting, independent implementation, review).'
---

# Subagents via tmux

Each subagent is an interactive `pi` running in its own tmux window, so the user can watch it and step in. You communicate with it only through files in `/tmp/pi-sub/<n>/`.

Scripts are in this skill's `scripts/` directory. Use absolute paths.

## Flow

1. **Write the task** to a temporary file. The subagent shares none of your context, so make the task self-contained: goal, relevant paths and facts, constraints, and the result format you want back.
2. **Spawn** the subagent:
   ```bash
   scripts/spawn.sh "<short description, 2-5 words>" /tmp/task-xyz.md [workdir]
   ```
   The script prints the subagent id `<n>`. If you are inside tmux, the window opens in the current session. Otherwise it goes into a detached session `pi-sub`; tell the user to run `tmux attach -t pi-sub`.
   For parallel work, spawn several subagents before waiting. Subagents that edit code must not touch the same files. Give each one its own git worktree, or split the work by files.
3. **Wait** for the results. Set the bash tool timeout a little above `TIMEOUT`:
   ```bash
   TIMEOUT=1500 scripts/wait.sh <n> [<n>...]
   ```
   - Exit 0: prints every `result.md`.
   - Exit 2: a subagent's pi exited without finishing. The script shows its last output.
   - Exit 3: timed out. The script shows the last screen of each pending subagent. Decide whether to wait again, steer, or kill.
4. **Steer** a subagent if needed. Send the text, then send Enter separately:
   ```bash
   tmux send-keys -t "$(cat /tmp/pi-sub/<n>/window)" -l 'Also add tests'
   tmux send-keys -t "$(cat /tmp/pi-sub/<n>/window)" Enter
   ```
   Check on it with `tmux capture-pane -p -t "$(cat /tmp/pi-sub/<n>/window)" | tail -40`.
5. **Clean up** once you have read the result:
   ```bash
   tmux kill-window -t "$(cat /tmp/pi-sub/<n>/window)"
   ```
   Leave the window open if the user wants to inspect it.

## Rules

- Always target windows by the ID stored in `/tmp/pi-sub/<n>/window`. Never target them by name, because the `:` in the name breaks tmux target parsing.
- Treat `result.md` as the subagent's report and verify important claims before relying on them.
- If `PI_SUBAGENT=1` is set, you are a subagent yourself. Do not spawn further subagents.
