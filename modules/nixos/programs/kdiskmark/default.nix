{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkPackageOption;
  program-name = "kdiskmark";
  cfg = config.programs.${program-name};
in
{
  options.programs.${program-name} = {
    enable = mkEnableOption program-name;
    package = mkPackageOption pkgs program-name { };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
