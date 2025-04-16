{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkPackageOption;
  program-name = "cutentr";
  cfg = config.programs.${program-name};
in
{
  options.programs.${program-name} = {
    enable = mkEnableOption program-name;
    package = mkPackageOption pkgs "cute-ntr" { };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    networking.firewall.allowedUDPPorts = [ 8001 ];
  };
}
