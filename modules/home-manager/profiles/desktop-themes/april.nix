{ wallpapers, icons, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.desktopThemes.april;
in
{
  options.profiles.desktopThemes.april.enable = mkEnableOption "enable april desktop theme";
  config = mkIf cfg.enable {
    stylix = {
      image = builtins.fetchurl wallpapers.kaori;
      colorScheme = "april";
    };

    programs = {
      fastfetch.image = builtins.fetchurl icons.kaori;
      firefox.theme.name = "shyfox";
      firefox.theme.config.wallpaper = builtins.fetchurl wallpapers.april-night;

      waybar.theme = "april";
    };
  };
}
