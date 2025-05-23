{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.gparted;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
