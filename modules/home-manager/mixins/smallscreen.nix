{ lib, config, ... }:
{
  options.gman.smallscreen.enable = lib.mkEnableOption "mixin for a screen with < 1920x1080 resolution";

  config = lib.mkIf config.gman.smallscreen.enable {
    stylix.fonts = {
      sizes = {
        applications = lib.mkOverride 799 10;
        desktop = lib.mkOverride 799 12;
        popups = lib.mkOverride 799 10;
        terminal = lib.mkOverride 799 12;
      };
    };
  };
}
