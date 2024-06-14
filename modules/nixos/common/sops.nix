{ inputs, pkgs, config, hostname, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    sops
    age
  ];

  sops = {
    defaultSopsFile = ../../../hosts/${hostname}/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/var/lib/sops-nix/keys.txt";
    };
  };
}
