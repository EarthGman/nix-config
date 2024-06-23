{ pkgs, ... }:
{
  imports = [
    ../../templates/prox-server
  ];

  networking.firewall.allowedTCPPorts = [ 25565 ];

  environment.systemPackages = with pkgs; [
    jre8
  ];
}
