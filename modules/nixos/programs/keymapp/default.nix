{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.keymapp;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
