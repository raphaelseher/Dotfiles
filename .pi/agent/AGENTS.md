# Subagents

- When delegating work to subagents (parallel tasks, isolated context, research), always use the tmux flow from the `pi-subagents` skill. Each subagent is a separate `pi` in its own tmux window named `pi-sub-<n>: <description>`.
- Exception: if the environment variable `PI_SUBAGENT=1` is set, you are already a subagent. Do not spawn subagents.
