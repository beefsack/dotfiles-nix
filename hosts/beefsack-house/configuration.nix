{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common
  ];

  networking.hostName = "beefsack-house";

  beefsack.nvidia.enable = true;
  beefsack.rgb.turnOffOnBoot = true;

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  system.stateVersion = "23.11";
}
