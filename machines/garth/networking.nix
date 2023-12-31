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
    hostName = "garth"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    firewall = {
      checkReversePath = false;
      allowedTCPPorts = [
        22 # SSHD tellnet port
        443 # TLS/SSL listen port
        3389 # RDP Port
      ];
      allowedUDPPorts = [
        1194 # openvpn listen port
        5353 # printer discovery port
      ];
    };
  };
}
