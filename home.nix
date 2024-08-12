{ config, pkgs, lib, ... }:

{
  home.username = "beefsack";
  home.homeDirectory = "/home/beefsack";

  home.sessionVariables = {
    EDITOR = "nvim";
    GTK_THEME = "Dracula:dark";
    NIXOS_OZONE_WL = 1;
  };
  home.file.".config/wallpaper/nixos.png" = {
    source = .config/wallpaper/nixos.png;
    recursive = true;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # archives
    p7zip
    unzip
    xz
    zip

    # utils
    jq
    ripgrep

    # networking tools
    dnsutils

    # misc
    discord
    file
    gawk
    gnupg
    gnused
    gnutar
    pv
    redshift
    tree
    which
    zstd

    # monitoring
    btop
    iftop
    iotop
    lm_sensors
    sysstat

    # system call monitoring
    lsof
    ltrace
    strace

    # system tools
    ethtool
    pciutils
    usbutils

    # terminal
    kitty-themes

    # fonts
    liberation_ttf
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji

    # editors
    neovim

    # internet
    chromium
    firefox

    # programming
    devenv
    direnv
    gcc

    # productivity
    libreoffice-fresh

    # games
    sgt-puzzles

    # video
    ffmpeg
    # Video/Audio data composition framework tools like "gst-inspect", "gst-launch" ...
    gst_all_1.gstreamer
    # Common plugins like "filesrc" to combine within e.g. gst-launch
    gst_all_1.gst-plugins-base
    # Specialized plugins separated by quality
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    # Plugins to reuse ffmpeg to play almost every video format
    gst_all_1.gst-libav
    # Support the Video Audio (Hardware) Acceleration API
    gst_all_1.gst-vaapi
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Michael Alexander";
    userEmail = "beefsack@gmail.com";
  };

  # terminal
  programs.fish.enable = true;
  programs.kitty = {
    enable = true;
    theme = "Dracula";
    font = {
      name = "SauceCodePro Nerd Font Mono";
      size = 13;
    };
    settings = {
      hide_window_decorations = "yes";
    };
  };
  programs.starship.enable = true;
  home.file.".config/fish/conf.d/greeting.fish".source = .config/fish/conf.d/greeting.fish;
  home.file.".config/fish/conf.d/starship.fish".source = .config/fish/conf.d/starship.fish;
  home.file.".config/fish/conf.d/direnv.fish".source = .config/fish/conf.d/direnv.fish;

  # vscode
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      dracula-theme.theme-dracula
      golang.go
      mkhl.direnv
      ms-azuretools.vscode-docker
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      vscodevim.vim
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
      "editor.rulers" = [80];
      "vim.handleKeys" = {
        "<C-p>" = false;
      };
      "[rust]" = {
        "editor.rulers" = [120];
        "editor.formatOnSave" = true;
      };
      "update.mode" = "none";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
