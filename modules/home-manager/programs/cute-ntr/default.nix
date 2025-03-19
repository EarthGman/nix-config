{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.cute-ntr;
in
{
  options.programs.cute-ntr = {
    enable = mkEnableOption "enable cuteNTR a 3ds streaming client for PC";

    package = mkOption {
      description = "package for cuteNTR";
      type = types.package;
      default = pkgs.cute-ntr;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
