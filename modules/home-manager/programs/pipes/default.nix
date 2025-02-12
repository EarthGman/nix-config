{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.pipes;
in
{
  options.programs.pipes = {
    enable = mkEnableOption "enable pipes, a useless terminal program that looks cool";

    package = mkOption {
      description = "package for pipes";
      type = types.package;
      default = pkgs.pipes;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
