{ inputs, pkgs, config, lib, ... }@args:
let
  cfg = config.modules.sops;
  inherit (lib) mkDefault mkIf mkEnableOption;
  secretsFile = if args ? secretsFile then args.secretsFile else null;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.modules.sops.enable = mkEnableOption "enable sops module";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ sops age ];
    sops = {
      defaultSopsFile = mkIf (secretsFile != null) secretsFile;
      defaultSopsFormat = "yaml";
      age = {
        keyFile = mkDefault "/var/lib/sops-nix/keys.txt";
      };
    };
  };
}
