{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common
    ../../modules/nixos/thinkpad-x12-fn-swap.nix
  ];

  networking.hostName = "beefsack-laptop";

  services.power-profiles-daemon.enable = true;

  system.stateVersion = "25.11";
}
