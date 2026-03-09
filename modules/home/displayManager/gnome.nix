{ pkgs, lib, osConfig, config, ... }:

let
  cfg = osConfig.beefsack.displayManager.gnome;
in {
  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.gnomeExtensions.forge
    ];

    home.file.".config/forge/stylesheet/forge/stylesheet.css".source =
      ./forge/stylesheet.css;

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [
          pkgs.gnomeExtensions.appindicator.extensionUuid
          pkgs.gnomeExtensions.forge.extensionUuid
        ];
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-theme = "Adwaita";
        monospace-font-name = "SauceCodePro Nerd Font Mono Medium 13";
        enable-hot-corners = false;
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "icon:minimize,maximize,close";
      };

      "org/gnome/desktop/session" = {
        idle-delay = lib.hm.gvariant.mkUint32 0;
      };

      "org/gnome/settings-daemon/plugins/power" = {
        idle-dim = false;
        power-button-action = "nothing";
        sleep-inactive-ac-type = "nothing";
      };

      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
      };

      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" "xwayland-native-scaling" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        home = [ "<Super>f" ];
        www = [ "<Super>b" ];
        custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Ghostty";
        command = "ghostty";
        binding = "<Super>t";
      };

      "org/gnome/desktop/background" = {
        picture-uri = "file://${config.home.homeDirectory}/.config/wallpaper/nixos.png";
        picture-uri-dark = "file://${config.home.homeDirectory}/.config/wallpaper/nixos.png";
      };

      "org/gnome/desktop/screensaver" = {
        picture-uri = "file://${config.home.homeDirectory}/.config/wallpaper/nixos.png";
      };

      "org/gnome/shell/extensions/forge" = {
        dnd-center-layout = "stacked";
        focus-border-toggle = true;
        move-pointer-focus-enabled = false;
        window-gap-size = lib.hm.gvariant.mkUint32 3;
      };

      "org/gnome/desktop/wm/keybindings" = {
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        switch-to-workspace-6 = [ "<Super>6" ];
        switch-to-workspace-7 = [ "<Super>7" ];
        switch-to-workspace-8 = [ "<Super>8" ];
        switch-to-workspace-9 = [ "<Super>9" ];
        switch-to-workspace-last = [ "<Super>0" ];
        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];
        move-to-workspace-5 = [ "<Shift><Super>5" ];
        move-to-workspace-6 = [ "<Shift><Super>6" ];
        move-to-workspace-7 = [ "<Shift><Super>7" ];
        move-to-workspace-8 = [ "<Shift><Super>8" ];
        move-to-workspace-9 = [ "<Shift><Super>9" ];
        move-to-workspace-last = [ "<Shift><Super>0" ];
      };

      "org/gnome/shell/extensions/forge/keybindings" = {
        con-split-horizontal = [ "<Super>z" ];
        con-split-layout-toggle = [ "<Super>g" ];
        con-split-vertical = [ "<Super>v" ];
        con-stacked-layout-toggle = [ "<Shift><Super>s" ];
        con-tabbed-layout-toggle = [ "<Shift><Super>t" ];
        con-tabbed-showtab-decoration-toggle = [ "<Control><Alt>y" ];
        focus-border-toggle = [ "<Super>x" ];
        prefs-tiling-toggle = [];
        window-focus-down = [ "<Super>Down" ];
        window-focus-left = [ "<Super>Left" ];
        window-focus-right = [ "<Super>Right" ];
        window-focus-up = [ "<Super>Up" ];
        window-gap-size-decrease = [ "<Control><Super>minus" ];
        window-gap-size-increase = [ "<Control><Super>plus" ];
        window-move-down = [ "<Shift><Super>Down" ];
        window-move-left = [ "<Shift><Super>Left" ];
        window-move-right = [ "<Shift><Super>Right" ];
        window-move-up = [ "<Shift><Super>Up" ];
        window-snap-center = [ "<Control><Alt>c" ];
        window-snap-one-third-left = [ "<Control><Alt>d" ];
        window-snap-one-third-right = [ "<Control><Alt>g" ];
        window-snap-two-third-left = [ "<Control><Alt>e" ];
        window-snap-two-third-right = [ "<Control><Alt>t" ];
        window-swap-down = [ "<Control><Super>j" ];
        window-swap-last-active = [ "<Super>Return" ];
        window-swap-left = [ "<Control><Super>h" ];
        window-swap-right = [ "<Control><Super>l" ];
        window-swap-up = [ "<Control><Super>k" ];
        window-toggle-always-float = [ "<Shift><Super>c" ];
        window-toggle-float = [ "<Super>c" ];
        workspace-active-tile-toggle = [ "<Shift><Super>w" ];
      };
    };
  };
}
