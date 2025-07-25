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
    hyprlock.timeout = mkOption {
      description = "time in seconds until hyprlock is activated";
      type = types.int;
      default = 0;
    };

    dpms.timeout = mkOption {
      description = "time in seconds until dpms is activated";
      type = types.int;
      default = 0;
    };

    suspend.timeout = mkOption {
      description = "time in seconds until the system is suspended";
      type = types.int;
      default = 0;
    };
  };

  config =
    let
      cfg = config.services.hypridle;
    in
    {
      services.hypridle.settings.listener =
        optionals (cfg.hyprlock.timeout > 0) [
          {
            timeout = cfg.hyprlock.timeout;
            on-timeout = "hyprlock";
          }
        ]
        ++ optionals (cfg.dpms.timeout > 0) [
          {
            timeout = cfg.dpms.timeout;
            on-timeout = "hyprctl dispatch dpms off || swaymsg 'output * dpms off'";
            on-resume = "hyprctl dispatch dpms on || swaymsg 'output * dpms on'";
          }
        ]
        ++ optionals (cfg.suspend.timeout > 0) [
          {
            timeout = cfg.suspend.timeout;
            on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
    };
}
