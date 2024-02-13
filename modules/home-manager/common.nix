{ pkgs, pkgs-master, ... }:
{
  programs.obs-studio.enable = true;

  home.packages = with pkgs; [
    # apps
    gimp
    libreoffice
    obsidian
    musescore
    looking-glass-client
    github-desktop
    remmina
    gcolor3
    clipgrab
    openshot-qt
    museeks
    etcher # ISO/USB flasher
    mpv


    # commands
    steam-run
    appimage-run
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
