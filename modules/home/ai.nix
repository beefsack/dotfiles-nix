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
          "git diff *" = "allow";
          "git log *" = "allow";
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
    };
  };
}