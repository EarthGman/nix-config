{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault;
  enabled = { enable = mkDefault true; };
in
{
  imports = [
    ../i3-sway
  ];

  programs = {
    pwvucontrol = enabled;
    rofi = enabled;
    waybar = enabled;
  };

  services = {
    swww = enabled;
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      output."*" = lib.mkForce { };
      startup = [
      ];
    };
  };
}
