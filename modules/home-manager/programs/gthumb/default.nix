{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.gthumb;
in
{
  options.programs.gthumb = {
    enable = mkEnableOption "enable gthumb, an image viewer";
    package = mkOption {
      description = "package for gthumb";
      type = types.package;
      default = pkgs.gthumb;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
