{ config, pkgs, ... }:

{
  home.username = "beefsack";
  home.homeDirectory = "/home/beefsack";

  home.sessionVariables = {
    EDITOR = "nvim";
    GTK_THEME = "Dracula:dark";
    NIXOS_OZONE_WL = 1;
  };

  dconf = {
    enable = true;
    settings = {
      # Allow fractional scaling
      "org/gnome/mutter".experimental-features = [ "scale-monitor-framebuffer" ];
      # Favourite apps
      "org/gnome/shell" = {
        favorite-apps = [
          "firefox.desktop"
          "code.desktop"
          "kitty.desktop"
          "org.gnome.Nautilus.desktop"
        ];
        disable-user-extensions = false;
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "forge@jmmaranan.com"
        ];
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
      };
      "org/gnome/desktop/wm/preferences" = {
        workspace-names = [ "Main" ];
      };
      "org/gnome/desktop/background" = {
        picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-l.png";
        picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-d.png";
      };
      "org/gnome/desktop/screensaver" = {
        picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-d.png";
        primary-color = "#3465a4";
        secondary-color = "#000000";
      };
      "org/gnome/shell/extensions/forge" = {
        dnd-center-layout = "stacked";
        window-gap-size = 3;
      };
      # Keybindings
      "org/gnome/shell/extensions/forge/keybindings" = {
        "window-focus-down" = ["<Super>Down"];
        "window-focus-left" = ["<Super>Left"];
        "window-focus-right" = ["<Super>Right"];
        "window-focus-up" = ["<Super>Up"];
        "window-move-down" = ["<Shift><Super>Down"];
        "window-move-left" = ["<Shift><Super>Left"];
        "window-move-right" = ["<Shift><Super>Right"];
        "window-move-up" = ["<Shift><Super>Up"];
        # Disable prefs toggle as it conflicts with kitty
        "prefs-tiling-toggle" = [];
      };
      "org/gnome/mutter/keybindings" = {
        # Disable super left and right as we use that for focus
        toggle-tiled-left = [];
        toggle-tiled-right = [];
      };
      "org/gnome/desktop/wm/keybindings" = {
        # Disable super and arrows as we need them
        unmaximize = [];
        maximize = [];
        move-to-monitor-down = [];
        move-to-monitor-left = [];
        move-to-monitor-right = [];
        move-to-monitor-up = [];
        switch-to-workspace-1 = ["<Super>1"];
        switch-to-workspace-2 = ["<Super>2"];
        switch-to-workspace-3 = ["<Super>3"];
        switch-to-workspace-4 = ["<Super>4"];
        move-to-workspace-1 = ["<Shift><Super>1"];
        move-to-workspace-2 = ["<Shift><Super>2"];
        move-to-workspace-3 = ["<Shift><Super>3"];
        move-to-workspace-4 = ["<Shift><Super>4"];
      };
      "org/gnome/shell/keybindings" = {
        # Disable super and numbers as we need them for workspace switching
        switch-to-application-1 = [];
        switch-to-application-2 = [];
        switch-to-application-3 = [];
        switch-to-application-4 = [];
      };
      # Kitty launch keybind
      "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        "binding" = "<Super>t";
        "command" = "kitty";
        "name" = "Kitty";
      };
      # Firefox launch bind
      "org/gnome/settings-daemon/plugins/media-keys".www = ["<Super>w"];
    };
  };
  home.file.".config/forge/stylesheet/forge/stylesheet.css".source = .config/forge/stylesheet/forge/stylesheet.css;

  # ...
  gtk = {
    enable = true;

    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
    };

    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # gnome
    gnomeExtensions.forge

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

    # theme
    dracula-theme

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
    firefox

    # programming
    go
    nodejs_21
    rustup

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
  };
  programs.starship.enable = true;
  home.file.".config/fish/conf.d/greeting.fish".source = .config/fish/conf.d/greeting.fish;
  home.file.".config/fish/conf.d/starship.fish".source = .config/fish/conf.d/starship.fish;

  # vscode
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      dracula-theme.theme-dracula
      rust-lang.rust-analyzer
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
      "workbench.colorTheme" = "Dracula";
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
