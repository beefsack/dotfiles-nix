{ config, pkgs, lib, ... }:

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
      # Mouse settings
      "org/gnome/desktop/peripherals/mouse" = {
        "accel-profile" = "flat";
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        "natural-scroll" = false;
      };
      "org/gnome/desktop/session" = {
        # Don't turn monitor off
        idle-delay = lib.hm.gvariant.mkUint32 0;

      };
      "org/gnome/settings-daemon/plugins/power" = {
        # Don't automatically suspend on AC
        sleep-inactive-ac-type = "nothing";
        # Suspend after an hour on battery
        sleep-inactive-battery-type = "suspend";
        sleep-inactive-battery-timeout = 3600;
        # Power button does nothing
        power-button-action = "nothing";
        # Don't dim screen
        idle-dim = false;
      };
      # Favourite apps
      "org/gnome/shell" = {
        favorite-apps = [
          "code.desktop"
          "firefox.desktop"
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
        gtk-theme = "Dracula";
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        icon-theme = "Dracula";
      };
      "org/gnome/desktop/wm/preferences" = {
        workspace-names = [ "Main" ];
        theme = "Dracula";
      };
      "org/gnome/shell/extensions/user-theme" = {
        name = "Dracula";
      };
      "org/gnome/desktop/background" = {
        picture-uri = "file:///home/beefsack/.config/wallpaper/nixos.png";
        picture-uri-dark = "file:///home/beefsack/.config/wallpaper/nixos.png";
      };
      "org/gnome/desktop/screensaver" = {
        picture-uri = "file:///home/beefsack/.config/wallpaper/nixos.png";
        primary-color = "#BD93F9";
        secondary-color = "#282A36";
      };
      "org/gnome/shell/extensions/forge" = {
        dnd-center-layout = "stacked";
        window-gap-size = 3;
        move-pointer-focus-enabled = false;
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
      "org/gnome/settings-daemon/plugins/media-keys" = {
        # Firefox launch bind
        www = ["<Super>w"];
        # Files launch bind
        home = ["<Super>e"];
      };
    };
  };
  home.file.".config/forge/stylesheet/forge/stylesheet.css" = {
    source = .config/forge/stylesheet/forge/stylesheet.css;
    recursive = true;
  };
  home.file.".config/wallpaper/nixos.png" = {
    source = .config/wallpaper/nixos.png;
    recursive = true;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # gnome
    dracula-icon-theme
    dracula-theme
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
    devenv
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

  # vscode
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      dracula-theme.theme-dracula
      golang.go
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
