{ pkgs, lib, config, ... }:
let
  cfg = config.services.hyprland-windows-for-i3;
  scripts = import ./scripts.nix { inherit pkgs lib config; };
in
{
  options.services.hyprland-windows-for-i3.enable = lib.mkEnableOption "enable hyprland window creation style for i3";
  config = lib.mkIf cfg.enable {
    systemd.user.services."hyprland-windows-for-i3" = {
      Unit = {
        Description = "Hyprland window creation pattern in i3";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Environment = "PATH=/run/current-system/sw/bin";
        Type = "exec";
        ExecStart = "${scripts.hyprland_windows}";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
