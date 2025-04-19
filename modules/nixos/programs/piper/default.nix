{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.piper;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    services.ratbagd.enable = true;
  };
}
