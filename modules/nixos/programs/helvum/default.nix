{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkPackageOption;
  program-name = "helvum";
  cfg = config.programs.helvum;
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
