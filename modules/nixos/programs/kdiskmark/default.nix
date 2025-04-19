{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.kdiskmark;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
