{ lib, config, ... }:
let
  inherit (lib) mkIf mkDefault optionals mkEnableOption getExe;
  cfg = config.profiles.sway.default;
  enabled = { enable = mkDefault true; };
in
{
  options.profiles.sway.default.enable = mkEnableOption "default sway config";
  config = mkIf cfg.enable {
    stylix.targets.sway.enable = true;

    programs = mkIf config.wayland.windowManager.sway.enable {
      swaylock = enabled;
      waybar = enabled;
      rofi = enabled;
    };

    services = mkIf config.wayland.windowManager.sway.enable {
      swww = enabled;
      swayidle = {
        enable = mkDefault true;
        settings = {
          swaylock = {
            before-sleep = true;
          };
          dpms.timeout = mkDefault 300;
        };
      };
    };

    wayland.windowManager.sway = {
      systemd.enable = false;
      config = {
        output."*" = lib.mkForce { };
        startup = [
          {
            command = "uwsm finalize";
          }
          {
            command = "systemctl --user restart waybar";
            always = true;
          }
          {
            command = "swaymsg workspace 1";
            always = false;
          }
          {
            command = "systemctl --user restart swww";
            always = true;
          }
          # dont know why but kanshi seems to not restart properly when sway is reloaded
        ] ++ optionals (config.services.kanshi.enable) [
          {
            command = "systemctl --user restart kanshi";
            always = true;
          }
        ];
      };
    };
  };
}
