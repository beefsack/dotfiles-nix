{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common
    ../../modules/nixos/thinkpad-x12-fn-swap.nix
  ];

  networking.hostName = "beefsack-laptop";

  services.power-profiles-daemon.enable = true;

  boot.initrd.luks.devices."luks-adddd589-b394-4e35-87d5-8fe65bbefc45" = {
    device = "/dev/disk/by-uuid/adddd589-b394-4e35-87d5-8fe65bbefc45";
    keyFile = "/mnt-root/root/.swapkey";
    keyFileSize = 4096;
  };

  system.stateVersion = "25.11";
}
