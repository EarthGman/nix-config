{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.gnome-calculator;
in
{
  options.programs.gnome-calculator = {
    enable = mkEnableOption "enable gnome-calculator";

    package = mkOption {
      description = "package for gnome-calculator";
      type = types.package;
      default = pkgs.gnome-calculator;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
