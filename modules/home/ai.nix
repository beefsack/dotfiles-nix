{ ... }:

let
  agentsMd = ../../.config/ai/AGENTS.md;
in {
  home.file.".claude/rules".source = ../../.config/ai;
  home.file."AGENTS.md".source = agentsMd;
  home.file.".config/opencode/AGENTS.md".source = agentsMd;
  home.file.".gemini/GEMINI.md".source = agentsMd;
  home.file.".codex/AGENTS.md".source = agentsMd;
  home.file.".config/crush/crush.json".source = ../../.config/crush/crush.json;
}