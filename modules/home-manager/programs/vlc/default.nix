{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.vlc;
in
{
  options.programs.vlc = {
    enable = mkEnableOption "enable vlc, a video player";

    package = mkOption {
      description = "package for vlc";
      type = types.package;
      default = pkgs.vlc;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
