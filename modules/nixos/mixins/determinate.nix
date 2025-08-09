{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.gman.determinate;
in
{
  options.gman.determinate.enable = mkEnableOption "gman's determinate nix module";

  config = mkIf cfg.enable {
    determinate.enable = lib.mkDefault true;

    nix.settings = {
      substituters = [ "https://install.determinate.systems/" ];
      trusted-public-keys = [ "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM=" ];
      lazy-trees = true;
    };
  };
}
