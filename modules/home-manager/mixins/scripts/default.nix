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
  options.gman.scripts = lib.mkOption {
    description = "gman's customized script bank for home-manager";
    type = lib.types.attrsOf lib.types.package;
    default = {
      rofi-wallpaper-switcher = import ./rofi-wallpaper-switcher.nix { inherit pkgs config; };
      take-screenshot-wayland = import ./take-screenshot-wayland.nix { inherit pkgs getExe; };
      idle-daemon-event-handler = import ./idle-daemon-event-handler.nix { inherit pkgs; };
    };
  };
}
