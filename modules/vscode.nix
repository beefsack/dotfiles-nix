{ pkgs, ... }:

{
  # vscode
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        dart-code.flutter
        dracula-theme.theme-dracula
        eamodio.gitlens
        github.copilot
        golang.go
        jnoortheen.nix-ide
        mkhl.direnv
        ms-azuretools.vscode-docker
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        vscodevim.vim
      ];
      userSettings = {
        "telemetry.telemetryLevel" = "off";
        "workbench.startupEditor" = "none";
        "workbench.colorTheme" = "Dracula Theme";
        "vim.useSystemClipboard" = true;
        "window.titleBarStyle" = "custom";
        "editor.fontFamily" = "SauceCodePro Nerd Font Mono";
        "editor.fontWeight" = 500;
        "editor.fontSize" = 16;
        "editor.rulers" = [ 80 ];
        "vim.handleKeys" = {
          "<C-p>" = false;
        };
        "[rust]" = {
          "editor.rulers" = [ 120 ];
          "editor.formatOnSave" = true;
        };
        "update.mode" = "none";
        "[dart]" = {
          "editor.formatOnSave" = true;
          "editor.formatOnType" = true;
          "editor.selectionHighlight" = false;
        };
        "rust-analyzer.check.command" = "clippy";
      };
    };
  };
}
