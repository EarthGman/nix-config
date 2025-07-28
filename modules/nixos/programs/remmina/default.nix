{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.programs.remmina;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
