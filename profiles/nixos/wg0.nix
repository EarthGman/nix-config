# EarthGman's client wireguard setup.
{ pkgs, config, ... }:
{
  sops.secrets.wg0_conf.path = "/etc/wireguard/wg0.conf";
  networking = {
    networkmanager.dispatcherScripts = [{
      source = pkgs.writeScript "wg0-refresh-hook.sh" ''
        INTERFACE=$1
        STATE=$2

        if [ "$STATE" != "up" ] || [ "$INTERFACE" = "wg0" ]; then
          exit 0
        fi

        systemctl restart wg-quick-wg0
      '';
      type = "basic";
    }];
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
