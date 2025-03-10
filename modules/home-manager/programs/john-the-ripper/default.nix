{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.john;
in
{
  options.programs.john = {
    enable = mkEnableOption "enable john-the-ripper a password cracker";

    package = mkOption {
      description = "package for john the ripper";
      type = types.package;
      default = pkgs.john;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
