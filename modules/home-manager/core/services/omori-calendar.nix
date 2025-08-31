{
  pkgs,
  lib,
  config,
  ...
}:
let
  script = pkgs.writeShellScript "omori-calendar-project.sh" ''
     January="${pkgs.images.omori-january}"
     February="${pkgs.images.omori-february}"
     March="${pkgs.images.omori-march}"
     April="${pkgs.images.omori-april}"
     May="${pkgs.images.omori-may}"
     June="${pkgs.images.omori-june}"
     July="${pkgs.images.omori-july}"
     August="${pkgs.images.omori-august}"
     September="${pkgs.images.omori-september}"
     October="${pkgs.images.omori-october}"
     November="${pkgs.images.omori-november}"
     December="${pkgs.images.omori-december}"

     MONTH=$(date +"%B")

     if [ -n "$WAYLAND_DISPLAY" ]; then
       userid=$(id -u)
       socket_path="/run/user/$userid/swww-wayland-1.sock"

       for ((i=1; i<=30; i++ )); do
         if [ -e "$socket_path" ]; then
           swww img "''${!MONTH}"
           exit 0
         fi
         sleep 0.1
       done
       exit 1
    fi

     echo "Omori-Calendar-Project.service: Set wallpaper: ''${MONTH} for desktop: ''${XDG_CURRENT_DESKTOP}"
  '';
in
{
  options.services.omori-calendar-project.enable = lib.mkEnableOption "omori calendar project";
  config = lib.mkIf config.services.omori-calendar-project.enable {
    home.packages = [
      pkgs.coreutils-full
    ];

    warnings = lib.mkIf (!config.services.swww.enable) [
      ''
        services.swww is not enabled!
        Omori-calendar project requires a desktop environment supported by swww to function properly
        such as Hyprland or Sway, but not Gnome or KDE Plasma.
      ''
    ];

    systemd.user.timers."omori-calendar-project" = {
      Unit = {
        Description = "12:00 AM date check";
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
        Description = ''
          set wallpaper from the omori calendar project
        '';
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        Environment = "PATH=${config.home.homeDirectory}/.nix-profile/bin";
        ExecStart = "${script}";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
