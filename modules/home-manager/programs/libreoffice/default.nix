{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.libreoffice;
in
{
  options.programs.libreoffice = {
    enable = mkEnableOption "enable libreoffice";

    package = mkOption {
      description = "package for libreoffice";
      type = types.package;
      default = pkgs.libreoffice;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
