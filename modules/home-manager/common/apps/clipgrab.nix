{ pkgs, config, lib, ... }:
{
  options.clipgrab.enable = lib.mkEnableOption "enable clipgrab";
  config = lib.mkIf config.clipgrab.enable {
    home.packages = with pkgs; [
      clipgrab
    ];
  };
}
