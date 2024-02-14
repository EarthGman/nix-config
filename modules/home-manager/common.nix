{ pkgs, pkgs-master, ... }:
{
  programs.obs-studio.enable = true;

  home.packages = with pkgs; [
    # productivity
    gimp # image editor
    libreoffice
    obsidian # note taking
    musescore # music composition
    github-desktop
    remmina # remote desktop client
    gcolor3 # color picker
    clipgrab # video / mp3 downloader
    openshot-qt # video editor
    museeks # music app
    etcher # ISO/USB flasher
    flips # IPS and BPS file patcher

    # gaming
    discord
    betterdiscordctl
    betterdiscord-installer
    prismlauncher # minecraft
    dolphin-emu-beta # wii anc GC emulator
    steam # game library

    # commands
    steam-run # running binaries that use linked libraries
    appimage-run # for appimages
    wmctrl # utils for window manager

    # Gstreamer
    # used for playing videos via media player
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-vaapi
    gst_all_1.gstreamer
  ];
}
