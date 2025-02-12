{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.moonlight;
in
{
  options.programs.moonlight = {
    enable = mkEnableOption "enable moonlight, a client for remote desktop with sunshine";

    package = mkOption {
      description = "package for moonlight";
      type = types.package;
      default = pkgs.moonlight-qt;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
