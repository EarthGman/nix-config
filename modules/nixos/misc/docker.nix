{ lib, config, ... }:
# be sure to add your user to the docker group
{
  options.modules.docker.enable = lib.mkEnableOption "enable docker module";
  config = lib.mkIf config.modules.docker.enable {
    virtualisation.docker = {
      enable = true;
    };
  };
}
