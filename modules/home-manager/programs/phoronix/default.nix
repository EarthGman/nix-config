{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.phoronix;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
