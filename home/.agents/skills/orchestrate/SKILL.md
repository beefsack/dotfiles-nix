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

- Work in serial, never in parallel.
- When spawning a Lead, instruct it to activate the orchestrate skill and
  assume the Lead role.

## Context budget

Be efficient with context usage so all sessions stay under a 150k token
context budget. Size all delegated work to be achievable within 150k
tokens. If a subagent approaches 150k, ask it for a handover and start a
fresh subagent. Avoid recycling subagents - prefer spawning new ones.
