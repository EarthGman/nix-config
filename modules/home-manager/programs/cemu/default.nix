{ pkgs, lib, config, ... }:
{
  options.programs.cemu.enable = lib.mkEnableOption "enable cemu";
  config = lib.mkIf config.programs.cemu.enable {
    home.packages = with pkgs; [
      cemu
    ];
  };
}
