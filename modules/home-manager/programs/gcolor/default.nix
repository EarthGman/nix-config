{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.gcolor;
in
{
  options.programs.gcolor = {
    enable = mkEnableOption "enable gcolor, a gtk color picker app";
    package = mkOption {
      description = "package for gcolor";
      type = types.package;
      default = pkgs.gcolor3;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
