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
  services.btrfs.autoScrub.enable = true;

  system.stateVersion = "23.11";
}
