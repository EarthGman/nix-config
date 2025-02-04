{ pkgs, lib, config, ... }:
let
  enabled = { enable = lib.mkDefault true; };
  scripts = import ../../scripts { inherit pkgs lib config; };
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

    home.packages = with pkgs; [
      wl-clipboard
    ];

    services = {
      hyprpaper.enable =
        if (config.services.swww.enable)
        then
          (lib.mkForce false)
        else true;
      swww = enabled;
      polkit-gnome = enabled;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      xwayland.enable = true;
      settings = import ./settings.nix { inherit pkgs lib config scripts; };
    };
  };
}
