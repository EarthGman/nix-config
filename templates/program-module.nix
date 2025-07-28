{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkProgramOption mkIf;
  program-name = "program-name";
  cfg = config.programs.${program-name};
in
{
  options.programs.${program-name} = mkProgramOption {
    programName = program-name;
    description = "describe program-name";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
