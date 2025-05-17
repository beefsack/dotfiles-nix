{ pkgs, ... }:

{
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # theme
    dracula-theme

    # archives
    p7zip
    unzip
    xz
    zip

    # networking tools
    dnsutils

    # misc
    discord
    file
    gawk
    gnupg
    gnused
    gnutar
    pv
    tree
    which
    zstd

    # monitoring
    lm_sensors
    sysstat

    # system call monitoring
    lsof
    ltrace
    strace

    # system tools
    ethtool
    pciutils
    usbutils

    # terminal
    kitty-themes

    # fonts
    liberation_ttf
    nerd-fonts.sauce-code-pro
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji

    # programming
    devenv
    gcc

    # productivity
    libreoffice-fresh

    # games
    sgt-puzzles

    # video
    ffmpeg
    # Video/Audio data composition framework tools like "gst-inspect", "gst-launch" ...
    gst_all_1.gstreamer
    # Common plugins like "filesrc" to combine within e.g. gst-launch
    gst_all_1.gst-plugins-base
    # Specialized plugins separated by quality
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    # Plugins to reuse ffmpeg to play almost every video format
    gst_all_1.gst-libav
    # Support the Video Audio (Hardware) Acceleration API
    gst_all_1.gst-vaapi
  ];

  programs.jq.enable = true;
  programs.ripgrep.enable = true;
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "dracula";
      theme_background = false;
    };
  };
  programs.neovim.enable = true;
  programs.chromium.enable = true;
  programs.firefox.enable = true;
  programs.direnv.enable = true;
}
