# This is a hackfix for dolphin on non-KDE plasma desktop environments (sway, hyprland, etc)
# Attempting to mount a samba share which requires a password will result in a failure.
# The fix is to run the .kiod6-wrapped as a service unit.
{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.kio;
in
{
  options.services.kio.enable = lib.mkEnableOption "A hackfix for dolphin on non-kde environments";

  config = lib.mkIf cfg.enable {
    systemd.user.services."kiod6" = {
      Unit = {
        Description = "KDE plasma IO daemon";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.kdePackages.kio}/libexec/kf6/kiod6";
      };
    };
  };
}
