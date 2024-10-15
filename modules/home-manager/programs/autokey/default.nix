{ pkgs, lib, config, ... }:
{
  options.programs.autokey.enable = lib.mkEnableOption "enable autokey, a python script manager for pyautogui";
  config = lib.mkIf config.programs.autokey.enable {
    home.packages = [ pkgs.autokey ];
  };
}
