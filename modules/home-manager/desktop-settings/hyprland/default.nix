{ pkgs, lib, config, ... }:
let
  enabled = { enable = lib.mkDefault true; };
  scripts = import ./scripts.nix { inherit pkgs lib config; };
in
{
  options = {
    wayland.windowManager.hyprland.mainMod = lib.mkOption {
      description = "main mod for the hyprland tiling window manager";
      type = lib.types.str;
      default = "SUPER";
    };
  };
  config = {
    services = {
      dunst = enabled;
      hyprpaper = enabled;
      network-manager-applet = enabled;
    };

    programs = {
      rofi = enabled;
      waybar = enabled;
      hyprlock = enabled;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
      settings = import ./settings.nix { inherit pkgs lib config scripts; };
    };
  };
}
