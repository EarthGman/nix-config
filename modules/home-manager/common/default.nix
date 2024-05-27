{ pkgs, ... }:
{
  imports = [
    ./neofetch
    ./wine
    ./git
    ./discord
    ./audacity.nix
    ./checkra1n.nix
    ./clipgrab.nix
    ./filezilla.nix
    ./flips.nix
    ./flips.nix
    ./gcolor.nix
    ./gimp.nix
    ./gpg.nix
    ./htop.nix
    ./libreoffice.nix
    ./looking-glass.nix
    ./museeks.nix
    ./musescore.nix
    ./nvtop.nix
    ./obs.nix
    ./obsidian.nix
    ./openshot.nix
    ./pika-backup.nix
    ./powertop.nix
    ./radeontop.nix
    ./remmina.nix
  ];

  home.packages = (with pkgs; [
    # some commands
    steam-run # running DLL applications, has nothing to do with steam
    appimage-run # for appimages
    wmctrl # ctrl options for wm
    unrar-free # for that guy who only uploads stuff in .rar format
    bat
    eza
    fzf
    hstr
    nix-info
    ripgrep
    sysz
    lshw
    tree
    nix-prefetch-git
    ncdu
    jq
    yq-go
    dua
    openssl
    usbutils
    pciutils
    tldr
    ifuse
    libimobiledevice
    usbmuxd
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
