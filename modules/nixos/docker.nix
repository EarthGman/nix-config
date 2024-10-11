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
    # portainer
    networking.firewall.allowedTCPPorts = [
      8080
      9443
    ];
    # adds all users  to the docker group
    users.users = lib.genAttrs usernames {
      extraGroups = [ "docker" ];
    };
  };
}
