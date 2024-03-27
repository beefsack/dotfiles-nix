{ config, pkgs, ... }:

{
  home.username = "beefsack";
  home.homeDirectory = "/home/beefsack";

  systemd.user.sessionVariables = {
    EDITOR = "nvim";
    GTK_THEME = "Dracula:dark";
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
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
    file
    gawk
    gnupg
    gnused
    gnutar
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

    # hyprland
    dracula-theme
    nwg-bar
    nwg-displays
    nwg-drawer
    nwg-panel
    waybar
    wlr-randr
    wofi

    # terminal
    kitty-themes

    # fonts
    nerdfonts

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

  # hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,auto";
      source = "~/.config/hypr/monitors.conf";
      "$mod" = "SUPER";
      "exec-once" = [
        "nwg-panel"
      ];
      misc = {
        force_default_wallpaper = "0";
      };
      input = {
        kb_layout = "us";
	follow_mouse = "2";
        touchpad = {
          natural_scroll = "no";
        };
	accel_profile = "flat";
      };
      bind = [
        "$mod, T, exec, kitty"
        "$mod, W, exec, firefox"
        "$mod, F, fullscreen, 0"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, V, togglefloating,"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"
  
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
  
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
  
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
  
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
  
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];
  
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bindr = [
        "$mod, SUPER_L, exec, nwg-drawer"
      ];

      general = {
	"col.active_border" = "rgb(44475a) rgb(bd93f9) 90deg";
	"col.inactive_border" = "rgba(44475aaa)";
	"col.nogroup_border" = "rgba(282a36dd)";
	"col.nogroup_border_active" = "rgb(bd93f9) rgb(44475a) 90deg";
	no_border_on_floating = "false";
	border_size = "2";
	gaps_in = "3";
	gaps_out = "10";
      };
      decoration = {
        rounding = "6";
        "col.shadow" = "rgba(1E202966)";
	drop_shadow = "yes";
	shadow_range = "60";
	shadow_offset = "1 2";
	shadow_render_power = "3";
	shadow_scale = "0.97";
      };
      group = {
        groupbar = {
	  "col.active" = "rgb(bd93f9) rgb(44475a) 90deg";
	  "col.inactive" = "rgba(282a36dd)";
	};
      };
      windowrulev2 = "bordercolor rgb(ff5555),xwayland:1 # check if window is xwayland";
    };
  };
  home.file.".config/nwg-panel/config".source = .config/nwg-panel/config;

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
