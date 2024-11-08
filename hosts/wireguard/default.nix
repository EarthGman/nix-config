{ pkgs, lib, config, ... }:
let
  iptables = "${pkgs.iptables}/bin/iptables";
in
{
  users.users."root" = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNRHd6NLt4Yd9y5Enu54fJ/a2VCrRgbvfMuom3zn5zg"
    ];
  };

  modules = {
    sops.enable = true;
  };

  sops.secrets.private_key.path = "/etc/wireguard/private_key";

  networking = {
    nat = {
      enable = true;
      externalInterface = "eth0";
      internalInterfaces = [ "wg0" ];
    };
    firewall.allowedUDPPorts = [ 51820 ];
    wireguard.interfaces = {
      wg0 = {
        ips = [ "10.100.0.1/24" ];
        listenPort = 51820;
        postSetup = ''
          ${iptables} -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
        '';
        postShutdown = ''
          ${iptables} -t nat -D POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
        '';
        privateKeyFile = config.sops.secrets.private_key.path;
        peers = [
          {
            name = "cypher";
            publicKey = "CZvnEsivl9osBYtVmtGiu33fvkhlifMdTBWb+/xaEkE=";
            allowedIPs = [ "10.100.0.2/32" ];
          }
        ];
      };
    };
  };
}
