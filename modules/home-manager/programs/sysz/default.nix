{ pkgs, lib, config, ... }:
let
  inherit (lib) mkProgramOption mkIf;
  program-name = "sysz";
  cfg = config.programs.${program-name};
in
{
  options.programs.${program-name} = mkProgramOption {
    programName = program-name;
    description = "systemd fuzzy finder";
    inherit pkgs;
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
