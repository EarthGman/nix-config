# easy to configure abstraction for home-manager's hypridle service
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.services.hypridle = {
    hyprlock = {
      on-ac.timeout = lib.mkOption {
        description = "time in seconds until hyprlock is activated while charging";
        type = lib.types.int;
        default = 0;
      };
      on-bat.timeout = lib.mkOption {
        description = "time in seconds until hyprlock is activated while on battery";
        type = lib.types.int;
        default = 0;
      };
    };

    dpms = {
      on-ac.timeout = lib.mkOption {
        description = "time in seconds until screen-blank is activated while charging";
        type = lib.types.int;
        default = 0;
      };
      on-bat.timeout = lib.mkOption {
        description = "time in seconds until screen-blank is activated while on battery";
        type = lib.types.int;
        default = 0;
      };
    };

    suspend = {
      on-ac.timeout = lib.mkOption {
        description = "time in seconds until the system is suspended while charging";
        type = lib.types.int;
        default = 0;
      };
      on-bat.timeout = lib.mkOption {
        description = "time in seconds until the system is suspended when on battery";
        type = lib.types.int;
        default = 0;
      };
    };
  };

  config =
    let
      cfg = config.services.hypridle;
      event-handler = config.gman.scripts.idle-daemon-event-handler;
    in
    {
      services.hypridle.settings.listener =
        lib.optionals (cfg.hyprlock.on-ac.timeout > 0) [
          {
            timeout = cfg.hyprlock.on-ac.timeout;
            on-timeout = "${event-handler} hyprlock 1";
          }
        ]
        ++ lib.optionals (cfg.hyprlock.on-bat.timeout > 0) [
          {
            timeout = cfg.hyprlock.on-bat.timeout;
            on-timeout = "${event-handler} hyprlock 0";
          }
        ]
        ++ lib.optionals (cfg.dpms.on-ac.timeout > 0) [
          {
            timeout = cfg.dpms.on-ac.timeout;
            on-timeout = "${event-handler} 'hyprctl dispatch dpms off' 1";
            on-resume = "hyprctl dispatch dpms on";
          }
        ]
        ++ lib.optionals (cfg.dpms.on-bat.timeout > 0) [
          {
            timeout = cfg.dpms.on-bat.timeout;
            on-timeout = "${event-handler} 'hyprctl dispatch dpms off' 0";
            on-resume = "hyprctl dispatch dpms on";
          }
        ]
        ++ lib.optionals (cfg.suspend.on-ac.timeout > 0) [
          {
            timeout = cfg.suspend.on-ac.timeout;
            on-timeout = "${event-handler} '${pkgs.systemd}/bin/systemctl suspend' 1";
          }
        ]
        ++ lib.optionals (cfg.suspend.on-bat.timeout > 0) [
          {
            timeout = cfg.suspend.on-bat.timeout;
            on-timeout = "${event-handler} '${pkgs.systemd}/bin/systemctl suspend' 0";
          }
        ];
    };
}
