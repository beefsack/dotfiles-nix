{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    cargo-sweep
    cargo-cache
  ];

  home.sessionVariables = {
    CARGO_BUILD_BUILD_DIR = "${config.xdg.cacheHome}/cargo/build";
  };
}
