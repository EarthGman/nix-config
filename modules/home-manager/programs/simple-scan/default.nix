{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.simple-scan;
in
{
  options.programs.simple-scan = {
    enable = mkEnableOption "enable simple-scan, a document scanning app";

    package = mkOption {
      description = "package for simple-scan";
      type = types.package;
      default = pkgs.simple-scan;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
