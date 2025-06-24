{ lib, config, ... }@args:
let
  wallpapers = if args ? wallpapers then args.wallpapers else null;
  inherit (lib) mkIf mkEnableOption;
  cfg = config.profiles.desktopThemes.ashes;
in
{
  options.profiles.desktopThemes.ashes.enable = mkEnableOption "ashes desktop theme";
  config = mkIf cfg.enable {
    custom.wallpaper = builtins.fetchurl wallpapers.scarlet-tree-dark;
    stylix.colorScheme = "ashes";
  };
}
