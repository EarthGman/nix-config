{
  lib,
  config,
  ...
}:
let
  program-name = "cutentr";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];

    networking.firewall.allowedUDPPorts = [ 8001 ];
  };
}
