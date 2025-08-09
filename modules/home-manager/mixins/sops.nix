{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.gman.sops;
in
{
  options.gman.sops.enable = lib.mkEnableOption "gman's sops-nix config";
  config = lib.mkIf cfg.enable {
    home.packages = builtins.attrValues {
      inherit (pkgs)
        sops
        age
        ;
    };

    sops = {
      defaultSopsFormat = lib.mkDefault "yaml";
      defaultSopsFile = lib.mkIf (config.meta.secretsFile != null) config.meta.secretsFile;
      age = {
        keyFile = lib.mkDefault "~/.config/sops/age/keys.txt";
      };
    };
  };
}
