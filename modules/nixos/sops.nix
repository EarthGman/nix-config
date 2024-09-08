{ self, inputs, pkgs, config, lib, hostName, ... }:
let
  keyFile = "/var/lib/sops-nix/keys.txt";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.custom.sops.enable = lib.mkEnableOption "enable sops module";
  config = lib.mkIf config.custom.sops.enable {
    environment.systemPackages = with pkgs; [ sops age ];
    sops = {
      defaultSopsFile = self + /hosts/${hostName}/secrets.yaml;
      defaultSopsFormat = "yaml";
      age = {
        inherit keyFile;
      };
    };
  };
}
