{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.cutentr;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    networking.firewall.allowedUDPPorts = [ 8001 ];
  };
}
