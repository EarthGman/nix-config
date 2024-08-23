{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # some commands
    steam-run # running DLL applications, has nothing to do with steam
    appimage-run # for appimages
    bustle # dbus viewer
    wmctrl # ctrl options for wm
    unrar-free # for that guy who only uploads stuff in .rar format
    cifs-utils # network filesystems
    clinfo
    cava # audio visualizer
    bat # better cat
    eza # better exa icons
    fzf
    fd
    duf
    glxinfo
    hstr
    psmisc
    nix-info
    ripgrep
    lshw
    htop
    sysz
    tree
    inxi
    nix-prefetch-git
    ncdu
    jq
    yq-go
    dua
    openssl
    usbutils
    pciutils
    lm_sensors
    mcrcon
    statix
    deadnix
    nil
    nixpkgs-hammering
    nixpkgs-fmt
    nix-init
    nix-update
    nixpkgs-review
    nurl
    tldr
    ifuse
    libimobiledevice
    imagemagick
    viu
    usbmuxd
    xclip
    xorg.xev
    xorg.xmodmap
  ];
}
