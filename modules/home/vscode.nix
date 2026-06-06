{ pkgs, ... }:

{
  # vscode
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        dart-code.flutter
        dracula-theme.theme-dracula
        golang.go
        jnoortheen.nix-ide
        ms-azuretools.vscode-docker
        nefrob.vscode-just-syntax
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        vscodevim.vim
        yzane.markdown-pdf
      ] ++ [
        (pkgs.vscode-utils.extensionFromVscodeMarketplace {
          name = "devenv";
          publisher = "datakurre";
          version = "0.6.0";
          sha256 = "0ifx86zqxwgbib0cf5ilvibhl5fx2shggnip6i8aqn5v00zy480v";
        })
        (pkgs.vscode-utils.extensionFromVscodeMarketplace {
          name = "opencode";
          publisher = "sst-dev";
          version = "0.0.13";
          sha256 = "e9a75751aa21fce3f9c9822d1f718043b1a9ba97e64c66b190a3fa85850c60d4";
        })
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
        "markdown-pdf.executablePath" = "/etc/profiles/per-user/beefsack/bin/chromium";
        "terminal.integrated.enableKittyKeyboardProtocol" = false;
        "git.blame.editorDecoration.enabled" = true;
      };
    };
  };
}
