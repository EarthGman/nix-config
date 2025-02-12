{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.openconnect;
in
{
  options.programs.openconnect = {
    enable = mkEnableOption "enable openconnect cisco vpn";

    package = mkOption {
      description = "package for openconnect";
      type = types.package;
      default = pkgs.openconnect;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
