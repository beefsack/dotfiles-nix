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
    pi-coding-agent
  ];

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
      plugin = ["superpowers@git+https://github.com/obra/superpowers.git"];
      permission = {
        edit = "ask";
        bash = {
          "basename *" = "allow";
          "cargo build *" = "allow";
          "cargo check *" = "allow";
          "cargo clippy *" = "allow";
          "cargo test *" = "allow";
          "cat *" = "allow";
          "cut *" = "allow";
          "date *" = "allow";
          "diff *" = "allow";
          "dirname *" = "allow";
          "echo *" = "allow";
          "file *" = "allow";
          "find *" = "allow";
          "gh auth status *" = "allow";
          "gh config list *" = "allow";
          "gh issue list *" = "allow";
          "gh issue status *" = "allow";
          "gh issue view *" = "allow";
          "gh pr checks *" = "allow";
          "gh pr diff *" = "allow";
          "gh pr list *" = "allow";
          "gh pr status *" = "allow";
          "gh pr view *" = "allow";
          "gh project field-list *" = "allow";
          "gh project field-view *" = "allow";
          "gh project item-list *" = "allow";
          "gh project item-view *" = "allow";
          "gh project list *" = "allow";
          "gh project view *" = "allow";
          "gh run list *" = "allow";
          "gh run view *" = "allow";
          "gh run watch *" = "allow";
          "gh search issues *" = "allow";
          "gh search prs *" = "allow";
          "gh workflow list *" = "allow";
          "gh workflow view *" = "allow";
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
          "sleep *" = "allow";
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
