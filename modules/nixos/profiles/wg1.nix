# Secondary Wireguard client Setup
{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.wg1;
in
{
  options.profiles.wg1.enable = mkEnableOption "wg1";
  config = mkIf cfg.enable {
    sops.secrets.wg1_conf.path = "/etc/wireguard/wg1.conf";
    networking = {
      firewall.allowedUDPPorts = [ 51821 ];
      # work around the wireguard endpoint bug
      networkmanager.dispatcherScripts = [
        {
          source = pkgs.writeText "wg1hook" ''
            if [[ "$1" == "wg"* ]]; then
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
          autostart = false;
          configFile = config.sops.secrets.wg1_conf.path; # store whole file in secrets
        };
      };
    };
  };
}
