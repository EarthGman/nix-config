{ pkgs, lib, config, ... }:
let
  enabled = { enable = lib.mkDefault true; };
in
{
  services = {
    mako = enabled;
    hyprpaper = enabled;
    network-manager-applet = enabled;
  };

  programs = {
    waybar = enabled;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    settings = import ./settings.nix { inherit pkgs lib config; };
  };
}
