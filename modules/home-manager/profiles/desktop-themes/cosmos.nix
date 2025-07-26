{ lib, config, ... }@args:
let
  wallpapers = if args ? wallpapers then args.wallpapers else null;

  inherit (builtins) fetchurl;
  inherit (lib) mkDefault mkEnableOption mkIf;
  cfg = config.profiles.desktopThemes.cosmos;
in
{
  options.profiles.desktopThemes.cosmos.enable = mkEnableOption "cosmos desktop theme";
  config = mkIf cfg.enable {
    programs = {
      firefox.themes.shyfox.config.wallpaper = fetchurl wallpapers.pixel-earth;
    };

    custom.wallpaper = fetchurl wallpapers.space-piano;
    stylix = {
      colorScheme = "ashes";
    };

    services.swww.slideshow = {
      enable = mkDefault true;
      interval = mkDefault 300;
      images = mkDefault (
        with wallpapers;
        [
          (fetchurl black-hole)
          (fetchurl pixel-galaxy)
          (fetchurl space-piano)
          (fetchurl space-jelly)
          (fetchurl galaxy)
          (fetchurl out-of-this-whirl)
          (fetchurl nebula)
          (fetchurl nebula-2)
          (fetchurl blue-marble)
          (fetchurl blue-marble-2)
          (fetchurl blue-marble-3)
        ]
      );
    };
  };
}
