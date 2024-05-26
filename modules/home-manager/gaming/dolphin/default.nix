{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    dolphin-emu-beta
  ];
}
