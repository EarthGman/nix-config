{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkDefault
    mkMerge
    ;
  cfg = config.profiles.hyprland.default;
  enabled = {
    enable = lib.mkDefault true;
  };
  scripts = import ../../../scripts { inherit pkgs lib config; };
in
{
  options.profiles.hyprland.default = {
    enable = mkEnableOption "default hyprland config";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      stylix.targets.hyprland.enable = true;

      wayland.windowManager.hyprland = {
        systemd.enable = false;
        xwayland.enable = true;
        settings = import ./settings.nix {
          inherit
            pkgs
            lib
            config
            scripts
            ;
        };
      };
    }

    (mkIf config.wayland.windowManager.hyprland.enable {
      home.packages = [ pkgs.grimblast ];

      programs = {
        rofi = enabled;
        waybar = enabled;
        hyprlock = enabled;
      };

      services = {
        hypridle = {
          enable = mkDefault true;
          dpms.timeout = mkDefault 300;

          settings.general = {
            before_sleep_cmd = "hyprlock";
            after_sleep_cmd = "hyprctl dispatch dpms on";
            ignore_dbus_inhibit = false;
            lock_cmd = "hyprlock";
          };
        };

        hyprpaper.enable = if (config.services.swww.enable) then (lib.mkForce false) else true;
        swww = enabled;
        polkit-gnome = enabled;
        swaync = enabled;
        network-manager-applet = enabled;
      };
    })
  ]);
}
