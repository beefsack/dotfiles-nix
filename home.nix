{ ... }:

{
  imports = [
    ./modules/packages.nix
    ./modules/git.nix
    ./modules/terminal.nix
    ./modules/vscode.nix
  ];

  home.username = "beefsack";
  home.homeDirectory = "/home/beefsack";

  home.sessionVariables = {
    EDITOR = "nvim";
    GTK_THEME = "Dracula:dark";
    NIXOS_OZONE_WL = 1;
  };

  home.file.".config/wallpaper/nixos.png" = {
    source = .config/wallpaper/nixos.png;
    recursive = true;
  };
  home.file.".config/cosmic/theme.ron" = {
    source = .config/cosmic/theme.ron;
    recursive = true;
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
