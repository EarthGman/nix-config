{ pkgs, lib, config, ... }:
{
  programs.rofi = {
    extraConfig = import ./config.nix { inherit lib config; };
    theme = import ./theme.nix { inherit config; };
    package = pkgs.rofi-wayland;
  };
}
