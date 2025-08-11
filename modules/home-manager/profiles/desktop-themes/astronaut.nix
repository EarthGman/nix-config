{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.profiles.desktopThemes.astronaut;
in
{
  options.gman.profiles.desktopThemes.astronaut.enable =
    lib.mkEnableOption "gman's space theme for sway hyprland and gnome";
  config = lib.mkIf cfg.enable {
    services.swww.enable = true;
    meta = {
      wallpaper = builtins.fetchurl pkgs.wallpapers.space-piano;
      profiles.stylix = lib.mkForce "ashes";
    };

    gman.profiles.firefox.shyfox.config.wallpaper = builtins.fetchurl pkgs.wallpapers.pixel-earth;

    services.swww.slideshow = {
      enable = lib.mkDefault true;
      interval = lib.mkDefault 300;
      #TODO ugly but will fix later
      images = [
        (builtins.fetchurl pkgs.wallpapers.space-piano)
        (builtins.fetchurl pkgs.wallpapers.space-jelly)
        (builtins.fetchurl pkgs.wallpapers.black-hole)
        (builtins.fetchurl pkgs.wallpapers.pixel-galaxy)
        (builtins.fetchurl pkgs.wallpapers.galaxy)
        (builtins.fetchurl pkgs.wallpapers.out-of-this-whirl)
        (builtins.fetchurl pkgs.wallpapers.nebula)
        (builtins.fetchurl pkgs.wallpapers.nebula-2)
        (builtins.fetchurl pkgs.wallpapers.blue-marble)
        (builtins.fetchurl pkgs.wallpapers.blue-marble-2)
        (builtins.fetchurl pkgs.wallpapers.pixel-earth)
      ];
    };
  };
}
