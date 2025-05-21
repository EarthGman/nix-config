{ wallpapers, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.profiles.desktopThemes.ashes;
in
{
  options.profiles.desktopThemes.ashes.enable = mkEnableOption "ashes desktop theme";
  config = mkIf cfg.enable {
    stylix.image = builtins.fetchurl wallpapers.scarlet-tree-dark;
    stylix.colorScheme = "ashes";
  };
}
