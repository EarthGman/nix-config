{ lib, config, ... }:
{
  options.gman.direnv.enable = lib.mkEnableOption "gman's direnv configuration";
  config = lib.mkIf (config.gman.direnv.enable) {
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
