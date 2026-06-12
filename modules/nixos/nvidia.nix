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
      extra-substituters = [ "https://cache.nixos-cuda.org" "https://nix-community.cachix.org" ];
      extra-trusted-public-keys = [
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
