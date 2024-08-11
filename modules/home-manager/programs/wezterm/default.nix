{ pkgs, config, lib, ... }:
{
  options.wezterm.enable = lib.mkEnableOption "wezterm";
  config = lib.mkIf config.wezterm.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./settings.lua;
    };
  };
}
