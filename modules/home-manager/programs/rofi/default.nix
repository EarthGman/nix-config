{ pkgs, config, ... }:
{
  programs.rofi = {
    extraConfig = import ./config.nix;
    theme = import ./theme.nix { inherit config; };
    package = pkgs.rofi-wayland;
  };
}
