{ ... }:

{
  imports = [
    ../../modules/home/packages.nix
    ../../modules/home/git.nix
    ../../modules/home/terminal.nix
    ../../modules/home/vscode.nix
    ../../modules/home/zed-editor.nix
    ../../modules/home/plasma.nix
  ];

  home.username = "beefsack";
  home.homeDirectory = "/home/beefsack";

  home.sessionVariables = {
    EDITOR = "nvim";
    GTK_THEME = "Dracula:dark";
    NIXOS_OZONE_WL = 1;
  };

  home.file.".config/wallpaper/nixos.png" = {
    source = ../../.config/wallpaper/nixos.png;
    recursive = true;
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
