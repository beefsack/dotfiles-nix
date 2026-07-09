{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common
  ];

  networking.hostName = "beefsack-usb";

  systemd.services.systemd-journald.serviceConfig = {
    Storage = "volatile";
    RuntimeMaxUse = "30M";
  };

  fileSystems = {
    "/".options = [ "compress=zstd" ];
  };
  services.btrfs.autoScrub.enable = true;

  system.stateVersion = "23.11";
}
