{ myLib, lib, config, users, ... }:
let
  usernames = if (users != "") then myLib.splitToList users else [ ];
  power-user = builtins.elemAt usernames 0;
in
{
  options.custom.docker.enable = lib.mkEnableOption "enable docker module";
  config = lib.mkIf config.custom.docker.enable {
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
    # adds the first user in usernames (power user) to the docker group
    users.users.${power-user}.extraGroups = [ " docker" ];
  };
}
