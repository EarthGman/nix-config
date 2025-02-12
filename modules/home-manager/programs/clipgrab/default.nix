{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.clipgrab;
in
{
  options.programs.clipgrab = {
    enable = mkEnableOption "enable clipgrab, a program to download clips from various websites";
    package = mkOption {
      description = "package for clipgrab";
      type = types.package;
      default = pkgs.clipgrab;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
