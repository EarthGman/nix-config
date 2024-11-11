{
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.2/24" ];
      listenPort = 51820;
      privateKeyFile = "/etc/wireguard/private_key";

      # server
      peers = [
        {
          publicKey = "PMxNloIPW9xEROdyZAbPl6CtkrCqSRIZmkcqj9MK5lk=";
          allowedIPs = [ "0.0.0.0/0" ];
          name = "Home2";
          # Or forward only particular subnets
          #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

          endpoint = "192.168.24.159:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
