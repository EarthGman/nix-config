{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.gscan2pdf;
in
{
  options.programs.gscan2pdf = {
    enable = mkEnableOption "enable gscan2pdf a document scanning app";
    package = mkOption {
      description = "package for gscan2pdf";
      type = types.package;
      default = pkgs.gscan2pdf;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
