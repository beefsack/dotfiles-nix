{ config, pkgs, ... }:

let
  agentsMd = ../../home/.agents/AGENTS.md;
in {
  # Rules deployed to each agent's expected location
  home.file."AGENTS.md".source = agentsMd;
  home.file.".gemini/GEMINI.md".source = agentsMd;
  home.file.".gemini/config/skills.json".text = builtins.toJSON {
    entries = [
      { path = "${config.home.homeDirectory}/.agents/skills"; }
    ];
  };
  home.file.".codex/AGENTS.md".source = agentsMd;
  home.file.".claude/rules/AGENTS.md".source = agentsMd;
  home.file.".config/crush/crush.json".source = ../../home/.config/crush/crush.json;

  home.packages = with pkgs; [
    claude-code
    codex
    crush
    herdr
    lmstudio
  ];

  programs.antigravity-cli.enable = true;

  programs.pi-coding-agent = {
    enable = true;
    mutableSettings = true;
    settings = {
      theme = "dracula";
      packages = [
        "npm:pi-subagents"
        "npm:pi-claude-bridge"
        "npm:pi-commandcode-provider"
        "npm:pi-provider-opencode-console"
        "npm:pi-multi-pass"
        "npm:pi-web-access"
        "npm:context-mode"
        "git:github.com/beefsack/auto-context-handover"
        "git:github.com/beefsack/processed-beef"
        "git:github.com/beefsack/work-bucket"
        "git:github.com/beefsack/pi-dracula@pi-package"
        "git:github.com/beefsack/pi-subagents-desktop-terminal"
      ];
      subagents.agentOverrides.worker = {
        model = "opencode-go-console/hy4-flash-free";
        thinking = "high";
        tools = "inherit";
      };
    };
  };

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
        commandcode.models."meta/muse-ember" = {
          name = "Muse Ember 1.0";
          limit = {
            context = 1048576;
            output = 131072;
          };
          capabilities = {
            tools = true;
            input = [ "text" "image" ];
            output = [ "text" ];
            reasoning = {
              supported = true;
              effort = [ "low" "medium" "high" "xhigh" "max" ];
            };
          };
          settings.reasoningEffort = "max";
        };
      };
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
          system = "Load the processed-beef skill. Use the lead agent for the lead role. Use the worker agent for the worker role.";
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
