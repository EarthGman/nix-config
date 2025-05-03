# basic env for a docker container with portainer agent
{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  modules.docker.enable = true;

  services.portainer = {
    agent = {
      enable = mkDefault true;
    };
  };
}
