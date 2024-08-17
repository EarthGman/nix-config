{ pkgs, config, lib, ... }:
{
  options.polybar.enable = lib.mkEnableOption "enable polybar";
  config = lib.mkIf config.polybar.enable {
    home.packages = with pkgs; [
      polybar
    ];
    xdg.configFile = {
      "polybar/config.ini".source = ./config.ini;
    };
  };
}
