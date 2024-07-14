{ pkgs, ... }:
{
  imports = [
    ./fastfetch
    ./neofetch
    ./git
    # ./xremap
  ];

  home.packages = (with pkgs; [
    # some commands
    steam-run # running DLL applications, has nothing to do with steam
    appimage-run # for appimages
    wmctrl # ctrl options for wm
    unrar-free # for that guy who only uploads stuff in .rar format
    cifs-utils
    clinfo
    bat
    eza
    fzf
    duf
    glxinfo
    hstr
    nix-info
    ripgrep
    lshw
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
    mcrcon
    statix
    deadnix
    nixpkgs-hammering
    nixpkgs-fmt
    nix-init
    nix-update
    nixpkgs-review
    nurl
    tldr
    ifuse
    libimobiledevice
    usbmuxd
    xorg.xmodmap
  ]) ++ (with pkgs.gst_all_1; [
    # gstreamer, needed for some media playing applications to work on linux
    gst-libav
    gst-plugins-bad
    gst-plugins-base
    gst-plugins-good
    gst-plugins-ugly
    gst-vaapi
    gstreamer
  ]);
}
