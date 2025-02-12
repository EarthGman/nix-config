{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.sl;
in
{
  options.programs.sl = {
    enable = mkEnableOption "enable sl, a steam locomotive in your terminal";

    package = mkOption {
      description = "package for sl";
      type = types.package;
      default = pkgs.sl;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
