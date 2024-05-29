{ pkgs, ... }:
{
  imports = [
    ./waybar.nix
  ];
  home.packages = with pkgs; [
    rofi-wayland
  ];
}
