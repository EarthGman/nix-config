{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkProgramOption mkIf;
  program-name = "jq";
  cfg = config.programs.${program-name};
in
{
  options.programs.${program-name} = mkProgramOption {
    programName = program-name;
    description = "jq";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
