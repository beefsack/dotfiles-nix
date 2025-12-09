{ config, ... }:

{
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
  };
}
