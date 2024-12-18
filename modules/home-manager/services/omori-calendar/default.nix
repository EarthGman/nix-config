{ pkgs, lib, config, desktop, wallpapers, ... }:
let
  inherit (lib) getExe;
  inherit (builtins) fetchurl;
  script = import ./script.nix { inherit pkgs config fetchurl wallpapers getExe; };
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
        Description = ''
          set wallpaper from the omori calendar project
        '';
        After = [ "graphical-session.target" ];
      };
      Service = {
        Environment = "PATH=/run/current-system/sw/bin:${config.home.homeDirectory}/.nix-profile/bin";
        Type = "oneshot";
        ExecStart = "${script}";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    # i3 integration
    xsession.windowManager.i3.config.startup = [
      {
        command = "systemctl --user restart omori-calendar-project";
        always = true;
        notification = false;
      }
    ];

    # if gnome is enabled give a warning
    warnings =
      let
        desktops = lib.splitString "," desktop;
        gnome = builtins.elem "gnome" desktops;
      in
      if gnome then
        [ "The Omori Calendar Project service does not work on gnome. You are seeing this because you have both gnome and the service enabled." ]
      else [ ];
  };
}
