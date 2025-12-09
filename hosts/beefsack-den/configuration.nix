{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common
  ];

  networking.hostName = "beefsack-den";

  beefsack.nvidia.enable = true;

  system.stateVersion = "23.11";
}
