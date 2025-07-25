{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.lens;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
