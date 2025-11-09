{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.kde-polkit-agent;
in
{
  options.services.kde-polkit-agent = {
    enable = lib.mkEnableOption "polkit agent from KDE plasma";

    package = lib.mkPackageOption pkgs.kdePackages "polkit-kde-agent-1" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.user = {
      services.kde-polkit-agent = {
        path = [ cfg.package ];
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${cfg.package}/libexec/polkit-kde-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 5;
        };
        unitConfig = {
          After = "graphical-session.target";
          Description = "kde-polkit-agent";
          PartOf = "graphical-session.target";
        };
      };
    };
  };
}
