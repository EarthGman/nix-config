{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.zoom;
in
{
  options.programs.zoom = {
    enable = mkEnableOption "enable zoom, a web meeting app";

    package = mkOption {
      description = "package for zoom";
      type = types.package;
      default = pkgs.zoom-us;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
