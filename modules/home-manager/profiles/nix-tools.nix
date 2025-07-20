{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.profiles.nix-tools;
in
{
  options.profiles.nix-tools.enable = mkEnableOption "tools for nix packaging";

  config = mkIf cfg.enable {
    home.packages = import ../../shared/nix-tools-packages.nix { inherit pkgs; };
  };
}
