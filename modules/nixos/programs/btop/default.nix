{ pkgs, lib, config, ... }:
let
  inherit (lib) mkProgramOption mkIf;
  program-name = "btop";
  cfg = config.programs.${program-name};
in
{
  options.programs.${program-name} = mkProgramOption {
    programName = program-name;
    description = "btop, a better top";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
