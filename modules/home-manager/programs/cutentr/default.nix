{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.cutentr;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
