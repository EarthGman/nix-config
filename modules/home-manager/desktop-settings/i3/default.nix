{ pkgs, config, lib, ... }:
let
  inherit (lib) mkDefault;
  enabled = { enable = mkDefault true; };
  scripts = import ./scripts.nix { inherit pkgs lib config; };
in
{
  imports = [ ./hyprland-windows.nix ];
  programs = {
    pwvucontrol = enabled;
    rofi = enabled;
    i3lock.settings = {
      ignoreEmptyPassword = mkDefault true;
    };
  };

  services = {
    hyprland-windows-for-i3 = enabled;
    network-manager-applet = enabled;
    polybar = enabled;
    picom = enabled;
    dunst = enabled;
  };

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = import ./settings.nix { inherit pkgs lib config scripts; };
    };
  };
}
