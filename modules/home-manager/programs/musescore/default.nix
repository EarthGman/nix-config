{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.musescore;
in
{
  options.programs.musescore = {
    enable = mkEnableOption "enable musescore";

    package = mkOption {
      description = "package for musescore";
      type = types.package;
      default = pkgs.musescore;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
