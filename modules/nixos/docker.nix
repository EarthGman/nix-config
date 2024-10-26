{ lib, config, ... }:
# be sure to add your user to the docker group
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
    programs.portainer.enable = lib.mkDefault true;
  };
}
