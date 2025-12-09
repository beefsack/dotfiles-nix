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

  system.stateVersion = "23.11";
}
