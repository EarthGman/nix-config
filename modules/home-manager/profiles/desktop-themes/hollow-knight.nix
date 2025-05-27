{ wallpapers, lib, config, ... }:
let
  inherit (builtins) fetchurl;
  inherit (lib) mkForce mkEnableOption mkIf;
  cfg = config.profiles.desktopThemes.hollow-knight;
in
{
  options.profiles.desktopThemes.hollow-knight.enable = mkEnableOption "hollow knight desktop theme";
  config = mkIf cfg.enable {
    custom.wallpaper = mkForce (fetchurl wallpapers.hallownest-bench);

    programs.firefox.theme = {
      name = "shyfox";
      config.wallpaper = fetchurl wallpapers.ghost-and-hornet;
    };
  };
}
