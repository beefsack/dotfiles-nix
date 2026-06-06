---
name: nixos-review
description: Review NixOS/home-manager changes before applying them. Use when the user asks to review config changes, check a nix flake, or validate module modifications before a rebuild.
compatibility: opencode
metadata:
  audience: maintainers
  workflow: nixos
---

## What I do
- Run `git diff` to inspect uncommitted Nix changes
- Run `nix flake check` to validate the configuration
- Identify risks: missing imports, syntax errors, unclosed braces
- Summarize changes and flag anything that could break a rebuild

## Instructions
1. Run `git diff HEAD` and review the diff for Nix-specific issues
2. If changes touch module files, check that imports and options are consistent
3. If a flake.nix is available, run `nix flake check` and report any errors
4. Summarize the changes in bullet points and list any risks
5. If the diff is empty, report that there are no uncommitted changes
