{ wallpapers, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.desktopThemes.inferno;
in
{
  options.profiles.desktopThemes.inferno.enable = mkEnableOption "inferno theme";
  config = mkIf cfg.enable {

    custom.wallpaper = builtins.fetchurl wallpapers.fiery-dragon;
    stylix = {
      colorScheme = "inferno";
    };

    programs = {
      firefox.theme.name = "shyfox";
      firefox.theme.config.wallpaper = builtins.fetchurl wallpapers.fire-and-flames;

      waybar.theme = "inferno";
    };
  };
}
