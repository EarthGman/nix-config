# EarthGman's client wireguard setup.
{ config, ... }:
{
  sops.secrets.wg1_conf.path = "/etc/wireguard/wg1.conf";
  networking = {
    firewall.allowedUDPPorts = [ 51821 ];
    wg-quick.interfaces = {
      wg1 = {
        configFile = config.sops.secrets.wg1_conf.path; # store whole file in secrets
      };
    };
  };
}
