{ inputs, pkgs, config, lib, hostname, users, self, ... }:
let
  keyFile = "/var/lib/sops-nix/keys.txt";
  usernames = builtins.filter builtins.isString (builtins.split "," users);
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.custom.sops-nix.enable = lib.mkEnableOption "enable sops module";
  config = lib.mkIf config.custom.sops-nix.enable {
    sops = {
      secrets = lib.genAttrs usernames (user: { neededForUsers = true; });
      defaultSopsFile = self + /secrets/${hostname}.yaml;
      defaultSopsFormat = "yaml";
      age = {
        inherit keyFile;
      };
    };
  };
}
