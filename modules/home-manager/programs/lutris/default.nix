{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.lutris;
in
{
  options.programs.lutris = {
    enable = mkEnableOption "enable lutris, a game manager (that is slightly worse than steam)";

    package = mkOption {
      description = "package for lutris";
      type = types.package;
      default = pkgs.lutris;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
