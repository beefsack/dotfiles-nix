{ config, lib, ... }:

let
  cfg = config.beefsack.displayManager.plasma6;
in {
  options.beefsack.displayManager.plasma6.enable = lib.mkEnableOption "KDE Plasma 6";

  config = lib.mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "Dracula";
    };
  };
}
