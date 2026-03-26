{ config, lib, osConfig, cosmicLib, ... }:

let
  cfg = osConfig.beefsack.displayManager.cosmic;
  mkRON = cosmicLib.cosmic.mkRON;
in {
  config = lib.mkIf cfg.enable {
    programs.cosmic-ext-ctl.enable = true;

    wayland.desktopManager.cosmic = {
      enable = true;
      systemActions = mkRON "map" [
        {
          key = mkRON "enum" "Terminal";
          value = "ghostty";
        }
      ];
      shortcuts = [
        {
          action = mkRON "enum" "ToggleSticky";
          key = "Super+Shift+G";
        }
        {
          action = mkRON "enum" {
            value = [ (mkRON "enum" "AppLibrary") ];
            variant = "System";
          };
          key = "Super";
        }
      ];
      compositor = {
        autotile = true;
        autotile_behavior = mkRON "enum" "PerWorkspace";
      };
      wallpapers = [{
        output = "all";
        source = mkRON "enum" {
          value = [ "${config.home.homeDirectory}/.config/wallpaper/nixos.png" ];
          variant = "Path";
        };
        filter_by_theme = false;
        filter_method = mkRON "enum" "Lanczos";
        rotation_frequency = 0;
        sampling_method = mkRON "enum" "Alphanumeric";
        scaling_mode = mkRON "enum" "Zoom";
      }];
      idle = {
        screen_off_time = null;
        suspend_on_ac_time = null;
        suspend_on_battery_time = null;
      };
      appearance.theme = import ./cosmic-theme.nix { inherit mkRON; };
      panels = [
        {
          name = "Panel";
          anchor = mkRON "enum" "Top";
          anchor_gap = false;
          autohide = mkRON "optional" null;
          autohover_delay_ms = mkRON "optional" 500;
          background = mkRON "enum" "ThemeDefault";
          border_radius = 0;
          exclusive_zone = true;
          expand_to_edges = true;
          keyboard_interactivity = mkRON "enum" "OnDemand";
          layer = mkRON "enum" "Top";
          margin = 0;
          opacity = 1.0;
          output = mkRON "enum" "All";
          padding = 0;
          plugins_center = mkRON "optional" [
            "com.system76.CosmicAppletTime"
          ];
          plugins_wings = mkRON "optional" (mkRON "tuple" [
            [
              "com.system76.CosmicAppletWorkspaces"
            ]
            [
              "com.system76.CosmicAppletInputSources"
              "com.system76.CosmicAppletStatusArea"
              "com.system76.CosmicAppletTiling"
              "com.system76.CosmicAppletAudio"
              "com.system76.CosmicAppletNetwork"
              "com.system76.CosmicAppletBattery"
              "com.system76.CosmicAppletNotifications"
              "com.system76.CosmicAppletBluetooth"
              "com.system76.CosmicAppletPower"
            ]
          ]);
          size = mkRON "enum" "XS";
          spacing = 2;
        }
      ];
    };
  };
}
