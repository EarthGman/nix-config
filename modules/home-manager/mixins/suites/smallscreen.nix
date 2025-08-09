{ lib, config, ... }:
{
  options.gman.suites.smallscreen.enable =
    lib.mkEnableOption "suite for a screen with < 1920x1080 resolution";

  config = lib.mkIf config.gman.suites.smallscreen.enable {
    gman = {
      profiles.waybar.windows-11.config.small = true;
    };
  };
}
