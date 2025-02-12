{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.flips;
in
{
  options.programs.flips = {
    enable = mkEnableOption "enable flips, floating ips rom patcher";

    package = mkOption {
      description = "package for flips";
      type = types.package;
      default = pkgs.flips;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
