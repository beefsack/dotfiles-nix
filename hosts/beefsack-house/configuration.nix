{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common
  ];

  networking.hostName = "beefsack-house";

  beefsack.nvidia.enable = true;
  beefsack.rgb.turnOffOnBoot = true;

  system.stateVersion = "23.11";
}
