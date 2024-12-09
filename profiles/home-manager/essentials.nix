{ lib, ... }:
# many essential programs for a desktop setup.
let
  enabled = { enable = lib.mkDefault true; };
in
{
  # browser, file manager, and terminal are enabled using the custom attribute set
  # by default these enable: firefox, nautilus, and kitty
  programs = {
    pwvucontrol = enabled; # volume control
    fastfetch = enabled; # you know
    lazygit = enabled; # git tool
    clipgrab = enabled; # video downloader
    audacity = enabled; # audio editor
    libreoffice = enabled; # free version of office
    gimp = enabled; # image editor
    gthumb = enabled; # image viewer
    evince = enabled; # pdf viewer
    vlc = enabled; # video player
    gnome-system-monitor = enabled; # cool task manager
    gnome-calculator = enabled; # calculator
    thunderbird = enabled; # email client
    switcheroo = enabled; # super easy image format conversion
    video-trimmer = enabled; # easy way to edit and trim videos
    obsidian = enabled; # note taking
    fzf = enabled; # shell fuzzy finder
  };
}
