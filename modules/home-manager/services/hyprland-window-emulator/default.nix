{ pkgs, lib, config, ... }:
let
  cfg = config.services.hyprland-window-emulator;
  script = import ./script.nix { inherit pkgs lib config; };
in
{
  options.services.hyprland-window-emulator.enable = lib.mkEnableOption "enable hyprland window creation style for i3";
  config = lib.mkIf cfg.enable {
    systemd.user.services."hyprland-windows-for-sway-i3" = {
      Unit = {
        Description = "Hyprland window creation pattern in sway and i3";
        After = [ "graphical-session.target" ];
        Wants = [ "graphical-session.target" ];
      };
      Service = {
        Environment = "PATH=/run/current-system/sw/bin:${config.home.homeDirectory}/.nix-profile/bin";
        Type = "exec";
        ExecStartPre = "${lib.getExe pkgs.bash} -c 'while ! (i3-msg -t get_version >/dev/null 2>&1 || swaymsg -t get_version >/dev/null 2>&1); do sleep 1; done'";
        ExecStart = "${script}";
        Restart = "on-failure";
        RestartSec = 5;
        StartLimitIntervalSec = 30;
        StartLimitBurst = 3;
        type = "simple";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
