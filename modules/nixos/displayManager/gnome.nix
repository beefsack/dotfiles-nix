{ config, lib, pkgs, ... }:

let
  cfg = config.beefsack.displayManager.gnome;
in {
  options.beefsack.displayManager.gnome.enable = lib.mkEnableOption "GNOME";

  config = lib.mkIf cfg.enable {
    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;
    environment.systemPackages = [
      pkgs.gnomeExtensions.appindicator
      pkgs.gnome-tweaks
    ];
  };
}
