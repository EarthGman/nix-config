{ pkgs, config, lib, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./settings.lua;
  };
}
