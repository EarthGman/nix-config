{ pkgs, pkgs-master, ... }:
{
  home.packages = with pkgs; [
    # apps
    gimp
    discord
    libreoffice
    prismlauncher #minecraft launcher
    obsidian
    steam
    musescore
    dolphin-emu-beta
    looking-glass-client
    github-desktop
    remmina
    #vinegar # bootstrapper for roblox
    flips # IPS and BPS file patcher

    # commands
    sysz
    ncdu
    jq
    dconf
    dconf2nix
    dua
    wl-screenrec
    steam-run
    appimage-run
    openssl
    usbutils
    pciutils
    wmctrl

    # Gstreamer
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-vaapi
    gst_all_1.gstreamer
  ];
}