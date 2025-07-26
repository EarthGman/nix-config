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
    getExe
    types
    mkEnableOption
    ;
  cfg = config.services.swayidle;
in
{
  options.services.swayidle = {
    swaylock = {
      before-sleep = mkEnableOption "swaylock trigger on sleep or laptop lid close";
      timeout = mkOption {
        description = "time in seconds until swaylock is triggered";
        default = 0;
        type = types.int;
      };
    };

    dpms = {
      timeout = mkOption {
        description = "time in seconds until the display is turned off";
        default = 0;
        type = types.int;
      };
    };

    suspend = {
      timeout = mkOption {
        description = "time in seconds until system is suspended by swayidle";
        default = 0;
        type = types.int;
      };
    };
  };

  config = {
    services.swayidle = {
      events = optionals (cfg.swaylock.before-sleep) [
        {
          event = "before-sleep";
          command = "swaylock -fF";
        }
      ];
      timeouts =
        optionals (cfg.swaylock.timeout > 0) [
          {
            timeout = cfg.settings.swaylock.timeout;
            command = "swaylock -fF";
          }
        ]
        ++ optionals (cfg.dpms.timeout > 0) [
          {
            timeout = cfg.dpms.timeout;
            command = "swaymsg 'output * dpms off'";
            resumeCommand = "swaymsg 'output * dpms on'";
          }
        ]
        ++ optionals (cfg.suspend.timeout > 0) [
          {
            timeout = cfg.suspend.timeout;
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
    };
  };
}
