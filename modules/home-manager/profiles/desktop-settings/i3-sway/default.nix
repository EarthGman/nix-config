# shared config between sway and i3
{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkDefault mkIf mkMerge;
  enabled = {
    enable = mkDefault true;
  };
  cfg = config.profiles;
in
{
  config = mkIf (cfg.sway.default.enable || cfg.i3.default.enable) (mkMerge [
    {
      xsession.windowManager.i3.config = import ./settings.nix {
        inherit pkgs lib config;
        desktop = "i3";
      };
      wayland.windowManager.sway.config = import ./settings.nix {
        inherit pkgs lib config;
        desktop = "sway";
      };
    }
    (mkIf (config.xsession.windowManager.i3.enable || config.wayland.windowManager.sway.enable) {
      programs = {
        pwvucontrol = enabled;
        rofi = enabled;
      };

      services = {
        hyprland-window-emulator = enabled;
        polkit-gnome = enabled;
        network-manager-applet = enabled;
        blueman-applet = enabled;
      };
    })
  ]);
}
