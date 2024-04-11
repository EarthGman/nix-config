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
    hostName = "cypher"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
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
