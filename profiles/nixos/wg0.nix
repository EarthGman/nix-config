# EarthGman's client wireguard setup.
{ pkgs, config, ... }:
{
  sops.secrets.wg0_conf.path = "/etc/wireguard/wg0.conf";
  networking = {
    firewall.allowedUDPPorts = [ 51820 ];
    networkmanager.dispatcherScripts = [
      {
        source = pkgs.writeText "wg0hook" ''
          if [ "$1" == "wg0" ]; then
            exit 0
          fi

          case "$2" in
            up)
              systemctl restart wg-quick-wg0
              ;;
            down)
             systemctl stop wg-quick-wg0
             ;;
          esac
        '';
      }
    ];
    wg-quick.interfaces = {
      wg0 = {
        autostart = false;
        configFile = config.sops.secrets.wg0_conf.path; # store whole file in secrets
        postUp = ''
          ip route add 10.10.0.0/24 via 10.0.0.1 dev wg0
        '';
      };
    };
  };
  environment.systemPackages = [ pkgs.dnsmasq ];
}
