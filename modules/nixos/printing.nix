{ pkgs, ... }:

{
  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [ brscan4 brscan5 ];
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      gutenprintBin
      cups-brother-hll3230cdw
    ];
  };
}
