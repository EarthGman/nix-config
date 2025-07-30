# just a little swayidle abstraction layer
# set timeouts to 0 to disable
{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib)
    mkOption
    optionals
    types
    mkEnableOption
    ;
  cfg = config.services.swayidle;
in
{
  options.services.swayidle = {
    swaylock = {
      before-sleep = mkEnableOption "swaylock trigger on sleep or laptop lid close";
      on-ac.timeout = mkOption {
        description = "time in seconds until swaylock is triggered while charging";
        default = 0;
        type = types.int;
      };
      on-bat.timeout = mkOption {
        description = "time in seconds until swaylock is triggered while on battery";
        default = 0;
        type = types.int;
      };
    };

    dpms = {
      on-ac.timeout = mkOption {
        description = "time in seconds until the display is turned off while charging";
        default = 0;
        type = types.int;
      };
      on-bat.timeout = mkOption {
        description = "time in seconds until the display is turned off while on battery";
        default = 0;
        type = types.int;
      };
    };

    suspend = {
      on-ac.timeout = mkOption {
        description = "time in seconds until system is suspended while charging";
        default = 0;
        type = types.int;
      };
      on-bat.timeout = mkOption {
        description = "time in seconds until system is suspended while on battery";
        default = 0;
        type = types.int;
      };
    };
  };

  config =
    let
      scripts = import ../../scripts { inherit pkgs lib config; };
      event-handler = scripts.idle-daemon-event-handler;
    in
    {
      services.swayidle = {
        events = optionals (cfg.swaylock.before-sleep) [
          {
            event = "before-sleep";
            command = "swaylock -fF";
          }
        ];
        timeouts =
          optionals (cfg.swaylock.on-ac.timeout > 0) [
            {
              timeout = cfg.swaylock.on-ac.timeout;
              command = "${event-handler} 'swaylock -fF' 1";
            }
          ]
          ++ optionals (cfg.swaylock.on-bat.timeout > 0) [
            {
              timeout = cfg.swaylock.on-bat.timeout;
              command = "${event-handler} 'swaylock -fF' 0";
            }
          ]
          ++ optionals (cfg.dpms.on-ac.timeout > 0) [
            {
              timeout = cfg.dpms.on-ac.timeout;
              command = "${event-handler} 'swaymsg 'output * dpms off'' 1";
              resumeCommand = "swaymsg 'output * dpms on'";
            }
          ]
          ++ optionals (cfg.dpms.on-bat.timeout > 0) [
            {
              timeout = cfg.dpms.on-bat.timeout;
              command = "${event-handler} 'swaymsg 'output * dpms off'' 0";
              resumeCommand = "swaymsg 'output * dpms on'";
            }
          ]
          ++ optionals (cfg.suspend.on-ac.timeout > 0) [
            {
              timeout = cfg.suspend.on-ac.timeout;
              command = "${event-handler} '${pkgs.systemd}/bin/systemctl suspend' 1";
            }
          ]
          ++ optionals (cfg.suspend.on-bat.timeout > 0) [
            {
              timeout = cfg.suspend.on-bat.timeout;
              command = "${event-handler} '${pkgs.systemd}/bin/systemctl suspend' 0";
            }
          ];
      };
    };
}
