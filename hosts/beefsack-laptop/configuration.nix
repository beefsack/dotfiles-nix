{ plasma-auto-tiler, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common
    ../../modules/nixos/thinkpad-x12-fn-swap.nix
    plasma-auto-tiler.nixosModules.default
  ];

  networking.hostName = "beefsack-laptop";

  programs.plasma-auto-tiler.enable = true;

  services.power-profiles-daemon.enable = true;

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
  };
  services.btrfs.autoScrub.enable = true;

  system.stateVersion = "25.11";
}
