{ keys, config, ... }:
{
  networking.firewall = {
    allowedUDPPorts = [ config.networking.wireguard.interfaces.wg0.listenPort ];
  };
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.0.0.2/24" ];
      listenPort = 51820;
      privateKeyFile = "/etc/wireguard/private_key";

      peers = [
        # school wireguard server
        {
          publicKey = keys.wireguard_server_school;
          allowedIPs = [ "0.0.0.0/0" ];
          name = "School";
          # Or forward only particular subnets
          #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

          endpoint = "192.168.24.159:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}