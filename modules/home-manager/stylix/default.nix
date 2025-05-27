{ pkgs, config, lib, ... }:
let
  inherit (lib) mkOption types mkDefault mkIf;
  cfg = config.stylix;
in
{
  options = {
    stylix.colorScheme = mkOption {
      description = ''
        name of the .yaml file under ./color-palettes (excluding .yaml)
        used to convert a simple string into a path for easier config management
      '';
      type = types.str;
      default = "ashes";
    };
  };
  config.stylix = {
    # only allow stylix to manage what I tell it to
    autoEnable = mkDefault false;
    image = mkDefault config.custom.wallpaper;
    base16Scheme = mkIf (cfg.colorScheme != "") (./color-palettes + "/${cfg.colorScheme}.yaml");
  };
}
