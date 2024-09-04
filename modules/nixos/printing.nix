{ config, lib, ... }:
{
  options.custom = {
    printing.enable = lib.mkEnableOption "enable printing";
  };
  config = lib.mkIf config.custom.printing.enable {
    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      printing.enable = true;
    };
    networking.firewall.allowedUDPPorts = [ 5353 ];
  };
}
