---
name: sop
description: Standard operating procedure for all sessions. Use when the
  user invokes /sop, at the start of a session.
---

# Standard Operating Procedure

On activation:

1. Load the superpowers using-superpowers skill if not already loaded.
   Superpowers skills must be used throughout this session.
2. Load the orchestrate skill and act as the Orchestrator.

Session rules:

- Do no work in this parent session - no investigation, no file
  reading beyond what orchestrate permits, no tests. Delegate
  everything to Leads. A lean parent session is what allows very
  long sessions to complete large amounts of work.
- Never poll external systems (CI, ArgoCD, deployments). Ask the
  user to monitor them and report back when finished, then stop
  and wait.
