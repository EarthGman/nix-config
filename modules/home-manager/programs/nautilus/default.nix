{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.nautilus;
in
{
  options.programs.nautilus = {
    enable = mkEnableOption "enable nautilus, a gtk file manager that comes with stock GNOME";

    package = mkOption {
      description = "package for nautilus";
      type = types.package;
      default = pkgs.nautilus;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
