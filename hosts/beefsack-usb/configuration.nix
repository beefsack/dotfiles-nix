{ config, lib, pkgs, ... }:

{
  networking.hostName = "beefsack-usb"; # Define your hostname.

  # Use volatile storage for journald to reduce disk access
  environment.etc = {
    "systemd/journald.conf.d/99-storage.conf".text = ''
      [Journal]
      Storage=volatile
    '';
  };
}
