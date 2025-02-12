{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.gnome-clocks;
in
{
  options.programs.gnome-clocks = {
    enable = mkEnableOption "enable gnome-clocks";
    package = mkOption {
      description = "package for gnome-clocks";
      type = types.package;
      default = pkgs.gnome-clocks;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
