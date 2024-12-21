{ pkgs, lib, config, wallpapers, ... }:
let
  inherit (lib) getExe mkForce;
  inherit (builtins) fetchurl;
  script = import ./script.nix { inherit pkgs config fetchurl wallpapers getExe; };
in
{
  options.services.omori-calendar-project.enable = lib.mkEnableOption ''
    enable the omori calendar project service, auto detects the month every day at 12AM and will set a wallpaper from the Omori Calendar Project
    designed for use by outputs.homeProfiles.desktopThemes.faraway but can be used as a standalone
    Warning: will overrwrite all other monitor wallpaper configuration slideshows and or multi monitor setups
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
        Type = "oneshot";
        ExecStart = "${script}";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    # remove my custom feh service while keeping the actual program
    services.fehbg.enable = mkForce false;
    programs.feh.enable = mkForce true;

    # for wayland
    services.swww.enable = mkForce true;


    xsession.initExtra = ''
      systemctl --user start omori-calendar-project;
    '';
  };
}
