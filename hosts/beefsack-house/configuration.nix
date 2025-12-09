{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common
  ];

  networking.hostName = "beefsack-house";

  beefsack.nvidia.enable = true;

  system.stateVersion = "23.11";
}
