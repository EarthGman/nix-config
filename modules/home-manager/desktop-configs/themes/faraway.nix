{ pkgs, lib, wallpapers, ... }:
let
  inherit (builtins) fetchurl;
  inherit (lib) mkForce;
  inherit (pkgs) writeScript;

  wait-for-hyprland = writeScript "wait-for-hyprland.sh" ''
    for i in {1..5}; do
      hyprctl clients > /dev/null 2>&1
      if [ $? -eq 0 ]; then
        break
      fi
      sleep 1
    done

    if ! hyprctl clients > /dev/null 2>&1; then
      exit 1
    fi

    systemd --user start omori-calendar-project.service  
  '';
  service-script = writeScript "set-wallpaper-by-month.sh" ''
    #!/usr/bin/env bash

    January="${fetchurl wallpapers.omori-january}"
    Feburary="${fetchurl wallpapers.omori-feburary}"
    March="${fetchurl wallpapers.omori-march}"
    April="${fetchurl wallpapers.omori-april}"
    May="${fetchurl wallpapers.omori-may}"
    June="${fetchurl wallpapers.omori-june}"
    July="${fetchurl wallpapers.omori-july}"
    August="${fetchurl wallpapers.omori-august}"
    September="${fetchurl wallpapers.omori-september}"
    October="${fetchurl wallpapers.omori-october}"
    November="${fetchurl wallpapers.omori-november}"
    December="${fetchurl wallpapers.omori-december}"
  
    MONTH=$(date +"%B")
    CURRENT_CHECK=$(hyprctl hypaper listloaded | grep -i "omori-''${MONTH}")
    
    if [ -n "$CURRENT_CHECK" ]; then
      exit 0
    fi
    
    hyprctl hyprpaper preload "''${!MONTH}"
    hyprctl hyprpaper wallpaper ",''${!MONTH}"
  '';
in
{
  systemd.user.services."omori-calendar-project" = {
    Unit = {
      description = ''
        every day at Midnight, the current month is checked
        sets the wallpaper from the omori calendar project corresponding to the month
      '';
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${service-script}";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${wait-for-hyprland}"
    ];
  };

  systemd.user.timers."omori-calendar-project" = {
    Unit = {
      Description = "Check Month at 12:00 AM";
    };
    Timer = {
      OnCalendar = "*-*-* 00:00:00";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  # prevent hyprpaper from loading the default stylix.image
  services.hyprpaper.settings = {
    preload = mkForce [ ];
    wallpaper = mkForce [ ];
  };

  programs = {
    firefox.theme.name = "shyfox";
  };
}
