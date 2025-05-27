{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.desktops.hyprland.default;
  enabled = { enable = lib.mkDefault true; };
  scripts = import ../../../scripts { inherit pkgs lib config; };
in
{
  options.profiles.desktops.hyprland.default.enable = mkEnableOption "default hyprland config";
  config = mkIf cfg.enable {
    stylix.targets.hyprland.enable = true;

    programs = mkIf config.wayland.windowManager.hyprland.enable {
      rofi = enabled;
      waybar = enabled;
      hyprlock = enabled;
    };

    services = mkIf config.wayland.windowManager.hyprland.enable {
      hyprpaper.enable =
        if (config.services.swww.enable)
        then
          (lib.mkForce false)
        else true;
      swww = enabled;
      polkit-gnome = enabled;
      dunst = enabled;
      network-manager-applet = enabled;
    };

    wayland.windowManager.hyprland = {
      systemd.enable = false;
      xwayland.enable = true;
      settings = import ./settings.nix { inherit pkgs lib config scripts; };
    };
  };
}
