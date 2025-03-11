{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.burpsuite;
in
{
  options.programs.burpsuite = {
    enable = mkEnableOption "enable burpsuite";

    package = mkOption {
      description = "package for burpsuite";
      type = types.package;
      default = pkgs.burpsuite;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
