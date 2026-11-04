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

    "/mnt/windows-hdd" = {
      device = "/dev/disk/by-uuid/608E0C228E0BEEFA";
      fsType = "ntfs3";
      options = [
        "uid=1000"
        "gid=100"
        "umask=022"
        "windows_names"
        "nofail"
      ];
    };

    "/mnt/windows-ssd" = {
      device = "/dev/disk/by-uuid/AA58AD9358AD5F37";
      fsType = "ntfs3";
      options = [
        "uid=1000"
        "gid=100"
        "umask=022"
        "windows_names"
        "nofail"
      ];
    };

    "/mnt/windows-hdd/SteamLibrary/steamapps/compatdata" = {
      device = "/home/beefsack/.local/share/steam-native/hdd/compatdata";
      fsType = "none";
      options = [ "bind" "nofail" ];
    };

    "/mnt/windows-hdd/SteamLibrary/steamapps/shadercache" = {
      device = "/home/beefsack/.local/share/steam-native/hdd/shadercache";
      fsType = "none";
      options = [ "bind" "nofail" ];
    };

    "/mnt/windows-ssd/SteamLibrary/steamapps/compatdata" = {
      device = "/home/beefsack/.local/share/steam-native/ssd/compatdata";
      fsType = "none";
      options = [ "bind" "nofail" ];
    };

    "/mnt/windows-ssd/SteamLibrary/steamapps/shadercache" = {
      device = "/home/beefsack/.local/share/steam-native/ssd/shadercache";
      fsType = "none";
      options = [ "bind" "nofail" ];
    };
  };
  services.btrfs.autoScrub.enable = true;

  system.stateVersion = "23.11";
}
