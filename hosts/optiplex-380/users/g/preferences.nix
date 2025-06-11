{ wallpapers, lib, ... }:
let
  inherit (lib) mkForce;
  inherit (builtins) fetchurl;
in
{
  profiles.essentials.enable = false;
  custom.wallpaper = mkForce (fetchurl wallpapers.windows-11);
  custom.terminal = "alacritty";

  services.swww.slideshow.enable = false;

  programs = {
    museeks.enable = false;
    ghex.enable = false;
    discord.enable = false;
    obs-studio.enable = false;
  };
}
