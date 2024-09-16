{ pkgs, config, lib, ... }:
{
  options.programs.dolphin-emu.enable = lib.mkEnableOption "enable dolphin-emu";
  config = lib.mkIf config.programs.dolphin-emu.enable {
    home.packages = with pkgs; [
      dolphin-emu-beta
    ];
  };
}

