{ inputs, pkgs, lib, hostname, users, self, ... }:
let
  keyFile = "/var/lib/sops-nix/keys.txt";
  usernames = builtins.filter builtins.isString (builtins.split "," users);
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    secrets = lib.genAttrs usernames (user: { neededForUsers = true; });
    defaultSopsFile = self + /secrets/${hostname}.yaml;
    defaultSopsFormat = "yaml";
    age = {
      inherit keyFile;
    };
  };
}
