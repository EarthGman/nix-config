{
  modules.docker.enable = true;
  networking.firewall.allowedTCPPorts = [ 27016 ];
  services.portainer.agent.enable = true;
  users.users.g.extraGroups = [ "docker" ];
}
