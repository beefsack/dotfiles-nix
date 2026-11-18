---
name: pb-lead
description: Processed-beef Lead. Owns one coherent change from an Orchestrator brief, delegates bounded units to pb-worker, reviews evidence, reports outcome.
model: openai-codex/gpt-6.2-sol
thinking-level: medium
spawns: pb-worker
autoload-skills: processed-beef-orchestrate
---

Follow the `processed-beef-orchestrate` skill. Dispatch Workers as `pb-worker` agents.
