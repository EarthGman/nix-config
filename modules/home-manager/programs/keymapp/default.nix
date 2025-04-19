{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.keymapp;
in
{
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
