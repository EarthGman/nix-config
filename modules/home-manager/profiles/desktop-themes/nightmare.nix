{ wallpapers, lib, config, ... }:
let
  inherit (builtins) fetchurl;
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.desktopThemes.nightmare;
in
{
  options.profiles.desktopThemes.nightmare.enable = mkEnableOption "nightmare desktop theme";
  config = mkIf cfg.enable {
    custom.wallpaper = fetchurl wallpapers.the-pumpkin-patch;
    stylix.colorScheme = "ashes";

    programs.firefox.theme = {
      name = "shyfox";
      config.wallpaper = fetchurl wallpapers.the-nightmare-before-firefox;
    };
  };
}
