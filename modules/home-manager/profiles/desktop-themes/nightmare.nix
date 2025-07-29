{ lib, config, ... }@args:
let
  wallpapers = if args ? wallpapers then args.wallpapers else null;

  inherit (builtins) fetchurl;
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.desktopThemes.nightmare;
in
{
  options.profiles.desktopThemes.nightmare.enable =
    mkEnableOption "the nightmare before christmas desktop theme";
  config = mkIf cfg.enable {
    custom.wallpaper = fetchurl wallpapers.the-pumpkin-patch;

    profiles = {
      stylix.default.colorScheme = "ashes";
      firefox.shyfox.config.wallpaper = fetchurl wallpapers.nightmare-before-christmas-1;
    };
  };
}
