{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkProgramOption mkIf;
  program-name = "ncdu";
  cfg = config.programs.${program-name};
in
{
  options.programs.${program-name} = mkProgramOption {
    programName = program-name;
    description = "ncdu";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
