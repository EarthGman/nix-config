{ config, lib, ... }:
let
  cfg = config.modules.printing;
in
{
  options.modules.printing.enable = lib.mkEnableOption "enable printing";
  config = lib.mkIf cfg.enable {
    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      printing = {
        enable = true;
        browsed.enable = false;
      };
    };
    networking.firewall.allowedUDPPorts = [ 5353 ];
  };
}
