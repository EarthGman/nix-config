{ pkgs, lib, config, ... }:
let
  inherit (lib) mkProgramOption mkIf;
  program-name = "hstr";
  cfg = config.programs.${program-name};
in
{
  options.programs.${program-name} = mkProgramOption {
    programName = program-name;
    description = "shell search history finder";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
