{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common
  ];

  networking.hostName = "beefsack-den";

  beefsack.nvidia.enable = true;
  beefsack.rgb.turnOffOnBoot = true;

  fileSystems = {
    "/".options = [ "compress=zstd" ];
  };

  system.stateVersion = "23.11";
}
