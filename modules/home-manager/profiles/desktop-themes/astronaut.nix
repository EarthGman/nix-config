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
      wallpaper = pkgs.images.space-piano;
      profiles.stylix = lib.mkForce "ashes";
    };

    gman.profiles.firefox.shyfox.config.wallpaper = pkgs.images.pixel-earth;

    services.swww.slideshow = {
      enable = lib.mkDefault true;
      interval = lib.mkDefault 300;
      images = [
        (pkgs.images.space-piano)
        (pkgs.images.space-jelly)
        (pkgs.images.black-hole)
        (pkgs.images.pixel-galaxy)
        (pkgs.images.galaxy)
        (pkgs.images.out-of-this-whirl)
        (pkgs.images.nebula)
        (pkgs.images.nebula-2)
        (pkgs.images.blue-marble)
        (pkgs.images.blue-marble-2)
        (pkgs.images.pixel-earth)
      ];
    };
  };
}
