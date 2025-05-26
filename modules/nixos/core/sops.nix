{ self, inputs, pkgs, config, lib, ... }@args:
let
  keyFile = "/var/lib/sops-nix/keys.txt";
  cfg = config.modules.sops;
  inherit (lib) mkDefault mkIf mkEnableOption;
  hostName = if args ? hostName then args.hostName else "";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.modules.sops.enable = mkEnableOption "enable sops module";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ sops age ];
    sops = {
      defaultSopsFile = mkIf (hostName != "") (mkDefault (self + /hosts/${hostName}/secrets.yaml));
      defaultSopsFormat = "yaml";
      age = {
        inherit keyFile;
      };
    };
  };
}
