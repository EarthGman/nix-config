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
    environment.systemPackages = import ../../../mixins/nix-dev-packages.nix { inherit pkgs; };

    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
    environment.variables = {
      DIRENV_WARN_TIMEOUT = 0;
    };
  };
}
