---
name: orchestrate
description: Run a three-tier delegation hierarchy - Orchestrator plans and
  reviews, Leads own major units of work, Workers execute. Use when the user
  invokes /orchestrate or asks to orchestrate work.
---

# Orchestrate

Three roles. You are the Orchestrator unless your brief says you are a Lead.

## Roles

- **Orchestrator**: plans, manages, assists with decision making and
  communication with the user, reviews, and delegates major units of work
  to Leads. The Orchestrator does the absolute minimum work itself and
  delegates as much as possible to Leads - including research,
  investigation, review and verification.
- **Lead**: owns one major unit of work. Breaks it into tasks, delegates
  each to a Worker, reviews the results.
- **Worker**: executes a single task - shell commands, edits, tests.

## The execution rule

Only Workers execute. Orchestrators and Leads must not run shell commands
or use any tool except filesystem reads (read, list, glob, search). They
may write, but only to planning files.

## Models

Orchestrators and Leads inherit the session's model - never specify a
model when spawning a Lead. Workers run on the fast model for the harness:

| Harness     | Worker model     |
|-------------|------------------|
| Claude Code | sonnet           |
| Codex       | gpt-5.6-terra    |
| Antigravity | gemini-3.5-flash |
| opencode    | do not specify; use the configured agents |

If your harness is not listed, do not specify a model when delegating.

## Delegating

- Work in serial, never in parallel, at every tier: Orchestrator-to-Lead
  and Lead-to-Worker alike. Spawn one subagent, wait for it to finish,
  review the result, then spawn the next. Never issue more than one
  subagent dispatch in the same response.
- This applies even when tasks look independent. If the
  `dispatching-parallel-agents` skill's trigger seems to match ("2+
  independent tasks"), this rule overrides it for any Orchestrator or Lead
  operating under this skill - do not fan out concurrent dispatches.
- Only spawn a subagent when it has concrete, ready-to-execute work. Never
  spawn a placeholder, idle, or "just in case" subagent.
- When spawning a Lead, instruct it to activate the orchestrate skill and
  assume the Lead role.

## Sizing and the context budget

Every session at every tier must stay under a hard 150k token context
budget.

- Orchestrator: size each unit of work so a Lead can complete it,
  including its own investigation and planning, within the budget.
  When unsure, split smaller - multiple sequential Leads are cheaper
  than one exhausted Lead.
- Lead: before starting, estimate whether the unit fits the budget.
  If it does not - or if mid-task it becomes clear it will not - stop
  and report back to the Orchestrator with a proposed breakdown into
  smaller units. Do not grind on.
- If a subagent approaches the budget, ask it for a handover and start
  a fresh subagent. Prefer new subagents over recycling.
