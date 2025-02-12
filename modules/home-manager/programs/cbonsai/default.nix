{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.cbonsai;
in
{
  options.programs.cbonsai = {
    enable = mkEnableOption "enable cbonsai a command line random bonsai tree generator";

    package = mkOption {
      description = "enable cbonsai, a fun app that grows bonsai trees in your terminal";
      type = types.package;
      default = pkgs.cbonsai;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
