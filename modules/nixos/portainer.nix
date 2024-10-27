{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkOption types mkIf optionals;
  cfg = config.services.portainer;
  initalize-script = pkgs.writeScriptBin "portainer-initalize" ''
      #!/usr/bin/env bash 
      docker volume create portainer_data ${if cfg.gui.enable then ''&&
      docker run -d \
      -p ${toString cfg.gui.port}:9443 \
      --name portainer \
      --restart=always \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v portainer_data:/data portainer/portainer-ce:2.21.1'' else ""} ${if cfg.agent.enable then ''&&
      docker run -d \
        -p ${toString cfg.agent.port}:9001 \
        --name portainer_agent \
        --restart=always \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /var/lib/docker/volumes:/var/lib/docker/volumes \
        -v /:/host \
        portainer/agent:2.21.1
    '' else ""}
  '';
in
{
  options.services.portainer = {
    gui = {
      enable = mkEnableOption "enable portainer, a gui for docker";
      port = mkOption {
        description = "https port for portainer";
        type = types.int;
        default = 9443;
      };
      openFirewall = mkEnableOption "open gui firewall";
    };
    agent = {
      enable = mkEnableOption "enable portainer agent";
      port = mkOption {
        description = "port for the portainer agent";
        type = types.int;
        default = 9001;
      };
    };
  };

  config = mkIf (cfg.gui.enable || cfg.agent.enable) {
    # issue a warning if docker is not enabled
    warnings =
      if !config.modules.docker.enable then
        [ "Portainer enabled without docker. Make sure to set option modules.docker.enable = true" ]
      else [ ];
    networking.firewall.allowedTCPPorts = [ ]
      ++ optionals cfg.gui.openFirewall [ cfg.gui.port ]
      ++ optionals cfg.agent.enable [ cfg.agent.port ];
    environment.systemPackages = [ initalize-script ];
  };
}
