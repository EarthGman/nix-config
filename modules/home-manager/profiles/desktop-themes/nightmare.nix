{ lib, config, ... }@args:
let
  wallpapers = if args ? wallpapers then args.wallpapers else null;

  inherit (builtins) fetchurl;
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.desktopThemes.nightmare;
in
{
  options.profiles.desktopThemes.nightmare.enable = mkEnableOption "nightmare desktop theme";
  config = mkIf cfg.enable {
    custom.wallpaper = fetchurl wallpapers.the-pumpkin-patch;
    stylix.colorScheme = "ashes";

    programs.firefox.themes.shyfox.config.walls.shyfoxpaper =
      fetchurl wallpapers.the-nightmare-before-firefox;
  };
}
