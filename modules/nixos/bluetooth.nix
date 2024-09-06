{ config, lib, ... }:
{
  options.custom.bluetooth.enable = lib.mkEnableOption "enable bluetooth module";
  config = lib.mkIf config.custom.bluetooth.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
