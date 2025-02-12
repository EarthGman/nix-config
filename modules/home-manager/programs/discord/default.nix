{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkOption mkEnableOption types;
  cfg = config.programs.discord;
in
{
  options.programs.discord = {
    enable = mkEnableOption "enable discord";
    package = mkOption {
      description = "package for discord";
      type = types.package;
      default = pkgs.vesktop;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
