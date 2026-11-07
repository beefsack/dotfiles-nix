{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common
  ];

  networking.hostName = "beefsack-house";

  beefsack.nvidia.enable = true;
  beefsack.rgb.turnOffOnBoot = true;

  fileSystems = {
    "/mnt/windows-ssd" = {
      device = "/dev/disk/by-uuid/A672986472983ACF";
      fsType = "ntfs3";
      options = [
        "uid=1000"
        "gid=100"
        "umask=022"
        "windows_names"
        "nofail"
      ];
    };

    "/mnt/windows-ssd/Program Files (x86)/Steam/steamapps/compatdata" = {
      device = "/home/beefsack/.local/share/steam-native/ssd/compatdata";
      fsType = "none";
      options = [ "bind" "nofail" ];
    };

    "/mnt/windows-ssd/Program Files (x86)/Steam/steamapps/shadercache" = {
      device = "/home/beefsack/.local/share/steam-native/ssd/shadercache";
      fsType = "none";
      options = [ "bind" "nofail" ];
    };
  };

  system.stateVersion = "23.11";
}
