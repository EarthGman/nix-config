{ pkgs, ... }:
{
  # required for gamecube controller permission error in dolphin
  services.udev.packages = [ pkgs.dolphinEmu ];
}
