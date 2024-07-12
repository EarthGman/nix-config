{ inputs, pkgs, hostname, ... }:
let
  keyFile = "/var/lib/sops-nix/keys.txt";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../../secrets/${hostname}.yaml;
    defaultSopsFormat = "yaml";
    age = {
      inherit keyFile;
    };
  };
}
