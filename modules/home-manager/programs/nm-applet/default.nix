{ config, lib, ... }:
{
  options.custom.nm-applet.enable = lib.mkEnableOption "emable nmapplet";
  config = lib.mkIf config.custom.nm-applet.enable {
    services.network-manager-applet.enable = true;
  };
}
