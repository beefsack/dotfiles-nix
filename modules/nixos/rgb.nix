# RGB control using OpenRGB
# Based on the canonical approach from: https://wiki.nixos.org/wiki/OpenRGB

{ pkgs, lib, config, ... }:

let
  cfg = config.beefsack.rgb;

  no-rgb = pkgs.writeScriptBin "no-rgb" ''
    #!/bin/sh
    NUM_DEVICES=$(${pkgs.openrgb}/bin/openrgb --noautoconnect --list-devices | grep -E '^[0-9]+: ' | wc -l)
    for i in $(seq 0 $(($NUM_DEVICES - 1))); do
      ${pkgs.openrgb}/bin/openrgb --noautoconnect --device $i --mode static --color 000000
    done
  '';
in {
  options.beefsack.rgb = {
    turnOffOnBoot = lib.mkEnableOption "automatically turn off all RGB lighting on boot";
  };

  config = lib.mkIf cfg.turnOffOnBoot {
    # Required for RGB control via SMBus/i2c
    hardware.i2c.enable = true;
    boot.kernelModules = [ "i2c-dev" ];

    # Install udev rules for OpenRGB device access
    services.udev.packages = [ pkgs.openrgb ];

    # Systemd service to turn off RGB on boot
    systemd.services.no-rgb = {
      description = "Turn off all RGB lighting";
      serviceConfig = {
        ExecStart = "${no-rgb}/bin/no-rgb";
        Type = "oneshot";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
