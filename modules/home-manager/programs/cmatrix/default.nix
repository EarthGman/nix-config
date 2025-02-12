{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.cmatrix;
in
{
  options.programs.cmatrix = {
    enable = mkEnableOption "enable cmatrix, a fun terminal program that draws a colored matrix";

    package = mkOption {
      description = "package for cmatrix";
      type = types.package;
      default = pkgs.cmatrix;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
