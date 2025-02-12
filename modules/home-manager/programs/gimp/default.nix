{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.gimp;
in
{
  options.programs.gimp = {
    enable = mkEnableOption "enable gimp";

    package = mkOption {
      description = "package for gimp";
      type = types.package;
      default = pkgs.gimp;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
