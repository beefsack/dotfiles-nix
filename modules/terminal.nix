{ ... }:

{
  # terminal
  programs.fish.enable = true;
  programs.kitty = {
    enable = true;
    themeFile = "Dracula";
    font = {
      name = "SauceCodePro Nerd Font Mono";
      size = 13;
    };
    settings = {
      hide_window_decorations = "yes";
    };
  };
  programs.starship.enable = true;
  home.file.".config/fish/conf.d/greeting.fish".source = ../.config/fish/conf.d/greeting.fish;
  home.file.".config/fish/conf.d/starship.fish".source = ../.config/fish/conf.d/starship.fish;
  home.file.".config/fish/conf.d/direnv.fish".source = ../.config/fish/conf.d/direnv.fish;
}
