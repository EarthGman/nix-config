# just a little swayidle abstraction layer
# set timeouts to 0 to disable
{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.swayidle;
in
{
  options.services.swayidle = {
    swaylock = {
      before-sleep = lib.mkEnableOption "swaylock trigger on sleep or laptop lid close";
      on-ac.timeout = lib.mkOption {
        description = "time in seconds until swaylock is triggered while charging";
        default = 0;
        type = lib.types.int;
      };
      on-bat.timeout = lib.mkOption {
        description = "time in seconds until swaylock is triggered while on battery";
        default = 0;
        type = lib.types.int;
      };
    };

    dpms = {
      on-ac.timeout = lib.mkOption {
        description = "time in seconds until the display is turned off while charging";
        default = 0;
        type = lib.types.int;
      };
      on-bat.timeout = lib.mkOption {
        description = "time in seconds until the display is turned off while on battery";
        default = 0;
        type = lib.types.int;
      };
    };

    suspend = {
      on-ac.timeout = lib.mkOption {
        description = "time in seconds until system is suspended while charging";
        default = 0;
        type = lib.types.int;
      };
      on-bat.timeout = lib.mkOption {
        description = "time in seconds until system is suspended while on battery";
        default = 0;
        type = lib.types.int;
      };
    };
  };

  config =
    let
      event-handler = config.gman.scripts.idle-daemon-event-handler;
    in
    {
      services.swayidle = {
        events = lib.optionals (cfg.swaylock.before-sleep) [
          {
            event = "before-sleep";
            command = "swaylock -fF";
          }
        ];
        timeouts =
          lib.optionals (cfg.swaylock.on-ac.timeout > 0) [
            {
              timeout = cfg.swaylock.on-ac.timeout;
              command = "${event-handler} 'swaylock -fF' 1";
            }
          ]
          ++ lib.optionals (cfg.swaylock.on-bat.timeout > 0) [
            {
              timeout = cfg.swaylock.on-bat.timeout;
              command = "${event-handler} 'swaylock -fF' 0";
            }
          ]
          ++ lib.optionals (cfg.dpms.on-ac.timeout > 0) [
            {
              timeout = cfg.dpms.on-ac.timeout;
              command = "${event-handler} 'swaymsg 'output * dpms off'' 1";
              resumeCommand = "swaymsg 'output * dpms on'";
            }
          ]
          ++ lib.optionals (cfg.dpms.on-bat.timeout > 0) [
            {
              timeout = cfg.dpms.on-bat.timeout;
              command = "${event-handler} 'swaymsg 'output * dpms off'' 0";
              resumeCommand = "swaymsg 'output * dpms on'";
            }
          ]
          ++ lib.optionals (cfg.suspend.on-ac.timeout > 0) [
            {
              timeout = cfg.suspend.on-ac.timeout;
              command = "${event-handler} '${pkgs.systemd}/bin/systemctl suspend' 1";
            }
          ]
          ++ lib.optionals (cfg.suspend.on-bat.timeout > 0) [
            {
              timeout = cfg.suspend.on-bat.timeout;
              command = "${event-handler} '${pkgs.systemd}/bin/systemctl suspend' 0";
            }
          ];
      };

      home.packages = [ pkgs.coreutils-full ];

      #TODO understand how environments work with systemd for wayland window managers.
      # potential security vulnerability, and the dpms off doesn't work for some reason
      systemd.user.services.swayidle.Service.Environment = lib.mkForce [
        "PATH=${config.home.homeDirectory}/.nix-profile/bin"
      ];
    };
}
