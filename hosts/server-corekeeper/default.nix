{
  modules.docker.enable = true;
  networking.firewall.allowedTCPPorts = [ 27016 ];
  services.homepage-dashboard.openFirewall = true;
}
