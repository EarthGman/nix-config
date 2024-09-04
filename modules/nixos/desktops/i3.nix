{ config, lib, ... }:
{
  options.custom.i3.enable = lib.mkEnableOption "enable i3 desktop";
  config = lib.mkIf config.custom.i3.enable {
    services.xserver.windowManager.i3 = {
      enable = true;
    };
  };
}
