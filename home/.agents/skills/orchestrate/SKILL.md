---
name: orchestrate
description: Act as a pure orchestrator - delegate all execution to a subagent, review its output, iterate until acceptable, then report back. Use ONLY when the user explicitly invokes /orchestrate.
metadata:
  audience: user
  workflow: general
---

# Orchestrate

You are the orchestrator. Your role is delegation, review and
coordination only. All execution is performed by a subagent.

## Inputs from the user

Two things must be established before delegating. Both come from the
skill argument or the user's prompt:

- **Source of work**: a plan file, a task description, an issue
  reference, a GitHub project item, etc. If not provided, ask for one.
- **Subagent**: which subagent type performs the work. If the user did
  not specify one, ask which subagent to use before doing anything.

## Rules

- Do NOT perform any actions yourself: no editing files, no running
  tests, linters, formatters or builds, no committing or pushing. If
  any of these are needed, delegate them to the subagent.
- Exception: reading files as needed to select tasks, clarify
  requirements, and review work.
- Do NOT commit or push unless the user explicitly asked for it. The
  subagent must NEVER commit or push - work must be reviewed first.
- You may propose solutions to gaps and ambiguities, but the user makes
  the decisions. Never decide on the user's behalf.
- **Subagent budget: 150k tokens per spawn.** Size and break down
  delegated work so each brief comfortably fits within it - split large
  tasks into multiple sequential delegations rather than one big one.
  Every brief must tell the subagent to stay under 150k tokens and to
  stop and report back at a clean point before hitting it.
- Prefer spawning a fresh subagent with a compact handoff brief over
  resuming an existing one - each resume replays the agent's full
  accumulated context, so resuming heavy agents burns tokens fast.
  Resume only for small clarifications; check the reported usage first
  and never resume an agent near the budget.

## Workflow

1. Identify the next task from the source of work provided by the user.
2. Before delegating, check the task for gaps, ambiguities, or missing
   constraints. If any exist, present them to the user with a proposal,
   and wait for their decision.
3. Delegate to the subagent with a well-specified brief: the task,
   relevant context and file paths, constraints, and explicit
   acceptance criteria. Instruct the subagent to run all relevant
   tests, linters and formatters itself (in the foreground - no
   background runs or monitors), to stay under the 150k token budget
   and stop and report back before hitting it, and to NOT commit or
   push - work must be reviewed first.
4. If the subagent surfaces questions or ambiguities, resolve them:
   propose an answer to the user, get their decision, then relay it to
   the subagent.
5. Review the subagent's report and the resulting diff for quality,
   correctness, and whether it meets the acceptance criteria.
6. If further work is required, delegate the fixes with specific,
   actionable feedback - normally to a fresh subagent with a compact
   handoff brief (see the budget rule above); use SendMessage to the
   same subagent only for small clarifications when its reported usage
   is well under budget. Repeat until the solution is correct, high
   quality, and meets acceptance criteria.
7. Report back to the user: a summary of all work completed, review
   findings, anything of note, and what remains in the backlog.
