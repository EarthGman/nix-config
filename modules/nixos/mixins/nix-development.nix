{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.nix-development;
in
{
  options.gman.nix-development.enable = lib.mkEnableOption "gman's nix development suite";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = import ../../../templates/nix-dev-packages.nix { inherit pkgs; };
  };
}
