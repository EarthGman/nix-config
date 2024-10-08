# edited LuisChDev Nordvpn configuration
{ config, lib, pkgs, ... }:

with lib; {
  options.services.nordvpn.enable = mkOption {
    type = types.bool;
    default = false;
    description = mdDoc ''
      Whether to enable the NordVPN daemon. Note that you'll have to set
      `networking.firewall.checkReversePath = false;`, add UDP 1194
      and TCP 443 to the list of allowed ports in the firewall and add your
      user to the "nordvpn" group (`users.users.<username>.extraGroups`).
    '';
  };

  config = mkIf config.services.nordvpn.enable {
    environment.systemPackages = [ pkgs.nordvpn ];

    networking = {
      firewall = {
        checkReversePath = false;
        allowedTCPPorts = [ 443 ];
        allowedUDPPorts = [ 1194 ];
      };
    };

    users.groups.nordvpn = { };
    systemd = {
      services.nordvpn = {
        description = "NordVPN daemon.";
        serviceConfig = {
          ExecStart = ''
            ${pkgs.bash}/bin/bash -c '\
            ${pkgs.nordvpn}/bin/nordvpnd && ${pkgs.nordvpn}/bin/nordvpn connect || exit 1'
          '';
          ExecStartPre = ''
            ${pkgs.bash}/bin/bash -c '\
              mkdir -m 700 -p /var/lib/nordvpn; \
              if [ -z "$(ls -A /var/lib/nordvpn)" ]; then \
                cp -r ${pkgs.nordvpn}/var/lib/nordvpn/* /var/lib/nordvpn; \
              fi'
          '';
          NonBlocking = true;
          KillMode = "process";
          Restart = "on-failure";
          RestartSec = 5;
          RuntimeDirectory = "nordvpn";
          RuntimeDirectoryMode = "0750";
          Group = "nordvpn";
        };
        wantedBy = [ "multi-user.target" ];
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
      };
    };
  };
}
