# easy to configure abstraction for home-manager's hypridle service
{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkOption types optionals;
in
{
  options.services.hypridle = {
    hyprlock = {
      on-ac.timeout = mkOption {
        description = "time in seconds until hyprlock is activated while charging";
        type = types.int;
        default = 0;
      };
      on-bat.timeout = mkOption {
        description = "time in seconds until hyprlock is activated while on battery";
        type = types.int;
        default = 0;
      };
    };

    dpms = {
      on-ac.timeout = mkOption {
        description = "time in seconds until screen-blank is activated while charging";
        type = types.int;
        default = 0;
      };
      on-bat.timeout = mkOption {
        description = "time in seconds until screen-blank is activated while on battery";
        type = types.int;
        default = 0;
      };

    };

    suspend = {
      on-ac.timeout = mkOption {
        description = "time in seconds until the system is suspended while charging";
        type = types.int;
        default = 0;
      };
      on-bat.timeout = mkOption {
        description = "time in seconds until the system is suspended when on battery";
        type = types.int;
        default = 0;
      };
    };
  };

  config =
    let
      cfg = config.services.hypridle;

      # script to check power state: EVENT POWER_STATE (0 for bat, 1 for AC)
      scripts = import ../../scripts { inherit pkgs lib config; };
      event-handler = scripts.idle-daemon-event-handler;
    in
    {
      services.hypridle.settings.listener =
        optionals (cfg.hyprlock.on-ac.timeout > 0) [
          {
            timeout = cfg.hyprlock.on-ac.timeout;
            on-timeout = "${event-handler} hyprlock 1";
          }
        ]
        ++ optionals (cfg.hyprlock.on-bat.timeout > 0) [
          {
            timeout = cfg.hyprlock.on-bat.timeout;
            on-timeout = "${event-handler} hyprlock 0";
          }
        ]
        ++ optionals (cfg.dpms.on-ac.timeout > 0) [
          {
            timeout = cfg.dpms.on-ac.timeout;
            on-timeout = "${event-handler} 'hyprctl dispatch dpms off' 1";
            on-resume = "hyprctl dispatch dpms on";
          }
        ]
        ++ optionals (cfg.dpms.on-bat.timeout > 0) [
          {
            timeout = cfg.dpms.on-bat.timeout;
            on-timeout = "${event-handler} 'hyprctl dispatch dpms off' 0";
            on-resume = "hyprctl dispatch dpms on";
          }
        ]
        ++ optionals (cfg.suspend.on-ac.timeout > 0) [
          {
            timeout = cfg.suspend.on-ac.timeout;
            on-timeout = "${event-handler} '${pkgs.systemd}/bin/systemctl suspend' 1";
          }
        ]
        ++ optionals (cfg.suspend.on-bat.timeout > 0) [
          {
            timeout = cfg.suspend.on-bat.timeout;
            on-timeout = "${event-handler} '${pkgs.systemd}/bin/systemctl suspend' 0";
          }
        ];
    };
}
