{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.ardour;
in
{
  options.programs.ardour = {
    enable = mkEnableOption "enable ardour, a music DAW";

    package = mkOption {
      description = "package for ardour";
      type = types.package;
      default = pkgs.ardour;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
