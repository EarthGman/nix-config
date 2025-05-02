{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.mcrcon;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
