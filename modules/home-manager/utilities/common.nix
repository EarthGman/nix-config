{ pkgs, ... }:
{
  # apps shared among machines
  programs = {
    obs-studio = {
      enable = true;
    };
  };
  home.packages = (with pkgs; [
    # productivity
    vim # you know
    gimp # image editor
    libreoffice
    obsidian # note taking
    discord
    betterdiscordctl
    betterdiscord-installer
    remmina # remote desktop client
    gcolor3 # color picker
    clipgrab # video / mp3 downloader
    openshot-qt # video editor
    audacity # audio editor
    museeks # music app
    flips # IPS and BPS file patcher
    filezilla # FTP client
    pika-backup # simple backups based on borg

    # commands
    steam-run # running DLL applications, not related to steam at all
    appimage-run # appimages
    wmctrl # some ctrl options for window managers

  ]) ++ (with pkgs.gst_all_1; [
    # Gstreamer needed for playing videos through media players
    gst-libav
    gst-plugins-bad
    gst-plugins-base
    gst-plugins-good
    gst-plugins-ugly
    gst-vaapi
    gstreamer
  ]);
}
