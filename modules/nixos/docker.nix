{ myLib, lib, config, users, ... }:
let
  usernames = if (users != "") then myLib.splitToList users else [ ];
in
{
  options.modules.docker.enable = lib.mkEnableOption "enable docker module";
  config = lib.mkIf config.modules.docker.enable {
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    services.homepage-dashboard.enable = true;
    networking.firewall.allowedTCPPorts = lib.mkIf config.services.homepage-dashboard.openFirewall [
      (config.services.homepage-dashboard.listenPort)
    ];
    # adds all users  to the docker group
    users.users = lib.genAttrs usernames {
      extraGroups = [ "docker" ];
    };
  };
}
