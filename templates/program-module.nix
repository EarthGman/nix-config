{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.program-name;
in
{
  options.programs.program-name = {
    enable = mkEnableOption "enable program-name";

    package = mkOption {
      description = "package for program-name";
      type = types.package;
      default = pkgs.program-name;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
