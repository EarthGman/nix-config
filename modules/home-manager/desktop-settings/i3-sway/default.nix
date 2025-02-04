{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault;
  enabled = { enable = mkDefault true; };
in
{
  programs = {
    pwvucontrol = enabled;
    rofi = enabled;
  };

  services = {
    hyprland-window-emulator = enabled;
    polkit-gnome = enabled;
    dunst = enabled;
    network-manager-applet = enabled;
    blueman-applet = enabled;
  };

  xsession.windowManager.i3.config = import ./settings.nix { inherit pkgs lib config; desktop = "i3"; };
  wayland.windowManager.sway.config = import ./settings.nix { inherit pkgs lib config; desktop = "sway"; };
}
