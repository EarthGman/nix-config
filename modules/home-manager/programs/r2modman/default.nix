{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.r2modman;
in
{
  options.programs.r2modman = {
    enable = mkEnableOption "enable r2modman, an alternative to thunderstore";

    package = mkOption {
      description = "package for r2modman";
      type = types.package;
      default = pkgs.r2modman;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
