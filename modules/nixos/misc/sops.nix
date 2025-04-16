{ self, inputs, pkgs, config, lib, hostName, ... }:
let
  keyFile = "/var/lib/sops-nix/keys.txt";
  cfg = config.modules.sops;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.modules.sops.enable = lib.mkEnableOption "enable sops module";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ sops age ];
    sops = {
      defaultSopsFile = lib.mkDefault (self + /hosts/${hostName}/secrets.yaml);
      defaultSopsFormat = "yaml";
      age = {
        inherit keyFile;
      };
    };
  };
}
