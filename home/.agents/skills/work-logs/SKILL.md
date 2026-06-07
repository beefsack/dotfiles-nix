---
name: work-logs
description: Create and manage work log directories for tracking task progress, decisions, and audit trails. Use ONLY when the user asks to create a work log, start a work log, or dump the current task state.
compatibility: opencode
metadata:
  audience: user
  workflow: general
---

# Work Logs

A work log directory tracks everything that happens during a task -- an
audit log, the plan, decisions, and ephemeral files.

## Directory Structure

Every work log directory contains:

| File            | Purpose                                                                                   | Edit? |
| --------------- | ----------------------------------------------------------------------------------------- | ----- |
| `LOG.md`        | Append-only audit log of every action, command, outcome, decision, problem, and failure   | No    |
| `PLAN.md`       | Full plan in detail with status of each item; includes a section for every decision made  | Yes   |
| `CURRENT_TASK.md` | Exhaustive dump of current task state -- created only when the user asks                 | Yes   |

Supplemental files provided by the user should be copied into the work log
directory for future reference. Large command/tool output should also be
stored here as referenced files.

## Naming

Work log directories are prefixed with a timestamp that includes hour and
minute: `<YYYY-MM-DD>-<HH><MM>-<description>`.

Example: `2026-06-06-1430-fix-auth-bug`

## When to Create a Work Log

- Only create a work log directory when the user explicitly requests it.
- If the user asks to create a work log but does not specify the parent
  directory, ask where they want it placed. Never assume a location.

## LOG.md

- **Append-only.** Never read or edit this file after creation.
- Every entry must include a timestamp.
- Record everything: what the user asked, every tool use, command outcomes,
  decisions made, problems encountered, failures, and anything else needed
  to reconstruct exactly what happened.
- Use `>>` to append.

### Format

```markdown
## <ISO timestamp>

- <action or event>
- <command run and its exit code>
- <decision made and why>
- <problem or failure>
```

## PLAN.md

- Full plan describing the task in detail.
- Every item has a status: `[ ]` pending, `[x]` done.
- Contains a **Decisions** section at the bottom. Every decision that needs
  to be made is listed there. Mark decisions as `[DECIDED]` or
  `[UNDECIDED]`. No decision is final unless the user has agreed to it.
- Update PLAN.md as the plan evolves.

### Format

```markdown
# Plan: <description>

## Steps

- [ ] Step one
- [ ] Step two

## Decisions

- [UNDECIDED] What approach to use for X?
  - Option A: ...
  - Option B: ...

- [DECIDED] Use Y because user said Z.
```

## CURRENT_TASK.md

- Created only when the user says "dump all information about the current
  task" or equivalent.
- Write an exhaustively detailed description of what is being worked on
  right now.
- Must include all relevant background information and knowledge so the
  agent does not need to research again.
- Must include the short-term plan for the current task in full detail.

### Format

```markdown
# Current Task: <description>

## Background

<Everything relevant: context, history, related files, decisions already
made, constraints, dependencies, user preferences.>

## Current State

<Where things stand right now -- what is done, what is in progress, what
blocked.>

## Immediate Plan

<Step-by-step next actions in full detail. Include exact commands, file
paths, expected outcomes.>
```
