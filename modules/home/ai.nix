{ ... }:

let
  agentsMd = ../../home/.agents/AGENTS.md;
  skillsDir = ../../home/.agents/skills;
in {
  # Rules deployed to each agent's expected location
  home.file."AGENTS.md".source = agentsMd;
  home.file.".gemini/GEMINI.md".source = agentsMd;
  home.file.".codex/AGENTS.md".source = agentsMd;
  home.file.".claude/rules/AGENTS.md".source = agentsMd;
  home.file.".config/crush/crush.json".source = ../../home/.config/crush/crush.json;

  # Skills deployed to multiple locations from single source
  home.file.".claude/skills".source = skillsDir;
  home.file.".agents/skills".source = skillsDir;

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
          "qsv *" = "allow";
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
          "yq *" = "allow";
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
