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

  home.packages = with pkgs; [
    antigravity-cli
    claude-code
    codex
    crush
    lmstudio
    pi-coding-agent
  ];

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
      plugins = [
        "@openchamber/opencode-claude"
        "github:beefsack/auto-context-handover"
      ];
      skills.urls = [
        "https://raw.githubusercontent.com/beefsack/processed-beef/main/skills/"
      ];
      experimental.subagent_depth = 3;
      agents = {
        orchestrator = {
          model = "claude-code/claude-opus-5-5#high";
          mode = "primary";
          permissions = [
            { action = "subagent"; resource = "*"; effect = "allow"; }
          ];
          system = "Load the processed-beef skill. Use the lead agent for the lead role and the worker agent for the worker role. All agents must be spawned in the foreground.";
        };
        lead = {
          model = "openai/gpt-6.1-sol#high";
          mode = "subagent";
          permissions = [
            { action = "subagent"; resource = "*"; effect = "deny"; }
            { action = "subagent"; resource = "worker"; effect = "allow"; }
            { action = "subagent"; resource = "explore"; effect = "allow"; }
            { action = "subagent"; resource = "scout"; effect = "allow"; }
          ];
        };
        worker = {
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
