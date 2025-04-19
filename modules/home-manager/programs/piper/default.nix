{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.piper;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
