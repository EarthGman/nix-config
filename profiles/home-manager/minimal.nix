{ lib, ... }:
# minimal functional work desktop setup
let
  enabled = { enable = lib.mkDefault true; };
in
{
  programs = {
    # less bloated than firefox
    brave = enabled;
    fastfetch = enabled;
    nautilus = enabled;
    openshot = enabled;
    audacity = enabled;
    libreoffice = enabled;
    gimp = enabled;
    gthumb = enabled;
    evince = enabled;
    obsidian = enabled;
    vlc = enabled;
    gnome-system-monitor = enabled;
    gnome-calculator = enabled;
    thunderbird = enabled;
  };
}
