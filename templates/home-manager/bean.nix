{ lib, ... }:
let
  enabled = { enable = lib.mkDefault true; };
in
{
  programs.git = {
    userName = "ThunderBean290";
    userEmail = "156272091+Thunderbean290@users.noreply.github.com";
  };
  custom = {
    firefox = enabled;
    fastfetch = enabled;
    nautilus = enabled;
    openshot = enabled;
    audacity = enabled;
    libreoffice = enabled;
    gimp = enabled;
    gthumb = enabled;
    gcolor = enabled;
    evince = enabled;
    obsidian = enabled;
    obs = enabled;
    vlc = enabled;
    gnome-system-monitor = enabled;
    gnome-calculator = enabled;
  };
}
