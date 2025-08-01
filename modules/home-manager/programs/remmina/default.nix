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
    home.packages = [ cfg.package ];
  };
}
