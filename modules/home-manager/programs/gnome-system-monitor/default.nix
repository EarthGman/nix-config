{ pkgs, config, lib, ... }:
{
  options.programs.gnome-system-monitor.enable = lib.mkEnableOption "enable gnome-system-monitor";
  config = lib.mkIf config.programs.gnome-system-monitor.enable {
    home.packages = with pkgs; [
      gnome-system-monitor
    ];
  };
}
