# EarthGman's client wireguard setup.
{ config, ... }:
{
  sops.secrets.wg0_conf.path = "/etc/wireguard/wg0.conf";
  networking = {
    # route all traffic destined for a 10.10.x.x address through the wg0 tunnel
    localCommands = ''
      ip route add 10.10.0.0/24 via 10.0.0.1 dev wg0
    '';
    firewall.allowedUDPPorts = [ 51820 ];
    wg-quick.interfaces = {
      wg0 = {
        configFile = config.sops.secrets.wg0_conf.path; # store whole file in secrets
      };
    };
  };
}
