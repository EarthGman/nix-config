{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.looking-glass;
in
{
  options.programs.looking-glass = {
    enable = mkEnableOption "enable looking-glass-client";

    package = mkOption {
      description = "package for looking-glass-client";
      type = types.package;
      default = pkgs.looking-glass-client;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
