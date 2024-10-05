{ pkgs, ... }:

{
  # vscode
  programs.vscode = {
    enable = true;
    extensions =
      with pkgs.vscode-extensions;
      [
        dart-code.flutter
        dracula-theme.theme-dracula
        github.copilot
        golang.go
        jnoortheen.nix-ide
        mkhl.direnv
        ms-azuretools.vscode-docker
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        vscodevim.vim
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "gitless";
          publisher = "maattdd";
          version = "11.7.2";
          sha256 = "rYeZNBz6HeZ059ksChGsXbuOao9H5m5lHGXJ4ELs6xc=";
        }
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
    };
  };
}
