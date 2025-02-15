{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.rpi-imager;
in
{
  options.programs.rpi-imager = {
    enable = mkEnableOption "enable rpi-imager, a program for building rasperry pi OS images";

    package = mkOption {
      description = "package for rpi-imager";
      type = types.package;
      default = pkgs.rpi-imager;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
