{ pkgs, lib, config, ... }:
{
  options.custom.ifuse.enable = lib.mkEnableOption "enable ifuse for iphones";
  config = lib.mkIf config.custom.ifuse.enable {
    services.usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
    environment.systemPackages = [
      pkgs.ifuse
    ];
  };
}
