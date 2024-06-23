{ pkgs, ... }:
{
  imports = [
    ../../templates/prox-server
  ];
  environment.systemPackages = with pkgs; [
    jre8
  ];
}
