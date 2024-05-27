{ pkgs, config, lib, ... }:
{
  options.dolphin-emu.enable = lib.mkEnableOption "enable dolphin-emu";
  config = lib.mkIf config.dolphin-emu.enable {
    home.packages = with pkgs; [
      dolphin-emu-beta
    ];
  };
}

