{ inputs, pkgs, config, hostname, ... }:
let
  keyFile = "/var/lib/sops-nix/keys.txt";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    sops
    age
  ];

  sops = {
    defaultSopsFile = ../../../secrets/${hostname}.yaml;
    defaultSopsFormat = "yaml";
    age = {
      inherit keyFile;
      generateKey = true;
    };
  };
}
