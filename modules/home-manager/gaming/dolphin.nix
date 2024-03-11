{ pkgs, ... }:
{
  # for GC controller support make sure to enable config.services.udev.packages = [ pkgs.dolphinEmu ]; somewhere in your nixos modules
  home.packages = with pkgs; [
    dolphin-emu-beta
  ];
}
