{ config, lib, ... }:
{
  options.modules.bluetooth.enable = lib.mkEnableOption "enable bluetooth module";
  config = lib.mkIf config.modules.bluetooth.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
