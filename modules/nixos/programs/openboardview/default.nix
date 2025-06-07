{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.openboardview;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
