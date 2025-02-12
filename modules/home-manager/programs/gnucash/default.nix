{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.gnucash;
in
{
  options.programs.gnucash = {
    enable = mkEnableOption "enable gnucash, a finance app for personal use or small businesses";
    package = mkOption {
      description = "package for gnucash";
      types = types.package;
      default = pkgs.gnucash;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
