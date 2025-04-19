{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.helvum;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
