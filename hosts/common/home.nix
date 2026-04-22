{ osConfig, ... }:

{
  imports = [
    ../../modules/home/packages.nix
    ../../modules/home/npm.nix
    ../../modules/home/git.nix
    ../../modules/home/terminal.nix
    ../../modules/home/vscode.nix
    ../../modules/home/ai.nix
    ../../modules/home/displayManager/cosmic.nix
    ../../modules/home/displayManager/gnome.nix
    ../../modules/home/displayManager/plasma6.nix
  ];

  home.username = "beefsack";
  home.homeDirectory = "/home/beefsack";

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = 1;
    RUST_MIN_STACK = 134217728;
  };

  home.file.".config/wallpaper/nixos.png" = {
    source = ../../.config/wallpaper/nixos.png;
    recursive = true;
  };

  home.stateVersion = osConfig.system.stateVersion;

  programs.home-manager.enable = true;
}
