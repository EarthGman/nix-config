{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.ghex;
in
{
  options.programs.ghex = {
    enable = mkEnableOption "enable ghex, a gtk hex editor";

    package = mkOption {
      description = "package for ghex";
      type = types.package;
      default = pkgs.ghex;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
