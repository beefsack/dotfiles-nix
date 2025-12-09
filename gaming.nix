{ pkgs, ... }:

{
  # 32-bit graphics for Steam/Wine
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Xbox controller USB dongle support
  hardware.xone.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  # BPF scheduler for gaming workloads
  services.scx = {
    enable = true;
    scheduler = "scx_rusty";
  };

  # Process priority for gaming and active windows
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 10;
      };
    };
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 10; # Keep game data in RAM
    "vm.vfs_cache_pressure" = 50; # Favor application memory
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
}
