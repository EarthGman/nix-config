{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption mkPackageOption;
  cfg = config.programs.lutris;
in
{
  options.programs.lutris = {
    enable = mkEnableOption "game manager for linux";
    package = mkPackageOption pkgs "lutris" { };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
