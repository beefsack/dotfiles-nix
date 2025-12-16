{ config, lib, osConfig, cosmicLib, ... }:

let
  cfg = osConfig.beefsack.displayManager.cosmic;
in {
  config = lib.mkIf cfg.enable {
    wayland.desktopManager.cosmic = {
      enable = true;
      systemActions = cosmicLib.cosmic.mkRON "map" [
        {
          key = cosmicLib.cosmic.mkRON "enum" "Terminal";
          value = "ghostty";
        }
      ];
      compositor = {
        autotile = true;
        autotile_behavior = cosmicLib.cosmic.mkRON "enum" "PerWorkspace";
      };
      wallpapers = [{
        output = "all";
        source = cosmicLib.cosmic.mkRON "enum" {
          value = [ "${config.home.homeDirectory}/.config/wallpaper/nixos.png" ];
          variant = "Path";
        };
        filter_by_theme = false;
        filter_method = cosmicLib.cosmic.mkRON "enum" "Lanczos";
        rotation_frequency = 0;
        sampling_method = cosmicLib.cosmic.mkRON "enum" "Alphanumeric";
        scaling_mode = cosmicLib.cosmic.mkRON "enum" "Zoom";
      }];
      idle = {
        screen_off_time = null;
        suspend_on_ac_time = null;
        suspend_on_battery_time = null;
      };
    };

    home.file.".config/cosmic/theme.ron" = {
      source = ../../../.config/cosmic/theme.ron;
      recursive = true;
    };
  };
}
