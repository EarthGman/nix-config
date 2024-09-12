{ pkgs, lib, config, ... }:
{
  custom = {
    mako.enable = true;
    hyprpaper.enable = true;
    waybar.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    settings = import ./settings.nix { inherit pkgs lib config; };
  };
}
