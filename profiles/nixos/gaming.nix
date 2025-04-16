{ pkgs, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  modules.steam.enable = true;
  programs = {
    dolphin-emu.enable = mkDefault true;
    # mouse control gui
    piper.enable = mkDefault true;
  };
}
