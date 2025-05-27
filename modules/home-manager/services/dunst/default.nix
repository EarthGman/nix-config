{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf getExe types mkOption mkEnableOption;
  cfg = config.services.dunst;

  script = pkgs.writeScript "battery-check.sh" ''
    #!${pkgs.bash}/bin/bash
    BATTERY_PATH="$(${getExe pkgs.fd} BAT /sys/class/power_supply)"

    if [[ -z "$BATTERY_PATH" ]]; then
    echo "Error: No battery found on this system." >&2
      exit 1
    fi

    BATTERY_CAPACITY="$BATTERY_PATH/capacity"
    BATTERY_STATUS="$BATTERY_PATH/status"

    capacity=$(${pkgs.coreutils-full}/bin/cat "$BATTERY_CAPACITY")
    status=$(${pkgs.coreutils-full}/bin/cat "$BATTERY_STATUS")

    if [[ "$status" == "Discharging" && "$capacity" -le ${toString cfg.battery-monitor.threshold} ]]; then
      ${cfg.package}/bin/dunstify "Warning: Battery has "''${capacity}"% remaining."
    fi
  '';
in
{
  options.services.dunst.battery-monitor = {
    enable = mkEnableOption ''
      battery monitor for dunst
    '';
    checkInterval = mkOption {
      type = types.int;
      description = "check interval for the battery monitor in seconds";
      default = 180;
    };
    threshold = mkOption {
      type = types.int;
      description = "percentage of the battery in which the notification is triggered as an integer";
      default = 10;
    };
  };
  config = mkIf (cfg.enable && cfg.battery-monitor.enable) {
    systemd.user.timers."battery-monitor" = {
      Unit = {
        Description = "battery check";
      };
      Timer = {
        Persistent = true;
        OnUnitActiveSec = "${toString cfg.battery-monitor.checkInterval}s";
      };
      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
    systemd.user.services."battery-monitor" = {
      Unit = {
        Description = "battery monitor service";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${script}";
      };
    };
  };
}
