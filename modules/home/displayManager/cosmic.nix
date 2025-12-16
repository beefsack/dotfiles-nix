{ config, lib, osConfig, ... }:

let
  cfg = osConfig.beefsack.displayManager.cosmic;
in {
  config = lib.mkIf cfg.enable {
    home.file.".config/cosmic/theme.ron" = {
      source = ../../../.config/cosmic/theme.ron;
      recursive = true;
    };
  };
}
