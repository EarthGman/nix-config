{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal ];
  xdg.portal.configPackages = [ pkgs.xdg-desktop-portal ];
  services.xserver.xkb.layout = "us";
  services.xserver.excludePackages = with pkgs; [ xterm ];
}
