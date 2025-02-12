{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.bottles;
in

{
  options.programs.bottles = {
    enable = mkEnableOption "enable wine and bottles";

    package = mkOption {
      description = "package for bottles";
      type = types.package;
      default = pkgs.bottles;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
