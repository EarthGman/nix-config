{
  services.sshd = {
    enable = true;
  };
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };
  # enables openVpn to resolve DNS hostnames
  services.resolved.enable = true;
  networking = {
    hostName = "cypher";
    networkmanager.enable = true;
    # required for sins of a solar empire lag bug in multiplayer
    extraHosts = ''66.79.209.80 ico-reb.stardock.com'';
    firewall = {
      checkReversePath = false;
      allowedTCPPorts = [
        22 # SSHD tellnet port
        443 # TLS/SSL listen port
        3389 # RDP port
      ];
      allowedUDPPorts = [
        1194 # openvpn listen port
        5353 # printer discovery port
      ];
    };
  };
}
