{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.suites.nix-development;
in
{
  options.gman.suites.nix-development.enable = lib.mkEnableOption "gman's nix development suite";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = import ../../../shared/mixins/nix-dev-packages.nix { inherit pkgs; };
  };
}
