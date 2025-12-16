{ pkgs, lib, ... }:

{
  imports = [
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/rgb.nix
    ../../modules/nixos/displayManager/cosmic.nix
    ../../modules/nixos/displayManager/plasma6.nix
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    configurationLimit = 10;
  };

  # Temporarily using 6.17 until NVIDIA drivers support 6.18
  boot.kernelPackages = pkgs.linuxPackages_6_17;

  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Sydney";

  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  security.polkit.enable = true;

  hardware.cpu = {
    amd.updateMicrocode = true;
    intel.updateMicrocode = true;
  };

  services.libinput.enable = true;

  programs.fish.enable = true;
  users.users.beefsack = {
    isNormalUser = true;
    description = "Michael Alexander";
    extraGroups = [
      "docker"
      "networkmanager"
      "video"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "beefsack" ];
    auto-optimise-store = true;
  };

  environment.systemPackages = with pkgs; [
    dracula-theme
    firefox
    git
    neovim
    sbctl
    wirelesstools
  ];

  services.gvfs.enable = true;

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  programs.nix-ld.enable = true;

  programs.iftop.enable = true;
  programs.iotop.enable = true;

  services.flatpak.enable = true;
}
