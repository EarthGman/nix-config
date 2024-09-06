{ pkgs, config, lib, ... }:
{
  options.custom.gnome-system-monitor.enable = lib.mkEnableOption "enable gnome-system-monitor";
  config = lib.mkIf config.custom.gnome-system-monitor.enable {
    home.packages = with pkgs; [
      gnome.gnome-system-monitor
    ];
  };
}
