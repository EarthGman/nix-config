{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.protonmail-desktop;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
