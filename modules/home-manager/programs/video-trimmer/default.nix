{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.video-trimmer;
in
{
  options.programs.video-trimmer = {
    enable = mkEnableOption "enable video trimmer";

    package = mkOption {
      description = "package for video trimmer";
      type = types.package;
      default = pkgs.video-trimmer;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
