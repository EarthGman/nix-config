{
  modules.docker.enable = true;
  networking.firewall.allowedTCPPorts = [ 27016 ];

  programs.portainer = {
    enable = true;
    openFirewall = true;
  };

  users.users.g.extraGroups = [ "docker" ];
}
