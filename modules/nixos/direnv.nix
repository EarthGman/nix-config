{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkDefault mkIf;
in
{
  options.modules.direnv.enable = mkEnableOption "enable direnv";
  config = mkIf (config.modules.direnv.enable) {
    programs.direnv = {
      enable = mkDefault true;
      silent = mkDefault true;
      nix-direnv.enable = true;
    };
    environment.variables = {
      DIRENV_WARN_TIMEOUT = 0;
    };
  };
}
