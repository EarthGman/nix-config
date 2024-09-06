{ pkgs, config, lib, ... }:
{
  options.custom.clipgrab.enable = lib.mkEnableOption "enable clipgrab";
  config = lib.mkIf config.custom.clipgrab.enable {
    home.packages = with pkgs; [
      clipgrab
    ];
  };
}
