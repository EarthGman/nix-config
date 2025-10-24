{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.swww;
in
{
  options.services.swww = {
    enable = lib.mkEnableOption "the swww-daemon";

    package = lib.mkPackageOption pkgs "swww" { };

    flags = lib.mkOption {
      description = "extra flags passed to the start of swww-daemon";
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.user = {
      services.swww-daemon = {
        path = [ cfg.package ];
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart =
            "${cfg.package}/bin/swww-daemon"
            + lib.optionalString (cfg.flags != [ ]) (" " + (lib.concatStringsSep " " cfg.flags));
          Restart = "always";
          RestartSec = 5;
        };
        unitConfig = {
          After = "graphical-session.target";
          ConditionEnvironment = "WAYLAND_DISPLAY";
          Description = "swww-daemon";
          PartOf = "graphical-session.target";
        };
      };
    };
  };
}
