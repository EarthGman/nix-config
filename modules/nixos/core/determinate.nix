{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.determinate;
in
{
  options.modules.determinate.enable = mkEnableOption "determinate nix";

  config = mkIf cfg.enable {
    determinate.enable = true;

    nix.settings = {
      substituters = [ "https://install.determinate.systems/" ];
      trusted-public-keys = [ "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM=" ];
      lazy-trees = true;
    };
  };
}
