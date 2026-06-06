{ ... }:

let
  agentsMd = ../../.config/ai/AGENTS.md;
in {
  home.file.".claude/rules".source = ../../.config/ai;
  home.file."AGENTS.md".source = agentsMd;
  home.file.".gemini/GEMINI.md".source = agentsMd;
  home.file.".codex/AGENTS.md".source = agentsMd;
  home.file.".config/crush/crush.json".source = ../../.config/crush/crush.json;

  programs.opencode = {
    enable = true;
    context = agentsMd;
    tui = {
      theme = "dracula";
      keybinds = {
        messages_first = "ctrl+g";
        messages_last = "ctrl+alt+g";
        input_line_home = "ctrl+a,home";
        input_line_end = "ctrl+e,end";
        input_buffer_home = "ctrl+shift+a";
        input_buffer_end = "ctrl+shift+e";
      };
    };
    settings = {
      permission = {
        edit = "ask";
        bash = {
          "basename *" = "allow";
          "cat *" = "allow";
          "cut *" = "allow";
          "date *" = "allow";
          "diff *" = "allow";
          "dirname *" = "allow";
          "echo *" = "allow";
          "file *" = "allow";
          "find *" = "allow";
          "git blame *" = "allow";
          "git describe *" = "allow";
          "git diff *" = "allow";
          "git help *" = "allow";
          "git log *" = "allow";
          "git ls-files *" = "allow";
          "git rev-parse *" = "allow";
          "git shortlog *" = "allow";
          "git show *" = "allow";
          "git stash list *" = "allow";
          "git stash show *" = "allow";
          "git status *" = "allow";
          "grep *" = "allow";
          "head *" = "allow";
          "jq *" = "allow";
          "ls *" = "allow";
          "pwd" = "allow";
          "readlink *" = "allow";
          "realpath *" = "allow";
          "rg *" = "allow";
          "sort *" = "allow";
          "stat *" = "allow";
          "tail *" = "allow";
          "tree *" = "allow";
          "type *" = "allow";
          "uniq *" = "allow";
          "wc *" = "allow";
          "which *" = "allow";
          "*" = "ask";
        };
      };
      provider.openrouter.models."deepseek/deepseek-v4-flash:deepseek" = {
        id = "deepseek/deepseek-v4-flash:deepseek";
      };
      agent = {
        general.model = "opencode-go/deepseek-v4-flash";
        explore.model = "opencode-go/deepseek-v4-flash";
        scout.model = "opencode-go/deepseek-v4-flash";
      };
    };
  };
}