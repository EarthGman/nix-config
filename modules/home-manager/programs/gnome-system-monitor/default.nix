{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.gnome-system-monitor;
in
{
  options.programs.gnome-system-monitor = {
    enable = mkEnableOption "enable gnome-system-monitor";
    package = mkOption {
      description = "package for gnome-system-monitor";
      type = types.package;
      default = pkgs.gnome-system-monitor;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
