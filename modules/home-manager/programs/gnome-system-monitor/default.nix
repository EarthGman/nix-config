{ pkgs, config, lib, ... }:
{
  options.gnome-system-monitor.enable = lib.mkEnableOption "enable gnome-system-monitor";
  config = lib.mkIf config.gnome-system-monitor.enable {
    home.packages = with pkgs; [
      gnome.gnome-system-monitor
    ];
  };
}
