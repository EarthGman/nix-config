{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.openshot;
in
{
  options.programs.openshot = {
    enable = mkEnableOption "enable openshot video editor";

    package = mkOption {
      description = "package for openshot";
      type = types.package;
      default = pkgs.openshot-qt;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
