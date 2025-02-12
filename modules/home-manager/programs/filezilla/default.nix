{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.filezilla;
in
{
  options.programs.filezilla = {
    enable = mkEnableOption "enable filezilla";

    package = mkOption {
      description = "package for filezilla";
      type = types.package;
      default = pkgs.filezilla;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
