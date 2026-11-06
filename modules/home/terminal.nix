{ ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = "set fish_greeting";
  };

  programs.devenv = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship.enable = true;

  programs.kitty = {
    enable = true;
    themeFile = "Dracula";
    font = {
      name = "SauceCodePro Nerd Font Mono";
      size = 13;
    };
    settings = {
      hide_window_decorations = "yes";
      selection_foreground = "#f8f8f2";
    };
  };

}
