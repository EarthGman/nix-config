{ outputs, wallpapers, lib, ... }:
let
  theme = outputs.homeProfiles.desktopThemes.cosmos;
in
{
  imports = [
    theme
  ];

  stylix.image = lib.mkForce (builtins.fetchurl wallpapers.pik);
  programs = {
    discord.enable = true;
    audacity.enable = false;
    libreoffice.enable = false;
    gimp.enable = false;
    thunderbird.enable = false;
    video-trimmer.enable = false;
    switcheroo.enable = false;
    obsidian.enable = false;
    simple-scan.enable = false;
    clipgrab.enable = false;
  };
}
