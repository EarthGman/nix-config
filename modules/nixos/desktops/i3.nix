{ config, lib, ... }:
{
  options.custom.i3.enable = lib.mkEnableOption "enable i3 desktop";
  config = lib.mkIf config.custom.i3.enable {
    services.xserver.windowManager.i3 = {
      enable = true;
      extraSessionCommands = ''
        export QT_QPA_PLATFORM=xcb
        export QT_QPA_PLATFORMTHEME=${config.qt.platformTheme}
        export QT_AUTO_SCREEN_SCALE_FACTOR=1
      '';
    };
  };
}
