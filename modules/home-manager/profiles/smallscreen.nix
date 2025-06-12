# profile for PCs with smaller screens than 1920x1080
{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf mkOverride;
  cfg = config.profiles.smallscreen;
in
{
  options.profiles.smallscreen.enable = mkEnableOption "small screen profile for HM";
  config = mkIf cfg.enable {
    stylix.fonts.sizes = {
      terminal = (mkOverride 800) 12;
      applications = (mkOverride 800) 10;
      popups = (mkOverride 800 8);
      desktop = (mkOverride 800 12);
    };

    custom.profiles.waybar = "smallscreen";
  };
}
