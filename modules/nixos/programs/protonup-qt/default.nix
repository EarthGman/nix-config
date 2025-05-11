{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.protonup-qt;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
