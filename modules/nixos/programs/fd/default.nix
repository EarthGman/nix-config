{ pkgs, lib, config, ... }:
let
  inherit (lib) mkProgramOption mkIf;
  program-name = "fd";
  cfg = config.programs.${program-name};
in
{
  options.programs.${program-name} = mkProgramOption {
    programName = program-name;
    description = "fd";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
