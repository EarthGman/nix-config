{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.modules.iphone;
in
{
  options.modules.iphone.enable = lib.mkEnableOption "usbmuxd with ifuse for iphones";
  config = mkIf cfg.enable {
    services.usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
    environment.systemPackages = [
      pkgs.ifuse
    ];
  };
}
