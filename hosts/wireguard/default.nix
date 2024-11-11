{ pkgs, config, ... }:
let
  iptables = "${pkgs.iptables}/bin/iptables";
in
{
  users.users."root" = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNRHd6NLt4Yd9y5Enu54fJ/a2VCrRgbvfMuom3zn5zg"
    ];
  };

  nix.settings.trusted-users = [ "g" ];

  modules = {
    sops.enable = true;
  };

  sops.secrets.private_key.path = "/etc/wireguard/private_key";

  networking = {
    nat = {
      enable = true;
      externalInterface = "enp6s18";
      internalInterfaces = [ "wg0" ];
    };
    firewall.allowedUDPPorts = [ config.networking.wireguard.interfaces.wg0.listenPort ];
    wireguard.interfaces = {
      wg0 = {
        ips = [ "10.100.0.1/32" ];
        listenPort = 51820;
        postSetup = ''
          ${iptables} -t nat -A POSTROUTING -s 10.100.0.0/32 -o enp6s18 -j MASQUERADE
        '';
        postShutdown = ''
          ${iptables} -t nat -D POSTROUTING -s 10.100.0.0/32 -o enp6s18 -j MASQUERADE
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
