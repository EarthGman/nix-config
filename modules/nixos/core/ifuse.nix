{ pkgs, lib, config, ... }:
{
  options.modules.ifuse.enable = lib.mkEnableOption "enable usbmuxd using ifuse for iphones";
  config = lib.mkIf config.modules.ifuse.enable {
    services.usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
    environment.systemPackages = [
      pkgs.ifuse
    ];
  };
}
