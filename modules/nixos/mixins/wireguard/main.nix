{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.gman.wireguard.main;
in
{
  options.gman.wireguard.main.enable = mkEnableOption "gmans wireguard vpn";
  config = mkIf cfg.enable {
    sops.secrets.wg1_conf.path = "/etc/wireguard/wg1.conf";
    networking = {
      firewall.allowedUDPPorts = [ 51821 ];

      # static host mapping for peers
      extraHosts = ''
        10.0.25.2 cypher
        10.0.25.3 think-one

        192.168.25.32 prox2.home
        192.168.25.168 forgejo.home
        192.168.25.85 binary-cache.home
        192.168.25.93 jellyfin.home
        192.168.25.41 docker.home
        192.168.25.193 nas.home
        192.168.25.129 mc112
        192.168.25.200 mc112-blueprints
      '';
      # restart on network reconnect
      networkmanager.dispatcherScripts = [
        {
          source = pkgs.writeText "wireguard-hook" ''
            if [[ "$1" == "wg"* || "$1" == "virbr"* ]]; then
              exit 0
            fi

            if [ "$2" == "up" ]; then
              systemctl restart wg-quick-wg1
            fi
          '';
        }
      ];

      wg-quick.interfaces = {
        wg1 = {
          autostart = lib.mkDefault false;
          configFile = config.sops.secrets.wg1_conf.path; # store whole file in secrets
        };
      };
    };
  };
}
