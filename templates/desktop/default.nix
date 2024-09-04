{ pkgs, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    excludePackages = with pkgs; [ xterm ];
  };
  xdg.portal = {
    enable = true;
    configPackages = [ pkgs.xdg-desktop-portal ];
    extraPortals = [ pkgs.xdg-desktop-portal ];
  };
  custom = {
    sound.enable = mkDefault true;
    printing.enable = mkDefault true;
    ifuse.enable = mkDefault true;
  };
  # if you have dolphin emu installed GC controllers will not have correct permissions unless set
  udev.packages = [ pkgs.dolphinEmu ];
}
