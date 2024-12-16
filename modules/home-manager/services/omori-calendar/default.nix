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
          Omori-Calendar-Project: set wallpaper
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

    # hyprland integration
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "systemctl --user start omori-calendar-project.service"
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
