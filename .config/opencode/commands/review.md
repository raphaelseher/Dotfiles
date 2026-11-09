---
description: Review code with a fresh-context reviewer (uncommitted, vs branch, another branch, or continue an earlier review)
agent: build
---

You are launching a code review. You do **not** review anything yourself and you do **not** fix anything. Your job is to find out what to review, hand a precise request to the `reviewer` subagent, and report its result.

## Repository facts (gathered by the command, treat as ground truth)

Inside a git work tree: !`git rev-parse --is-inside-work-tree 2>&1`

Current branch: !`git branch --show-current 2>&1`

HEAD: !`git rev-parse HEAD 2>&1`

Default branch: !`git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's#^origin/##' || true`
(If empty, fall back to `master` if it exists, else `main`.)

`git status --porcelain`:
!`git status --porcelain 2>&1 | head -50`

Local branches:
!`git branch --list --format='%(refname:short)' 2>&1 | head -50`

Recent commits:
!`git log --oneline -n 10 2>&1`

Timestamp: !`date +%Y%m%d-%H%M`

Existing review threads (newest first; format: dir | latest round | verdict | branch | kind):
!`find .agent/reviews -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort -r | while read d; do n=$(ls "$d" | sed -n 's/^round-\([0-9][0-9]*\)\.md$/\1/p' | sort -n | tail -1); echo "$d | round=${n:-none} | $(grep -m1 '^verdict:' "$d/round-$n.md" 2>/dev/null) | $(grep -m1 '^branch:' "$d/target.md" 2>/dev/null) | $(grep -m1 '^kind:' "$d/target.md" 2>/dev/null)"; done; true`

## User arguments

```
$ARGUMENTS
```

## Step 1: Decide the mode and target

If the arguments are empty, ask the user with the `question` tool. Interpret non-empty arguments like this:

- `continue [thread-dir-name]`: continue mode (see below). Without a name, use the newest thread whose `branch:` matches the current branch; if none matches, use the newest thread.
- `uncommitted`: target kind `uncommitted`.
- `branch <base>`: current branch against `<base>`.
- `other <branch> [base]`: another branch (not checked out) against `base` (default: the default branch).
- `commit <sha>`: a single commit.
- `folder <paths...>`: snapshot review of the given paths.
- Anything else (or text after the target words): extra **focus** instructions for the reviewer. If the text is only focus, still ask what to review.

Questions to ask when the target is not fully given (use the `question` tool, one question at a time, put the recommended option first and mark it):

1. **What should be reviewed?** Options:
   - **Continue an earlier review**: only offer this when a thread exists (list the 1-3 most relevant threads, preferring ones whose `branch:` equals the current branch; say the dir name and its last verdict).
   - **Uncommitted changes** (staged, unstaged, untracked): recommend this first when `git status --porcelain` is non-empty.
   - **Current branch against a base branch**: recommend this first when the work tree is clean and the current branch is not the default branch.
   - **Another branch** (complete branch, not checked out).
   - **A specific commit**: only if the user asked; otherwise omit to keep the list short.
2. If *against a base branch*: **which base?** Options: the default branch first, then other local branches. Then ask whether to include local (uncommitted) changes only if the work tree is dirty.
3. If *another branch*: **which branch?** Offer local branches except the current one. Then ask for the base (default branch first).

If something is invalid (not a git work tree, branch doesn't exist, nothing to review) say so and stop. If the work tree is clean and the user chose `uncommitted`, say there is nothing to review and stop.

## Step 2: Resolve the facts yourself (read-only git, no checkout)

Resolve concrete values so the reviewer does not have to guess:

- `uncommitted`: `base` = HEAD SHA.
- `branch <base>`: `merge_base` = `git merge-base HEAD <base>` (if `<base>` doesn't exist locally, try `origin/<base>`); `head` = `HEAD`.
- `other <branch> <base>`: `merge_base` = `git merge-base <base> <branch>`; `head` = `<branch>` (local, else `origin/<branch>`); record the head SHA with `git rev-parse`.
- `commit <sha>`: verify with `git rev-parse --verify <sha>^{commit}`.
- `folder`: verify the paths exist.

Never run `git checkout`, `git fetch`, `git switch`, or anything that changes refs or the work tree.

## Step 3: Set up the thread

**New review**: choose a slug from the target, e.g. `<current-branch>-vs-<base>`, `<branch>-vs-<base>`, `uncommitted-<current-branch>`, `commit-<short-sha>`, replacing `/` and spaces with `-`. Thread dir: `.agent/reviews/<Timestamp>-<slug>`. Run `mkdir -p` for it, then write `<thread-dir>/target.md` with these lines (and nothing else):

```
kind: uncommitted | base-branch | branch | commit | folder | custom
branch: <current branch at creation>
base: <base branch or empty>
head: <head ref or empty>
merge_base: <sha or empty>
include_local_changes: true | false
paths: <folder paths or empty>
focus: <extra focus text, single line, or empty>
created: <Timestamp>
```

Round number is `1`.

**Continue**: read `<thread-dir>/target.md`. Find the highest `round-N.md`. The new round is `N+1`. If `round-N.fixes.md` does not exist, tell the user they haven't run `/review-fix` (or fixed things by hand) and ask whether to continue anyway; proceed only if they say yes. Append any new focus text to the `focus:` line of `target.md`. If the target is `uncommitted`, `branch`, or `other`, re-resolve `HEAD` for the request but keep the recorded `merge_base`.

## Step 4: Launch the reviewer

Call the `subagent` tool with agent `reviewer`, in the foreground. Pass a prompt containing this request block and nothing that restates the review rubric (the reviewer already has it):

```
mode: new | continue
thread_dir: <thread-dir>
round: <n>
output_file: <thread-dir>/round-<n>.md
target:
  kind: <kind>
  current_branch: <branch>
  base: <base>
  head: <head ref>
  head_sha: <sha>
  merge_base: <sha>
  include_local_changes: <true|false>
  paths: <paths>
focus: <focus text or empty>
previous_round_file: <thread-dir>/round-<n-1>.md        (continue only)
previous_fixes_file: <thread-dir>/round-<n-1>.fixes.md  (continue only, if it exists)
```

## Step 5: Report

When the reviewer returns, do not start fixing and do not re-review. Print, concisely:

- the verdict, and open counts per priority (P0 to P3),
- the Fix Queue, one line per finding with its ID, priority, and `file:line`,
- the Human Reviewer Callouts that apply,
- the path of the round file and the thread dir,
- the next step: `/review-fix` to implement the fixes, then `/review continue` to verify them. If the verdict is `correct`, say the loop is done.

If the reviewer failed or did not write the round file, say so plainly and show what it returned.
