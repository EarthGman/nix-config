{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.iphone;
in
{
  options.gman.iphone.enable = lib.mkEnableOption "tools for mounting iphones on linux";
  config = lib.mkIf cfg.enable {
    services.usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
    environment.systemPackages = [
      pkgs.ifuse
    ];
  };
}
