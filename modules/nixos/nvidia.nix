{ config, lib, pkgs, ... }:
let
  cfg = config.beefsack.nvidia;
in {
  options.beefsack.nvidia.enable = lib.mkEnableOption "NVIDIA GPU support";

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia-container-toolkit.enable = true;

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
    };

    boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

    services.ollama.package = pkgs.ollama-cuda;

    nix.settings = {
      substituters = [ "https://cuda-maintainers.cachix.org" ];
      trusted-public-keys = [ "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E=" ];
    };
  };
}
