{ pkgs, lib, config, wallpapers, ... }:
let
  inherit (pkgs) writeScript;
  inherit (builtins) fetchurl;
  script = writeScript "set-wallpaper-by-month.sh" ''
    #!${pkgs.bash}/bin/bash
   
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
  
    MONTH=$(/run/current-system/sw/bin/date +"%B")
    
    case "$XDG_CURRENT_DESKTOP" in
      "Hyprland")
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

        CURRENT_CHECK=$(hyprctl hypaper listloaded | grep -i "omori-''${MONTH}")
        if [ -n "$CURRENT_CHECK" ]; then
          exit 0
        fi

        hyprctl hyprpaper preload "''${!MONTH}"
        hyprctl hyprpaper wallpaper ",''${!MONTH}"
        hyprctl hyprpaper unload
        exit 0
        ;;
      *)
        ${lib.getExe pkgs.feh} --bg-scale "''${!MONTH}"
        ;;
    esac
  '';
in
{
  options.services.omori-calendar-project.enable = lib.mkEnableOption ''
    enable the omori calendar project service, an automatic wallpaper swticher based on the month
  '';
  config = lib.mkIf config.services.omori-calendar-project.enable {
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
        ExecStart = "${script}";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    # hyprland integration
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "systemctl --user start omori-calendar-project.service"
      ];
      exec = [
        "systemctl --user restart omori-calendar-project.service"
      ];
    };
    # make sure hyprpaper is clear by default
    services.hyprpaper.settings = {
      preload = lib.mkForce [ ];
      wallpaper = lib.mkForce [ ];
    };

    # i3 integration
    xsession.windowManager.i3.config.startup = [
      {
        command = "systemctl --user start omori-calendar-project.service";
        always = false;
        notification = false;
      }
    ];
  };
}
