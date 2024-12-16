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
      };
      Service = {
        Environment = "PATH=/run/current-system/sw/bin";
        Type = "exec";
        ExecStart = "${script}";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
