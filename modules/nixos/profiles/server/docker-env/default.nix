# basic env for a docker container with portainer agent
{ lib, config, ... }:
let
  inherit (lib) mkDefault mkEnableOption mkIf;
  cfg = config.profiles.server.docker-env;
in
{
  options.profiles.server.docker-env.enable = mkEnableOption "blank docker environment with portainer agent";
  config = mkIf cfg.enable {

    modules.docker.enable = true;

    services.portainer = {
      agent = {
        enable = mkDefault true;
      };
    };
  };
}
