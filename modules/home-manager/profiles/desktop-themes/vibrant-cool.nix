{ wallpapers, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.desktopThemes.vibrant-cool;
in
{
  options.profiles.desktopThemes.vibrant-cool.enable = mkEnableOption "vbrant-cool ROR inspired desktop theme";
  config = mkIf cfg.enable {
    stylix.image = builtins.fetchurl wallpapers.survivors;
    stylix.colorScheme = "vibrant-cool";

    programs = {
      firefox.theme.name = "shyfox";
      firefox.theme.config.wallpaper = builtins.fetchurl wallpapers.get-mooned;
    };
  };
}
