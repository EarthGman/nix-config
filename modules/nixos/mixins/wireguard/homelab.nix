{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.gman.wireguard.homelab;
in
{
  options.gman.wireguard.homelab.enable = mkEnableOption "homelab wireguard vpn";
  config = mkIf cfg.enable {
    sops.secrets.wg1_conf.path = "/etc/wireguard/wg1.conf";
    networking = {
      firewall.allowedUDPPorts = [ 51821 ];
      extraHosts = ''
        10.0.25.4 binary-cache
        10.0.25.5 home-nas
        10.0.25.6 mc112
        10.0.25.7 mc112-blueprints
        10.0.25.32 prox2
      '';

      wg-quick.interfaces = {
        wg1 = {
          autostart = lib.mkDefault false;
          configFile = config.sops.secrets.wg1_conf.path; # store whole file in secrets
        };
      };
    };
  };
}
