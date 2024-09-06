{ pkgs, config, lib, ... }:
{
  options.custom.dolphin-emu.enable = lib.mkEnableOption "enable dolphin-emu";
  config = lib.mkIf config.custom.dolphin-emu.enable {
    home.packages = with pkgs; [
      dolphin-emu-beta
    ];
  };
}

