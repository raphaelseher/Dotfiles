---
description: Implement the findings of the latest review round and record what was done
agent: build
---

Implement the findings of the latest code review round.

Thread selection: !`find .agent/reviews -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort -r | head -5; true`

Current branch: !`git branch --show-current 2>&1`

Arguments (optional thread dir name; otherwise use the newest thread whose `target.md` has `branch:` equal to the current branch, else the newest thread):

```
$ARGUMENTS
```

## Steps

1. Find the thread, then its highest `round-N.md`. Read it fully. If a `round-N.fixes.md` already exists, tell the user and stop unless they asked to redo it.
2. Treat the Findings and Fix Queue as a checklist. Fix in priority order: P0, P1, P2. Include P3 only if quick and safe.
3. If a finding is invalid, already fixed, or not possible right now, say why briefly and continue.
4. Treat "Human Reviewer Callouts (Non-Blocking)" as informational only. Do not turn them into fix tasks.
5. Follow fail-fast error handling: do not add local catch/fallback recovery unless the scope is an explicit boundary that can safely translate the failure. If you add or keep a `try/catch`, explain the failure mode and either rethrow with context or return a boundary-safe error. JSON parsing must fail loudly.
6. Run relevant tests/checks for the touched code where practical.
7. Do not commit unless the user asks.
8. Write `<thread-dir>/round-N.fixes.md` with one entry per finding ID, in this form:

```
- F1: fixed | skipped | invalid: <one-line reason>; files: <paths touched>
```

   Do not edit `round-N.md` or `target.md`.

9. End with: fixed items, skipped/invalid items (with reasons), and verification results. Then tell the user to run `/review continue` to verify the fixes.
