{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) getExe;
in
{
  polybar = import ./polybar.nix { inherit pkgs getExe; };
  rofi-wallpaper-switcher = import ./rofi-wallpaper-switcher.nix { inherit pkgs config; };
  take-screenshot-wayland = import ./take-screenshot-wayland.nix { inherit pkgs getExe; };
  take-screenshot-xorg = import ./take-screenshot-xorg.nix { inherit pkgs getExe; };
  idle-daemon-event-handler = import ./idle-daemon-event-handler.nix { inherit pkgs; };
}
