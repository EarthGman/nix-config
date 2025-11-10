{
  pkgs,
  lib,
  config,
  ...
}:
let
  program-name = "lynx";
  cfg = config.programs.${program-name};
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
