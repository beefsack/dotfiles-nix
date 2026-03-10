{ pkgs, config, lib, osConfig, ... }:

let
  cfg = osConfig.beefsack.displayManager.plasma6;
in {
  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.kdePackages.krohnkite
      pkgs.kdePackages.dynamic-workspaces
    ];

    # Custom KWin script: switch to / move window to the last (empty) desktop.
    # With dynamic-workspaces enabled, the last desktop is always empty.
    xdg.dataFile."kwin/scripts/last-desktop/metadata.json".text = builtins.toJSON {
      KPackageStructure = "KWin/Script";
      KPlugin = {
        Id = "last-desktop";
        Name = "Desktop Shortcuts";
        Description = "Move windows to and switch between desktops";
        License = "MIT";
        Version = "1.1";
      };
      "X-Plasma-API" = "javascript";
      "X-Plasma-API-Minimum-Version" = "6.0";
      "X-Plasma-MainScript" = "code/main.js";
    };
    xdg.dataFile."kwin/scripts/last-desktop/contents/code/main.js".text = ''
      function moveAndSwitch(index) {
        var desktops = workspace.desktops;
        if (index >= desktops.length) return;
        var target = desktops[index];
        var w = workspace.activeWindow;
        if (w) w.desktops = [target];
        workspace.currentDesktop = target;
      }

      registerShortcut("switch-to-last-desktop", "Switch to Last Desktop", "Meta+0", function() {
        var desktops = workspace.desktops;
        workspace.currentDesktop = desktops[desktops.length - 1];
      });
      registerShortcut("move-to-last-desktop", "Move Window to Last Desktop", "Meta+)", function() {
        moveAndSwitch(workspace.desktops.length - 1);
      });
      registerShortcut("move-and-switch-to-desktop-1", "Move Window and Switch to Desktop 1", "Meta+!", function() { moveAndSwitch(0); });
      registerShortcut("move-and-switch-to-desktop-2", "Move Window and Switch to Desktop 2", "Meta+@", function() { moveAndSwitch(1); });
      registerShortcut("move-and-switch-to-desktop-3", "Move Window and Switch to Desktop 3", "Meta+#", function() { moveAndSwitch(2); });
      registerShortcut("move-and-switch-to-desktop-4", "Move Window and Switch to Desktop 4", "Meta+$", function() { moveAndSwitch(3); });
      registerShortcut("move-and-switch-to-desktop-5", "Move Window and Switch to Desktop 5", "Meta+%", function() { moveAndSwitch(4); });
      registerShortcut("move-and-switch-to-desktop-6", "Move Window and Switch to Desktop 6", "Meta+^", function() { moveAndSwitch(5); });
      registerShortcut("move-and-switch-to-desktop-7", "Move Window and Switch to Desktop 7", "Meta+&", function() { moveAndSwitch(6); });
      registerShortcut("move-and-switch-to-desktop-8", "Move Window and Switch to Desktop 8", "Meta+*", function() { moveAndSwitch(7); });
      registerShortcut("move-and-switch-to-desktop-9", "Move Window and Switch to Desktop 9", "Meta+(", function() { moveAndSwitch(8); });
    '';

    programs.plasma = {
      enable = true;

      workspace = {
        colorScheme = "Dracula";
        theme = "Dracula";
        windowDecorations = {
          library = "org.kde.kwin.aurorae";
          theme = "__aurorae__svg__Dracula";
        };
        wallpaper = "${config.home.homeDirectory}/.config/wallpaper/nixos.png";
      };

      kwin.effects.shakeCursor.enable = false;

      configFile = {
        "kwinrc"."Desktops"."Number" = 1;
        "kwinrc"."Plugins" = {
          krohnkiteEnabled = true;
          dynamic_workspacesEnabled = true;
          "last-desktopEnabled" = true;
        };
        "kwinrc"."Script-krohnkite" = {
          screenGapTop = 8;
          screenGapBottom = 8;
          screenGapLeft = 8;
          screenGapRight = 8;
          screenGapBetween = 8;
        };
        # Active border: Dracula purple. Inactive: muted blue.
        # These apply to Breeze decorations via kdeglobals WM frame colors.
        "kdeglobals"."WM" = {
          frame = "189,147,249";
          inactiveFrame = "98,114,164";
        };
        # Show visible borders (not auto/theme-default which is often none).
        "kwinrc"."org.kde.kdecoration2" = {
          BorderSize = "Normal";
          BorderSizeAuto = false;
        };
      };

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

      shortcuts = {
        kwin = {
          "Switch to Desktop 1" = "Meta+1";
          "Switch to Desktop 2" = "Meta+2";
          "Switch to Desktop 3" = "Meta+3";
          "Switch to Desktop 4" = "Meta+4";
          "Switch to Desktop 5" = "Meta+5";
          "Switch to Desktop 6" = "Meta+6";
          "Switch to Desktop 7" = "Meta+7";
          "Switch to Desktop 8" = "Meta+8";
          "Switch to Desktop 9" = "Meta+9";
          # Unbound - replaced by script shortcuts that also switch to the desktop.
          "Window to Desktop 1" = [];
          "Window to Desktop 2" = [];
          "Window to Desktop 3" = [];
          "Window to Desktop 4" = [];
          "Window to Desktop 5" = [];
          "Window to Desktop 6" = [];
          "Window to Desktop 7" = [];
          "Window to Desktop 8" = [];
          "Window to Desktop 9" = [];
          "Window Close" = "Meta+Q";
          # Unbind to free Meta+T for terminal hotkey.
          "Edit Tiles" = [];
          # Unbind to free Meta+0 for last-desktop script shortcut.
          "view_actual_size" = [];
          # Explicitly set - KDE cached an empty binding overriding the script default.
          "switch-to-last-desktop" = "Meta+0";
          # Unbind to free Meta+Arrow for Krohnkite focus shortcuts.
          "Switch Window Left" = [];
          "Switch Window Right" = [];
          "Switch Window Up" = [];
          "Switch Window Down" = [];
          # Unbind to free Meta+Shift+Left/Right for Krohnkite move shortcuts.
          "Window to Next Screen" = [];
          "Window to Previous Screen" = [];
          # Replace HJKL with arrow keys for Krohnkite focus and window movement.
          "KrohnkiteFocusLeft" = "Meta+Left";
          "KrohnkiteFocusRight" = "Meta+Right";
          "KrohnkiteFocusUp" = "Meta+Up";
          "KrohnkiteFocusDown" = "Meta+Down";
          "KrohnkiteShiftLeft" = "Meta+Shift+Left";
          "KrohnkiteShiftRight" = "Meta+Shift+Right";
          "KrohnkiteShiftUp" = "Meta+Shift+Up";
          "KrohnkiteShiftDown" = "Meta+Shift+Down";
        };
        # Unbind Meta+B to free it for browser hotkey.
        org_kde_powerdevil = {
          "powerProfile" = [];
        };
        # Unbind Meta+1-9 (task manager) to free them for workspace switching,
        # Meta+0 (task manager entry 10) to free it for last-desktop,
        # and Meta+Q (manage activities) to free it for window close.
        plasmashell = {
          "activate task manager entry 1" = [];
          "activate task manager entry 2" = [];
          "activate task manager entry 3" = [];
          "activate task manager entry 4" = [];
          "activate task manager entry 5" = [];
          "activate task manager entry 6" = [];
          "activate task manager entry 7" = [];
          "activate task manager entry 8" = [];
          "activate task manager entry 9" = [];
          "activate task manager entry 10" = [];
          "manage activities" = [];
        };
      };

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
