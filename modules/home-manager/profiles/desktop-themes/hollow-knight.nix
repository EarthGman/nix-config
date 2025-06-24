{ lib, config, ... }@args:
let
  wallpapers = if args ? wallpapers then args.wallpapers else null;
  inherit (builtins) fetchurl;
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.desktopThemes.hollow-knight;
in
{
  options.profiles.desktopThemes.hollow-knight.enable = mkEnableOption "hollow knight desktop theme";
  config = mkIf cfg.enable {
    custom.wallpaper = (fetchurl wallpapers.hallownest-bench);

    programs.firefox.themes.shyfox.config.wallpaper = fetchurl wallpapers.ghost-and-hornet;
  };
}
