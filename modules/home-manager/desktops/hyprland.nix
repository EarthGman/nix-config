{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.wayland.windowManager.hyprland;
in
{
  options = {
    wayland.windowManager.hyprland.mainMod = lib.mkOption {
      description = "main mod for the hyprland tiling window manager";
      type = lib.types.str;
      default = "SUPER";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
    ];

    # if swayidle is somehow enabled on hyprland then stop it
    wayland.windowManager.hyprland.settings.exec-once = mkIf config.services.swayidle.enable
      [
        "systemctl --user stop swayidle"
      ];
  };
}
