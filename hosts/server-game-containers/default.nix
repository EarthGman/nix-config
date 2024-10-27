{
  modules.docker.enable = true;
  networking.firewall.allowedTCPPorts = [
    27016 # core keeper default port
  ];
  services.portainer.agent.enable = true;
  users.users.g.extraGroups = [ "docker" ];
  nix.settings.trusted-users = [ "g" ];
}
