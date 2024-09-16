{ pkgs, config, lib, ... }:
{
  options.programs.clipgrab.enable = lib.mkEnableOption "enable clipgrab";
  config = lib.mkIf config.programs.clipgrab.enable {
    home.packages = with pkgs; [
      clipgrab
    ];
  };
}
