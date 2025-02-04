{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption;
in
{
  options.services.polkit-gnome.enable = mkEnableOption "enable gnome polkit";
  config = mkIf config.services.polkit-gnome.enable {
    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        Unit = {
          description = "polkit-gnome-authentication-agent-1";
          wantedBy = [ "graphical-session.target" ];
          wants = [ "graphical-session.target" ];
          after = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };
}
