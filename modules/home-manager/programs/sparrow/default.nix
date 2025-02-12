{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.sparrow;
in
{
  options.programs.sparrow = {
    enable = mkEnableOption "enable sparrow a bitcoin trading app for linux";

    package = mkOption {
      description = "package for sparrow";
      type = types.package;
      default = pkgs.sparrow;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
