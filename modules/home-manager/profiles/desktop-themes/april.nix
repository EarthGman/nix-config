{ wallpapers, icons, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.desktopThemes.april;
in
{
  options.profiles.desktopThemes.april.enable = mkEnableOption "enable april desktop theme";
  config = mkIf cfg.enable {
    custom.wallpaper = builtins.fetchurl wallpapers.kaori;
    stylix = {
      colorScheme = "april";
    };

    programs = {
      fastfetch.image = builtins.fetchurl icons.kaori;
      firefox.themes.shyfox.config.wallpaper = builtins.fetchurl wallpapers.april-night;

      waybar.theme = "april";
    };
  };
}
