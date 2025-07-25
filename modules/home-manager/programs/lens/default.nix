{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.lens;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
