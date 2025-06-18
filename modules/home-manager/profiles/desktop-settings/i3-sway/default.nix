{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault mkIf;
  enabled = { enable = mkDefault true; };
  cfg = config.profiles;
in
{
  config = mkIf (cfg.sway.default.enable || cfg.i3.default.enable) {
    programs = mkIf (config.xsession.windowManager.i3.enable || config.wayland.windowManager.sway.enable) {
      pwvucontrol = enabled;
      rofi = enabled;
    };

    services = mkIf (config.xsession.windowManager.i3.enable || config.wayland.windowManager.sway.enable) {
      hyprland-window-emulator = enabled;
      polkit-gnome = enabled;
      dunst = enabled;
      network-manager-applet = enabled;
      blueman-applet = enabled;
    };

    xsession.windowManager.i3.config = mkIf cfg.i3.default.enable (import ./settings.nix { inherit pkgs lib config; desktop = "i3"; });
    wayland.windowManager.sway.config = mkIf cfg.sway.default.enable (import ./settings.nix { inherit pkgs lib config; desktop = "sway"; });
  };
}
