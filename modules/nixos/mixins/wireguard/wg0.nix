{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.gman.wireguard.wg0;
in
{
  options.gman.wireguard.wg0.enable = mkEnableOption "gman's main wireguard hub";
  config = mkIf cfg.enable {
    sops.secrets.wg0_conf.path = "/etc/wireguard/wg0.conf";
    networking = {
      firewall.allowedUDPPorts = [ 51820 ];
      extraHosts = ''
        10.0.24.2 cypher
        10.0.24.3 think-one
        10.0.24.5 mc112
        10.0.24.6 mc112-blueprints
        10.0.24.8 home-nas
        10.0.24.32 prox2
      '';
      # work around the wireguard endpoint bug
      networkmanager.dispatcherScripts = [
        {
          source = pkgs.writeText "wg0hook" ''
            if [[ "$1" == "wg"* ]]; then
              exit 0
            fi

            if [ "$2" == "up" ]; then
              systemctl restart wg-quick-wg0
            fi
          '';
        }
      ];
      wg-quick.interfaces = {
        wg0 = {
          autostart = false;
          configFile = config.sops.secrets.wg0_conf.path; # store whole file in secrets
        };
      };
    };
  };
}
