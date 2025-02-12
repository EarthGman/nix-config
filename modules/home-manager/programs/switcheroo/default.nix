{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.switcheroo;
in
{
  options.programs.switcheroo = {
    enable = mkEnableOption "enable switcheroo";

    package = mkOption {
      description = "package for switcheroo";
      type = types.package;
      default = pkgs.switcheroo;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
