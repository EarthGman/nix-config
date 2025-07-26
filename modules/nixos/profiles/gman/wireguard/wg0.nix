# EarthGman's client wireguard setup.
{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.gman.wireguard.wg0;
in
{
  options.profiles.gman.wireguard.wg0.enable = mkEnableOption "wg0";
  config = mkIf cfg.enable {
    sops.secrets.wg0_conf.path = "/etc/wireguard/wg0.conf";
    networking = {
      firewall.allowedUDPPorts = [ 51820 ];
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
