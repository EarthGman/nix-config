{ pkgs, ... }:
# add devices/controllers to config
let
  dolphin-bar = ''SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0306", MODE="0666"'';
  gamecube-adaptor = ''SUBSYSTEM=="usb", ATTRS{idVendor}=="0079", ATTRS{idProduct}=="1846", MODE="0666"'';
in
{
  services.udev.packages = [ pkgs.dolphinEmu ];
  services.udev.extraRules = dolphin-bar + "\n" + gamecube-adaptor;
}
