{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.programs.portainer;
  initalize-script = pkgs.writeScriptBin "portainer-initalize" ''
    #!/usr/bin/env bash
    docker volume create portainer_data &&
    docker run -d -p ${toString cfg.port}:${toString cfg.port} --name portainer --restart=always - v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.21.1
  '';
in
{
  options.programs.portainer = {
    enable = mkEnableOption "enable portainer a gui for docker and kubernetes";
    port = mkOption {
      description = "port for portainer";
      type = types.int;
      default = 9443;
    };
    openFirewall = mkEnableOption "open portainer firewall";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [
      (cfg.port)
    ];
    environment.systemPackages = [ initalize-script ];
  };
}
