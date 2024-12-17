{ pkgs, lib, config, ... }:
let
  enabled = { enable = lib.mkDefault true; };
  scripts = import ../scripts { inherit pkgs lib config; };
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
      network-manager-applet = enabled;
    };

    programs = {
      rofi = enabled;
      waybar = enabled;
      hyprlock = enabled;
    };

    services = {
      hyprpaper.enable = lib.mkForce false; # this is getting enabled (IDK by what though)
      swww = enabled;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      xwayland.enable = true;
      settings = import ./settings.nix { inherit pkgs lib config scripts; };
    };
  };
}
