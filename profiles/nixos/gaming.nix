# extension of desktop.nix for gaming environments
{ pkgs, ... }:
{
  modules.steam.enable = true;
  # udev rules for dolphinbar and GC controller adapters
  services.udev.packages = [ pkgs.dolphin-emu ];
  # mouse control gui
  services.ratbagd.enable = true;
  environment.systemPackages = [ pkgs.piper ];
}