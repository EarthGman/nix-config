{ pkgs, config, lib, ... }:
let
  cfg = config.modules.sops;
  inherit (lib) mkDefault mkIf mkEnableOption;
in
{
  options.modules.sops.enable = mkEnableOption "enable sops module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ sops age ];
    sops = {
      defaultSopsFormat = mkDefault "yaml";
      age = {
        keyFile = mkDefault "~/.config/sops/age/keys.txt";
      };
    };
  };
}
