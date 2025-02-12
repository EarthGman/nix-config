{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.museeks;
in
{
  options.programs.museeks = {
    enable = mkEnableOption "enable museeks, a music library player and manager";

    package = mkOption {
      description = "package for museeks";
      type = types.package;
      default = pkgs.museeks;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
