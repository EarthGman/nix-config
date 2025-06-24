{ lib, config, ... }@args:
let
  wallpapers = if args ? wallpapers then args.wallpapers else null;

  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.desktopThemes.vibrant-cool;
in
{
  options.profiles.desktopThemes.vibrant-cool.enable = mkEnableOption "vbrant-cool ROR inspired desktop theme";
  config = mkIf cfg.enable {
    custom.wallpaper = builtins.fetchurl wallpapers.survivors;
    stylix.colorScheme = "vibrant-cool";

    programs = {
      firefox.themes.shyfox.config.wallpaper = builtins.fetchurl wallpapers.get-mooned;
    };
  };
}
