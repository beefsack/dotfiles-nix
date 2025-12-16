{ ... }:

{
  programs.fish.enable = true;

  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "SauceCodePro NFM Medium";
      font-size = 13;
      window-decoration = false;
      palette = [
        "0=#21222c"
        "1=#ff5555"
        "2=#50fa7b"
        "3=#f1fa8c"
        "4=#bd93f9"
        "5=#ff79c6"
        "6=#8be9fd"
        "7=#f8f8f2"
        "8=#6272a4"
        "9=#ff6e6e"
        "10=#69ff94"
        "11=#ffffa5"
        "12=#d6acff"
        "13=#ff92df"
        "14=#a4ffff"
        "15=#ffffff"
      ];
      background = "#282a36";
      foreground = "#f8f8f2";
      cursor-color = "#f8f8f2";
      cursor-text = "#282a36";
      selection-foreground = "#f8f8f2";
      selection-background = "#44475a";
    };
  };

  programs.starship.enable = true;
  home.file.".config/fish/conf.d/greeting.fish".source = ../../.config/fish/conf.d/greeting.fish;
  home.file.".config/fish/conf.d/starship.fish".source = ../../.config/fish/conf.d/starship.fish;
  home.file.".config/fish/conf.d/direnv.fish".source = ../../.config/fish/conf.d/direnv.fish;
}
