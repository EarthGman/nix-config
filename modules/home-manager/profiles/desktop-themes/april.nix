{ lib, config, ... }@args:
let
  wallpapers = if args ? wallpapers then args.wallpapers else null;
  icons = if args ? icons then args.icons else null;

  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.desktopThemes.april;
in
{
  options.profiles.desktopThemes.april.enable = mkEnableOption "enable april desktop theme";
  config = mkIf cfg.enable {
    custom.wallpaper = builtins.fetchurl wallpapers.kaori-1;

    profiles = {
      stylix.default.colorScheme = "april";
      firefox.shyfox.config.wallpaper = builtins.fetchurl wallpapers.april-night;
    };

    programs = {
      fastfetch.image = builtins.fetchurl icons.kaori;
    };
  };
}
