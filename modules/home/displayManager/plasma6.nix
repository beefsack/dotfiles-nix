{ pkgs, config, lib, osConfig, ... }:

let
  cfg = osConfig.beefsack.displayManager.plasma6;
in {
  config = lib.mkIf cfg.enable {
    programs.plasma = {
      enable = true;

      workspace = {
        colorScheme = "Dracula";
        theme = "Dracula";
        wallpaper = "${config.home.homeDirectory}/.config/wallpaper/nixos.png";
      };

      kwin.effects.shakeCursor.enable = false;

      panels = [
        {
          location = "top";
          widgets = [
            "org.kde.plasma.kickoff"
            {
              name = "org.kde.plasma.pager";
              config.General.displayedText = "Number";
            }
            "org.kde.plasma.panelspacer"
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.digitalclock"
            "org.kde.plasma.panelspacer"
            {
              systemTray.items = {
                shown = [
                  "org.kde.plasma.cameraindicator"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.manage-inputmethod"
                  "org.kde.plasma.keyboardlayout"
                  "org.kde.plasma.devicenotifier"
                  "org.kde.plasma.mediacontroller"
                  "org.kde.plasma.notifications"
                  "org.kde.kscreen"
                  "org.kde.plasma.battery"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.keyboardindicator"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.printmanager"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.weather"
                ];
              };
            }
          ];
        }
      ];

      hotkeys.commands = {
        launch-browser = {
          name = "Launch Browser";
          key = "Meta+B";
          command = "firefox";
        };
        launch-terminal = {
          name = "Launch Terminal";
          key = "Meta+T";
          command = "ghostty";
        };
      };
    };
  };
}
