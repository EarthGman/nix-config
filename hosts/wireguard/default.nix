# unused, much easier to just do this on the actual router. Saved for reference purposes
{ pkgs, config, keys, ... }:
let
  iptables = "${pkgs.iptables}/bin/iptables";
in
{
  users.users."root" = {
    openssh.authorizedKeys.keys = [ keys.g_pub ];
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
        ips = [ "10.0.0.1/24" ];
        listenPort = 51820;
        postSetup = ''
          ${iptables} -t nat -A POSTROUTING -s 10.0.0.0/24 -o enp6s18 -j MASQUERADE
        '';
        postShutdown = ''
          ${iptables} -t nat -D POSTROUTING -s 10.0.0.0/24 -o enp6s18 -j MASQUERADE
        '';
        privateKeyFile = config.sops.secrets.private_key.path;
        peers = [
          {
            name = "cypher";
            publicKey = keys.cypher_wireguard;
            allowedIPs = [ "10.0.0.2/32" ];
          }
        ];
      };
    };
  };
}
