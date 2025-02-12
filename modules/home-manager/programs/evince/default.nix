{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.evince;
in
{
  options.programs.evince = {
    enable = mkEnableOption "enable evince, a lightweight and useful pdf viewer from GNOME";
    package = mkOption {
      description = "package for evince";
      type = types.package;
      default = pkgs.evince;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
