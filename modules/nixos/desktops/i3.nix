{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.desktops.i3;
in
{
  options.modules.desktops.i3.enable = lib.mkEnableOption "enable i3 desktop";
  config = lib.mkIf cfg.enable {
    xdg.portal.configPackages = [ pkgs.xdg-desktop-portal ];
    services = {
      xserver.windowManager.i3 = {
        enable = true;
      };
    };
    environment.systemPackages = with pkgs; [
      # x specific tools
      xorg.xmodmap
      xclip
    ];
  };
}
