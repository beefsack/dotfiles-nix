{ config, lib, ... }:

let
  cfg = config.beefsack.displayManager.cosmic;
in {
  options.beefsack.displayManager.cosmic.enable = lib.mkEnableOption "Cosmic Desktop" // {
    default = true;
  };

  config = lib.mkIf cfg.enable {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
  };
}
