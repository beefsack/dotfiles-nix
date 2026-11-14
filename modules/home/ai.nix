{ pkgs, ... }:

let
  agentsMd = ../../home/.agents/AGENTS.md;
in {
  # Rules deployed to each agent's expected location
  home.file."AGENTS.md".source = agentsMd;
  home.file.".gemini/GEMINI.md".source = agentsMd;
  home.file.".codex/AGENTS.md".source = agentsMd;
  home.file.".claude/rules/AGENTS.md".source = agentsMd;
  home.file.".config/crush/crush.json".source = ../../home/.config/crush/crush.json;
  home.file.".acpx/config.json".source = ../../home/.acpx/config.json;

  home.packages = with pkgs; [
    claude-code
    codex
    crush
    herdr
    lmstudio
    pi-coding-agent
  ];

  programs.antigravity-cli.enable = true;

  programs.opencode = {
    enable = true;
    context = agentsMd;
    cli = {
      theme.name = "dracula";
      keybinds = {
        "session.first" = "ctrl+g";
        "session.last" = "ctrl+alt+g";
        "input.line.home" = "ctrl+a,home";
        "input.line.end" = "ctrl+e,end";
        "input.buffer.home" = "ctrl+shift+a";
        "input.buffer.end" = "ctrl+shift+e";
      };
    };
    settings = {
      default_agent = "orchestrator";
      providers = {
        google.models.gemini-4-hydrogen.body.service_tier = "flex";
        openrouter.models."google/gemini-4-hydrogen".body.service_tier = "flex";
      };
      plugins = [
        "@openchamber/opencode-claude"
        "github:beefsack/auto-context-handover"
      ];
      skills.urls = [
        "https://raw.githubusercontent.com/beefsack/processed-beef/main/skills/"
        "https://raw.githubusercontent.com/beefsack/acpx-subagent/main/skills/"
      ];
      experimental.subagent_depth = 3;
      agents = {
        orchestrator = {
          model = "claude-code/claude-opus-5-5#high";
          mode = "primary";
          permissions = [
            { action = "subagent"; resource = "*"; effect = "allow"; }
          ];
          system = "Load the processed-beef skill. Use the lead agent for the lead role. Ask the user which worker agent they want to use as there may be multiple `worker-*` agents, or if they want to use an alternate mechanism for the worker such as the acpx-subagent skill.";
        };
        lead = {
          model = "openai/gpt-6.1-sol#high";
          mode = "subagent";
          permissions = [
            { action = "subagent"; resource = "*"; effect = "deny"; }
            { action = "subagent"; resource = "worker-*"; effect = "allow"; }
            { action = "subagent"; resource = "explore"; effect = "allow"; }
            { action = "subagent"; resource = "scout"; effect = "allow"; }
          ];
        };
        worker-google = {
          model = "google/gemini-4-hydrogen#medium";
          mode = "subagent";
          permissions = [
            { action = "subagent"; resource = "*"; effect = "deny"; }
            { action = "subagent"; resource = "explore"; effect = "allow"; }
            { action = "subagent"; resource = "scout"; effect = "allow"; }
          ];
        };
        worker-opencode-go = {
          model = "opencode-go/muse-spark-1.3-contributor#high";
          mode = "subagent";
          permissions = [
            { action = "subagent"; resource = "*"; effect = "deny"; }
            { action = "subagent"; resource = "explore"; effect = "allow"; }
            { action = "subagent"; resource = "scout"; effect = "allow"; }
          ];
        };
        explore.model = "opencode-go/muse-spark-1.3-contributor#high";
        general.model = "opencode-go/muse-spark-1.3-contributor#high";
        scout.model = "opencode-go/muse-spark-1.3-contributor#high";
      };
    };
  };
}
